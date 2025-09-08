part of '../../nian_toolkit.dart';

class WidgetInfoPluggable extends StatefulWidget implements Pluggable {
  const WidgetInfoPluggable({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WidgetInfoPluggableState createState() => _WidgetInfoPluggableState();

  @override
  Widget buildWidget(BuildContext? context) => this;

  @override
  int get index => 3;

  @override
  String get name => '组件信息';

  @override
  void onTrigger() {}

  @override
  ImageProvider<Object> get iconImageProvider =>
      MemoryImage(widgetInfoIconBytes);
}

class _WidgetInfoPluggableState extends State<WidgetInfoPluggable>
    with WidgetsBindingObserver {
  _WidgetInfoPluggableState()
    : selection = WidgetInspectorService.instance.selection;

  final window = _flutterView;

  Offset? _lastPointerLocation;
  OverlayEntry _overlayEntry = OverlayEntry(builder: (ctx) => Container());

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

  void _handlePanDown(DragDownDetails event) {
    _lastPointerLocation = event.globalPosition;
    _inspectAt(event.globalPosition);
  }

  void _handlePanEnd(DragEndDetails details) {
    final Rect bounds =
        (Offset.zero & (window.physicalSize / window.devicePixelRatio)).deflate(
          1.0,
        );
    if (!bounds.contains(_lastPointerLocation!)) {
      setState(() {
        selection.clear();
      });
    }
  }

  void _handleTap() {
    if (_lastPointerLocation != null) {
      _inspectAt(_lastPointerLocation);
    }
  }

  @override
  void initState() {
    super.initState();
    selection.clear();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _overlayEntry = OverlayEntry(builder: (_) => const _DebugPaintButton());
      _overlayKey.currentState?.insert(_overlayEntry);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = <Widget>[];
    GestureDetector gesture = GestureDetector(
      onTap: _handleTap,
      onPanDown: _handlePanDown,
      onPanEnd: _handlePanEnd,
      behavior: HitTestBehavior.opaque,
      child: IgnorePointer(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
    children.add(gesture);
    children.add(InspectorOverlay(selection: selection));
    return Stack(textDirection: TextDirection.ltr, children: children);
  }

  @override
  void dispose() {
    super.dispose();
    if (_overlayEntry.mounted) {
      _overlayEntry.remove();
    }
  }
}

class _DebugPaintButton extends StatefulWidget {
  const _DebugPaintButton();

  @override
  State<StatefulWidget> createState() => _DebugPaintButtonState();
}

class _DebugPaintButtonState extends State<_DebugPaintButton> {
  @override
  void initState() {
    super.initState();
  }

  // 获取主页面logoWidget的位置
  Offset _getFollowPosition() {
    // 默认位置
    return Offset(
      _windowSize.width - _dotSize.width - _margin,
      _windowSize.height - (5 * _dotSize.height) - 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    final position = _getFollowPosition();

    return Positioned(
      left: position.dx,
      top: position.dy,
      child: SizedBox(
        width: _dotSize.width,
        height: _dotSize.width,
        child: FloatingActionButton(
          elevation: 1,
          onPressed: _showAllSize,
          child: const Icon(Icons.all_out_sharp),
        ),
      ),
    );
  }

  void _showAllSize() async {
    debugPaintSizeEnabled = !debugPaintSizeEnabled;
    setState(() {
      late RenderObjectVisitor visitor;
      visitor = (RenderObject child) {
        child.markNeedsPaint();
        child.visitChildren(visitor);
      };
      WidgetsBinding.instance.renderViews
          .where((RenderView v) => v.flutterView == _flutterView)
          .firstOrNull!
          .visitChildren(visitor);
    });
  }

  @override
  void dispose() {
    super.dispose();
    debugPaintSizeEnabled = false;
    RendererBinding.instance.addPostFrameCallback((timeStamp) {
      late RenderObjectVisitor visitor;
      visitor = (RenderObject child) {
        child.markNeedsPaint();
        child.visitChildren(visitor);
      };
      WidgetsBinding.instance.renderViews
          .where((RenderView v) => v.flutterView == _flutterView)
          .firstOrNull!
          .visitChildren(visitor);
    });
  }
}
