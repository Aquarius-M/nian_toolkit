part of 'nian_toolkit.dart';

class NianToolKit {
  /// 【app】主应用
  ///
  /// 【showKit】是否显示kit
  ///
  /// 【pluginsList】自定义插件列表

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

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this); // 注册监听器
    super.initState();
    _registerPlugins();

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
        RepaintBoundary(key: ToolkitKeys.rootKey, child: widget.child),
        MediaQuery(
          data: MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.implicitView!,
          ),
          child: ScaffoldMessenger(child: Overlay(key: ToolkitKeys.overlayKey)),
        ),
      ],
    );
    _child = layoutChild;
  }

  void _injectOverlay(bool isShow) {
    if (isShow) {
      // 确保overlay state存在
      if (ToolkitKeys.overlayKey.currentState != null) {
        _overlayEntry = OverlayEntry(
          canSizeOverlay: true,
          builder: (_) => Material(
            type: MaterialType.transparency,
            child: ToolKitMainPage(),
          ),
        );
        ToolkitKeys.overlayKey.currentState!.insert(_overlayEntry);
      }
    } else {
      if (_overlayEntry.mounted) {
        _overlayEntry.remove();
      }
    }
  }

  Future<void> _registerPlugins() async {
    await ToolKitPluginManager.instance.registerAll(widget.pluginsList ?? []);
    await ToolKitPluginManager.instance.registerAll(
      ToolKitPluginManager.instance.commonList,
    );
  }

  Future<void> reRegisterPlugins() async {
    ToolKitPluginManager.instance.clear();
    await _registerPlugins();
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
      theme: toolkitThemeData,
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
