part of '../nian_toolkit.dart';

class ErrorConfig {
  /// 是否启用错误收集
  bool? enable;

  /// 是否启用全局错误页面
  bool? enableErrorPage;

  /// 配置全局错误跳转页面key
  final GlobalKey<NavigatorState>? navigatorKey;

  /// 自定义发生错误时执行方法
  void Function(Object obj, StackTrace stackTrace)? customError;

  /// 【enable】是否启用错误收集
  ///
  /// 【enableErrorPage】是否启用全局错误页面,开启后 customError 不生效
  ///
  /// 【navigatorKey】配置全局错误跳转页面key
  ///
  /// 【customError】自定义发生错误时执行方法
  ErrorConfig({
    this.enable = true,
    this.enableErrorPage = true,
    this.navigatorKey,
    this.customError,
  });
}
