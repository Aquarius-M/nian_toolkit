part of '../../nian_toolkit.dart';

class FrameRatePluggable extends StatefulWidget implements Pluggable {
  /// 展示性能监控数据
  static bool debugShowPerformanceMonitor = true;

  const FrameRatePluggable({super.key});

  /// Creates a widget that enables inspection for the child.
  ///
  /// The [child] argument must not be null.

  @override
  // ignore: library_private_types_in_public_api
  _FrameRatePluggableState createState() => _FrameRatePluggableState();

  @override
  ImageProvider<Object> get iconImageProvider =>
      MemoryImage(frameRateIconBytes);

  @override
  void onTrigger() {}

  @override
  String get name => "帧率";

  @override
  int get index => 9989;

  @override
  Widget? buildWidget(BuildContext? context) => this;
}

class _FrameRatePluggableState extends State<FrameRatePluggable> {
  /// Distance from the edge of the bounding box for an element to consider
  /// as selecting the edge of the bounding box.

  final InspectorSelection selection =
      WidgetInspectorService.instance.selection;

  final Size _dotSize = const Size(130.0, 65.0);
  double _dx = KitUtils.deviceWidth - 130 - 10.0;
  double _dy = Platform.isIOS
      ? PlatformDispatcher.instance.views.first.padding.top - kToolbarHeight
      : PlatformDispatcher.instance.views.first.padding.top;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget performanceObserver = PerformanceObserverWidget(
      PlatformDispatcher.instance.views.first,
      dragEnd,
      dragEvent,
    );
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: <Widget>[
        Positioned(left: _dx, top: _dy, child: performanceObserver),
      ],
    );
  }

  void dragEvent(DragUpdateDetails details) {
    _dx = details.globalPosition.dx - _dotSize.width / 2;
    _dy = details.globalPosition.dy - _dotSize.height / 2;
    setState(() {});
  }

  void dragEnd(DragEndDetails details) {
    if (_dx + _dotSize.width / 2 < KitUtils.deviceWidth / 2) {
      _dx = _margin;
    } else {
      _dx = KitUtils.deviceWidth - _dotSize.width - _margin * 2;
    }
    if (_dy + _dotSize.height > KitUtils.deviceHeight) {
      _dy = KitUtils.deviceHeight - _dotSize.height - _margin * 2;
    } else if (_dy < 0) {
      _dy = _margin;
    }
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }
}
