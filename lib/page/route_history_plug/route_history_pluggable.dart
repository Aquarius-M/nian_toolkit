part of '../../nian_toolkit.dart';

/// 路由历史观察器 - 全局单例
class RouteHistoryObserver extends NavigatorObserver {
  static final RouteHistoryObserver _instance =
      RouteHistoryObserver._internal();
  factory RouteHistoryObserver() => _instance;
  RouteHistoryObserver._internal();

  final List<RouteInfo> _history = [];
  final List<RouteStackItem> _routeStack = [];

  List<RouteInfo> get history => List.unmodifiable(_history);
  List<RouteStackItem> get routeStack => List.unmodifiable(_routeStack);

  void clearHistory() {
    _history.clear();
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _addRoute(route, 'Push');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _removeRoute(route);
    _addRouteToHistory(route, 'Pop');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    _removeRoute(route);
    _addRouteToHistory(route, 'Remove');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (oldRoute != null) {
      _removeRoute(oldRoute);
    }
    if (newRoute != null) {
      _addRoute(newRoute, 'Replace');
    }
  }

  void _addRoute(Route<dynamic> route, String action) {
    final name = _getRouteName(route);
    final routeId = route.hashCode;

    // 添加到路由栈
    _routeStack.add(
      RouteStackItem(
        id: routeId,
        name: name,
        timestamp: DateTime.now(),
        arguments: route.settings.arguments,
      ),
    );

    // 添加到历史记录
    _addRouteToHistory(route, action);
  }

  void _removeRoute(Route<dynamic> route) {
    final routeId = route.hashCode;

    // 从路由栈中移除对应的路由
    _routeStack.removeWhere((item) => item.id == routeId);
  }

  void _addRouteToHistory(Route<dynamic> route, String action) {
    final name = _getRouteName(route);

    _history.add(
      RouteInfo(
        name: name,
        timestamp: DateTime.now(),
        arguments: route.settings.arguments,
        action: action,
      ),
    );

    // 只保留最近100条记录
    if (_history.length > 100) {
      _history.removeAt(0);
    }
  }

  String _getRouteName(Route<dynamic> route) {
    return route.settings.name ?? '未命名路由 #${route.hashCode}';
  }
}

class RouteHistoryPluggable extends StatefulWidget implements Pluggable {
  const RouteHistoryPluggable({super.key});

  @override
  Widget? buildWidget(BuildContext? context) => this;

  @override
  Widget? iconWidget() => PluginIcons.routeHistory;

  @override
  String get name => '路由记录';

  @override
  int get index => 9986;

  @override
  void onTrigger() {}

  @override
  State<RouteHistoryPluggable> createState() => _RouteHistoryPluggableState();
}

class _RouteHistoryPluggableState extends State<RouteHistoryPluggable> {
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
          title: const Text('路由导航记录'),
          bottom: const TabBar(
            tabs: [
              Tab(text: '当前路由栈'),
              Tab(text: '历史记录'),
            ],
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
      itemCount: stack.length,
      itemBuilder: (context, index) {
        final routeItem = stack[index];
        final stackLevel = stack.length - index;

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                '$stackLevel',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              routeItem.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('深度: $index'),
                Text('时间: ${_formatTimestamp(routeItem.timestamp)}'),
                if (routeItem.arguments != null)
                  Text('参数: ${routeItem.arguments}'),
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
      itemCount: history.length,
      reverse: true,
      itemBuilder: (context, index) {
        final route = history[history.length - 1 - index];
        final icon = _getActionIcon(route.action);
        final color = _getActionColor(route.action);

        return ListTile(
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
            style: const TextStyle(color: Colors.grey),
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

class RouteInfo {
  final String name;
  final DateTime timestamp;
  final Object? arguments;
  final String action;

  RouteInfo({
    required this.name,
    required this.timestamp,
    this.arguments,
    required this.action,
  });
}

class RouteStackItem {
  final int id;
  final String name;
  final DateTime timestamp;
  final Object? arguments;

  RouteStackItem({
    required this.id,
    required this.name,
    required this.timestamp,
    this.arguments,
  });
}
