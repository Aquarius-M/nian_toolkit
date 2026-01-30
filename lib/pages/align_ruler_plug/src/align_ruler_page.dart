import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app_theme/theme.dart';
import '../../../toolkit.dart';

class AlignRulerPage extends StatefulWidget {
  const AlignRulerPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AlignRulerPageState createState() => _AlignRulerPageState();
}

class _AlignRulerPageState extends State<AlignRulerPage> {
  Size _currentWindowSize =
      PlatformDispatcher.instance.views.first.physicalSize /
          PlatformDispatcher.instance.views.first.devicePixelRatio;
  final Size _dotSize = const Size(50, 50);
  Offset _dotPosition = Offset.zero;
  BorderRadius? _radius;
  late Offset _dotOffset;
  final TextStyle _fontStyle = const TextStyle(color: Colors.red, fontSize: 15);
  Size _textSize = Size.zero;
  double _toolBarY = 60.0;
  bool _switched = false;
  final InspectorSelection _selection =
      WidgetInspectorService.instance.selection;

  @override
  void initState() {
    _dotPosition = _currentWindowSize.center(Offset.zero);
    _radius = BorderRadius.circular(_dotSize.longestSide);
    _dotOffset = _dotSize.center(Offset.zero);
    super.initState();
    _textSize = _getTextSize();
    _selection.clear();
  }

  void _onPanUpdate(DragUpdateDetails dragDetails) {
    setState(() {
      _dotPosition = dragDetails.globalPosition;
    });
  }

  void _onPanEnd(DragEndDetails dragDetails) {
    if (!_switched) return;
    final RenderObject? overlayRender = context.findRenderObject();
    final List<RenderObject> objects = HitTest.hitTest(_dotPosition);
    final List<RenderObject> candidates = <RenderObject>[];
    for (final obj in objects) {
      if (overlayRender != null && _isDescendantOf(obj, overlayRender)) {
        continue;
      }
      candidates.add(obj);
    }
    _selection.candidates = candidates;
    Offset? offset;
    for (var obj in candidates) {
      var translation = obj.getTransformTo(null).getTranslation();
      Rect rect = obj.paintBounds.shift(Offset(translation.x, translation.y));
      if (rect.contains(_dotPosition)) {
        final double left = rect.left;
        final double right = rect.right;
        final double top = rect.top;
        final double bottom = rect.bottom;
        final double dx =
            (_dotPosition.dx - left).abs() <= (_dotPosition.dx - right).abs()
                ? left
                : right;
        final double dy =
            (_dotPosition.dy - top).abs() <= (_dotPosition.dy - bottom).abs()
                ? top
                : bottom;
        offset = Offset(dx, dy);
        break;
      }
    }
    if (offset == null) return;
    setState(() {
      _dotPosition = offset!;
      HapticFeedback.mediumImpact();
    });
  }

  bool _isDescendantOf(RenderObject object, RenderObject ancestor) {
    RenderObject? current = object;
    while (current != null) {
      if (current == ancestor) {
        return true;
      }
      final parent = current.parent;
      current = parent is RenderObject ? parent : null;
    }
    return false;
  }

  void _toolBarPanUpdate(DragUpdateDetails dragDetails) {
    final mediaQuery = MediaQuery.of(context);
    final minY = mediaQuery.padding.top;
    final maxY =
        (mediaQuery.size.height - kToolbarHeight - mediaQuery.padding.bottom)
            .clamp(minY, mediaQuery.size.height);
    final newY = (dragDetails.globalPosition.dy - 40).clamp(minY, maxY);
    setState(() {
      _toolBarY = newY.toDouble();
    });
  }

  Size _getTextSize() {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: '789.5', // for caculate size
        style: _fontStyle,
      ),
    );
    textPainter.layout();
    return Size(textPainter.width, textPainter.height);
  }

  void _switchChanged(bool swi) {
    setState(() {
      _switched = swi;
      if (!_switched) {
        _selection.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentWindowSize.isEmpty) {
      _currentWindowSize = MediaQuery.of(context).size;
      _dotPosition = _currentWindowSize.center(Offset.zero);
    }
    TextStyle style = TextStyle(
      fontSize: 17,
      color: context.appColor.textPrimary,
    );
    Widget toolBar = Material(
      color: context.appColor.backgroundInput,
      elevation: 6,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 26, right: 26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Left: ${_dotPosition.dx.toStringAsFixed(1)}',
                          style: style,
                        ),
                        const Padding(padding: EdgeInsets.only(top: 8)),
                        Text(
                          'Right: ${(_currentWindowSize.width - _dotPosition.dx).toStringAsFixed(1)}',
                          style: style,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Top: ${_dotPosition.dy.toStringAsFixed(1)}',
                          style: style,
                        ),
                        const Padding(padding: EdgeInsets.only(top: 8)),
                        Text(
                          'Bottom: ${(_currentWindowSize.height - _dotPosition.dy).toStringAsFixed(1)}',
                          style: style,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    // height: 18,
                    child: Switch.adaptive(
                      value: _switched,
                      onChanged: _switchChanged,
                      activeThumbColor: context.appColor.primary500,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        '开启后松手将会自动吸附至最近widget',
                        softWrap: true,
                        style: context.f16MediumTextPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    double verticalLeft = _dotPosition.dx - _textSize.width;
    double horizontalTop = _dotPosition.dy - _textSize.height;

    return Container(
      color: Colors.transparent,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: horizontalTop,
            left: _dotPosition.dx / 2 - _textSize.width / 2,
            child: Text(_dotPosition.dx.toStringAsFixed(1), style: _fontStyle),
          ),
          Positioned(
            left: verticalLeft,
            top: _dotPosition.dy / 2 - _textSize.height / 2,
            child: Text(_dotPosition.dy.toStringAsFixed(1), style: _fontStyle),
          ),
          Positioned(
            left: _dotPosition.dx +
                (_currentWindowSize.width - _dotPosition.dx) / 2 -
                _textSize.width / 2,
            top: horizontalTop,
            child: Text(
              (_currentWindowSize.width - _dotPosition.dx).toStringAsFixed(1),
              style: _fontStyle,
            ),
          ),
          Positioned(
            top: _dotPosition.dy +
                (_currentWindowSize.height - _dotPosition.dy) / 2 -
                _textSize.height / 2,
            left: verticalLeft,
            child: Text(
              (_currentWindowSize.height - _dotPosition.dy).toStringAsFixed(1),
              style: _fontStyle,
            ),
          ),
          Positioned(
            left: _dotPosition.dx,
            top: 0,
            child: Container(
              width: 1,
              height: _currentWindowSize.height,
              color: const Color(0xffff0000),
            ),
          ),
          Positioned(
            left: 0,
            top: _dotPosition.dy,
            child: Container(
              width: _currentWindowSize.width,
              height: 1,
              color: const Color(0xffff0000),
            ),
          ),
          Positioned(
            left: _dotPosition.dx - _dotOffset.dx,
            top: _dotPosition.dy - _dotOffset.dy,
            child: GestureDetector(
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
              child: Container(
                height: _dotSize.height,
                width: _dotSize.width,
                decoration: BoxDecoration(
                  borderRadius: _radius,
                  border: Border.all(
                    color: context.appColor.textPrimary,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Container(
                    height: _dotSize.width / 2.5,
                    width: _dotSize.height / 2.5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            top: _toolBarY,
            child: GestureDetector(
              onVerticalDragUpdate: _toolBarPanUpdate,
              child: toolBar,
            ),
          ),
          InspectorOverlay(
            selection: _selection,
            needDescription: false,
            needEdges: false,
          ),
        ],
      ),
    );
  }
}
