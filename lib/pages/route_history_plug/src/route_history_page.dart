import 'dart:async';
import 'package:flutter/material.dart';

import '../../../app_theme/theme.dart';
import '../../../toolkit.dart';

class RouteHistoryPage extends StatefulWidget {
  const RouteHistoryPage({super.key});

  @override
  State<RouteHistoryPage> createState() => _RouteHistoryPageState();
}

class _RouteHistoryPageState extends State<RouteHistoryPage> {
  final _observer = RouteHistoryObserver();
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    // 定时刷新界面
    _refreshTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  void _clearHistory() {
    setState(() {
      _observer.clearHistory();
    });
  }

  String _formatTimestamp(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}:'
        '${time.second.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('路由导航记录', style: context.f18MediumTextPrimary),
          bottom: TabBar(
            tabs: [
              Tab(text: '当前路由栈'),
              Tab(text: '历史记录'),
            ],
            labelStyle: context.f16MediumTextPrimary,
            unselectedLabelStyle: context.f16MediumTextTertiary,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: _clearHistory,
              tooltip: '清空历史',
            ),
          ],
        ),
        body: TabBarView(children: [_buildRouteStack(), _buildRouteHistory()]),
      ),
    );
  }

  Widget _buildRouteStack() {
    final stack = _observer.routeStack;

    if (stack.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.route, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              '暂无路由栈信息',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                '提示：需要在 MaterialApp 的 navigatorObservers 中添加 RouteHistoryObserver',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(
        top: 8,
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      itemCount: stack.length,
      itemBuilder: (context, index) {
        final routeItem = stack[index];
        final stackLevel = stack.length - index;

        return Card(
          color: context.appColor.backgroundInput,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                '$stackLevel',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(routeItem.name, style: context.f16BoldTextPrimary),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('深度: $index', style: context.f14MediumTextSecondary),
                Text(
                  '时间: ${_formatTimestamp(routeItem.timestamp)}',
                  style: context.f14MediumTextSecondary,
                ),
                if (routeItem.arguments != null)
                  Text(
                    '参数: ${routeItem.arguments}',
                    style: context.f14MediumTextSecondary,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRouteHistory() {
    final history = _observer.history;

    if (history.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.history, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              '暂无导航历史',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                '提示：需要在 MaterialApp 的 navigatorObservers 中添加 RouteHistoryObserver',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(
        top: 8,
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      itemCount: history.length,
      reverse: true,
      itemBuilder: (context, index) {
        final route = history[history.length - 1 - index];
        final icon = _getActionIcon(route.action);
        final color = _getActionColor(route.action);

        return Card(
          color: context.appColor.backgroundInput,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: Icon(icon, color: color),
            title: Text(route.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '操作: ${route.action} - ${_formatTimestamp(route.timestamp)}',
                ),
                if (route.arguments != null) Text('参数: ${route.arguments}'),
              ],
            ),
            trailing: Text(
              '${history.length - index}',
              style: context.f12BoldTextTips,
            ),
          ),
        );
      },
    );
  }

  IconData _getActionIcon(String action) {
    switch (action) {
      case 'Push':
        return Icons.arrow_forward;
      case 'Pop':
        return Icons.arrow_back;
      case 'Remove':
        return Icons.remove_circle_outline;
      case 'Replace':
        return Icons.swap_horiz;
      default:
        return Icons.help_outline;
    }
  }

  Color _getActionColor(String action) {
    switch (action) {
      case 'Push':
        return Colors.green;
      case 'Pop':
        return Colors.orange;
      case 'Remove':
        return Colors.red;
      case 'Replace':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
