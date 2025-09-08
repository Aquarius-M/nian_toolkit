part of 'nian_toolkit.dart';

class NianToolKit {
  /// 【pluginsList】自定义插件列表
  ///
  /// 【logConfig】日志服务配置，控制台输出只在debug模式下输出
  ///
  /// 【errorConfig】错误配置，包含方法错误，页面错误

  static void run(
    /// 主应用
    Widget app, {

    /// 是否显示kit
    bool showKit = true,

    /// 自定义插件列表
    final List<Pluggable>? pluginsList,
  }) {
    return runApp(
      ToolKitWidget(pluginsList: pluginsList, showKit: showKit, child: app),
    );
  }
}

class ToolKitWidget extends StatefulWidget {
  /// 自定义插件列表
  final List<Pluggable>? pluginsList;

  final Widget child;

  final bool showKit;

  const ToolKitWidget({
    super.key,
    this.pluginsList,
    required this.child,
    required this.showKit,
  });

  @override
  State<ToolKitWidget> createState() => _ToolKitWidgetState();
}

/// Hold the [_devKitState] as a global variable.
_ToolKitWidgetState? _devKitState;

class _ToolKitWidgetState extends State<ToolKitWidget>
    with WidgetsBindingObserver {
  _ToolKitWidgetState() {
    // 确保只有单个
    assert(_devKitState == null, '同时只能使用一个ToolKit。');
    if (_devKitState != null) {
      throw StateError('同时只能使用一个ToolKit。');
    }
    _devKitState = this;
  }

  late Widget _child;

  OverlayEntry _overlayEntry = OverlayEntry(
    builder: (_) => const SizedBox.shrink(),
  );

  // 初始化默认插件
  List<Pluggable> commonPluginsList = [
    const ProxyPlugable(),
    const DioPlugable(),
    const FrameRatePluggable(),
    const RegularPluggable(),
    const ApplogPluggable(),
    const AppInfoPluggable(),
    const DatabasePluggable(),
    if (kDebugMode) const WidgetInfoPluggable(),
    if (kDebugMode) const WidgetDetailPluggable(),
    const AlignRulerPluggable(),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this); // 注册监听器
    super.initState();
    ToolKitPluginManager.instance.registerAll(widget.pluginsList ?? []).then((
      value,
    ) {
      ToolKitPluginManager.instance.registerAll(commonPluginsList);
    });

    _replaceChild();
    // 延迟到下一帧执行，确保overlay已经准备好
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _injectOverlay(widget.showKit);
    });
  }

  @override
  void didUpdateWidget(ToolKitWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _replaceChild() {
    Widget layoutChild = Stack(
      children: <Widget>[
        RepaintBoundary(key: _rootKey, child: widget.child),
        MediaQuery(
          data: MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.implicitView!,
          ),
          child: ScaffoldMessenger(child: Overlay(key: _overlayKey)),
        ),
      ],
    );
    _child = layoutChild;
  }

  void _injectOverlay(bool isShow) {
    if (isShow) {
      // 确保overlay state存在
      if (_overlayKey.currentState != null) {
        _overlayEntry = OverlayEntry(
          canSizeOverlay: true,
          builder: (_) => Material(
            type: MaterialType.transparency,
            child: ToolKitMainPage(),
          ),
        );
        _overlayKey.currentState!.insert(_overlayEntry);
      }
    } else {
      if (_overlayEntry.mounted) {
        _overlayEntry.remove();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    // Do the cleaning at last.
    _devKitState = null;
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _devThemeData,
      builder: (context, child) {
        return Material(
          // 添加 Material widget
          type: MaterialType.transparency,
          child: MediaQuery(
            ///设置文字大小不随系统设置改变
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: const TextScaler.linear(1.0)),
            child: GestureDetector(
              onTap: () {
                /// 隐藏键盘
                SystemChannels.textInput.invokeMethod('TextInput.hide');

                ///设置点击空白取消焦点
                FocusScopeNode focus = FocusScope.of(context);
                if (!focus.hasPrimaryFocus && focus.focusedChild != null) {
                  FocusManager.instance.primaryFocus!.unfocus();
                }
              },
              child: child,
            ),
          ),
        );
      },
      home: _child,
    );
  }
}
