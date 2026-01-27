part of '../../toolkit.dart';

class WidgetInfoPluggable extends StatefulWidget implements Pluggable {
  const WidgetInfoPluggable({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WidgetInfoPluggableState createState() => _WidgetInfoPluggableState();

  @override
  Widget buildWidget(BuildContext? context) => this;

  @override
  int get index => 9994;

  @override
  String get name => '组件信息';

  @override
  void onTrigger() {}

  @override
  Widget? iconWidget() => PluginIcons.widgetInfo;
}

class _WidgetInfoPluggableState extends State<WidgetInfoPluggable>
    with WidgetsBindingObserver {
  _WidgetInfoPluggableState()
    : selection = WidgetInspectorService.instance.selection;

  final window = PlatformDispatcher.instance.views.first;

  Offset? lastPointerLocation;
  bool _debugPaintEnabled = false;
  DateTime? _lastTapTime;

  final InspectorSelection selection;

  void _inspectAt(Offset? position) {
    final List<RenderObject> selected = HitTest.hitTest(
      position,
      edgeHitMargin: 2.0,
    );
    setState(() {
      selection.candidates = selected;
    });
  }

  // 双击切换布局边界显示
  void _handleDoubleTap() {
    setState(() {
      _debugPaintEnabled = !_debugPaintEnabled;
      debugPaintSizeEnabled = _debugPaintEnabled;

      // 刷新渲染
      late RenderObjectVisitor visitor;
      visitor = (RenderObject child) {
        child.markNeedsPaint();
        child.visitChildren(visitor);
      };
      WidgetsBinding.instance.renderViews
          .where(
            (RenderView v) =>
                v.flutterView == PlatformDispatcher.instance.views.first,
          )
          .firstOrNull!
          .visitChildren(visitor);
    });
  }

  @override
  void initState() {
    super.initState();
    selection.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      textDirection: TextDirection.ltr,
      children: [
        // 使用 Listener 代替 GestureDetector，避免创建额外的渲染层
        Positioned.fill(
          child: Listener(
            behavior: HitTestBehavior.opaque,
            onPointerDown: (event) {
              lastPointerLocation = event.position;
              _inspectAt(event.position);
            },
            onPointerMove: (event) {
              lastPointerLocation = event.position;
              _inspectAt(event.position);
            },
            onPointerUp: (event) {
              // 检查是否在边界外松手
              final Rect bounds =
                  (Offset.zero &
                          (window.physicalSize / window.devicePixelRatio))
                      .deflate(1.0);
              if (!bounds.contains(event.position)) {
                setState(() {
                  selection.clear();
                });
              }

              // 检测双击（300ms内）
              final now = DateTime.now();
              final lastTapTime = _lastTapTime;
              _lastTapTime = now;

              if (lastTapTime != null &&
                  now.difference(lastTapTime).inMilliseconds < 300) {
                _handleDoubleTap();
              }
            },
            // 不需要 child，Listener 自己就能占据整个 Positioned.fill 区域
          ),
        ),
        InspectorOverlay(selection: selection),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    // 恢复布局边界显示状态
    if (_debugPaintEnabled) {
      debugPaintSizeEnabled = false;
      late RenderObjectVisitor visitor;
      visitor = (RenderObject child) {
        child.markNeedsPaint();
        child.visitChildren(visitor);
      };
      WidgetsBinding.instance.renderViews
          .where(
            (RenderView v) =>
                v.flutterView == PlatformDispatcher.instance.views.first,
          )
          .firstOrNull!
          .visitChildren(visitor);
    }
  }
}
