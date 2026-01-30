import 'package:flutter/material.dart';

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
