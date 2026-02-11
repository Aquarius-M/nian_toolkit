part of '../toolkit.dart';

class ToolKitPluginManager {
  static ToolKitPluginManager? _instance;

  Map<String, Pluggable?> get pluginsMap => _pluginsMap;

  final Map<String, Pluggable?> _pluginsMap = {};

  Pluggable? _activatedPluggable;
  String? get activatedPluggableName => _activatedPluggable?.name;

  static ToolKitPluginManager get instance {
    _instance ??= ToolKitPluginManager._();
    return _instance!;
  }

  ToolKitPluginManager._();

  // 初始化默认插件
  List<Pluggable> commonList = [
    //9999 代理
    const ProxyPlugable(),
    //9998 网络请求
    const DioPluggable(),
    //9997 日志
    const ApplogPluggable(),
    //9996 设备信息
    const AppInfoPluggable(),
    //9987 文件管理器
    const FileManagerPluggable(),
    //9986 路由记录
    const RouteHistoryPluggable(),
    //9995 数据库
    const DatabasePluggable(),
    // const ShowCodePluggable(),
    //9994 组件信息
    if (kDebugMode) const WidgetInfoPluggable(),
    //9993 组件详情
    if (kDebugMode) const WidgetDetailPluggable(),
    //9992 性能
    const PerformancePluggable(),
    //9991 正则
    const RegularPluggable(),
    //9990 颜色选择器
    const ColorPickerPluggable(scale: 5, size: Size(70, 70)),

    // const ColorPicker(),
    //9989 帧率
    const FrameRatePluggable(),
    //9988 对齐尺子
    const AlignRulerPluggable(),
  ];

  void clear() {
    _pluginsMap.clear();
    _activatedPluggable = null;
  }

  /// Register a single [plugin]
  Future register(Pluggable plugin) async {
    if (plugin.name.isEmpty) {
      return;
    }
    _pluginsMap[plugin.name] = plugin;
  }

  /// Register multiple [plugins]
  Future registerAll(List<Pluggable> plugins) async {
    for (final plugin in plugins) {
      await register(plugin);
    }
  }

  void activatePluggable(Pluggable pluggable) {
    _activatedPluggable = pluggable;
  }

  void deactivatePluggable(Pluggable pluggable) {
    if (_activatedPluggable?.name == pluggable.name) {
      _activatedPluggable = null;
    }
  }
}
