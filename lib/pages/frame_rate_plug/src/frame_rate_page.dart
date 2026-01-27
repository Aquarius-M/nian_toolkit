import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nian_toolkit/toolkit.dart';

import '../widget/performance_observer_widget.dart';

class FrameRatePage extends StatefulWidget {
  const FrameRatePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FrameRatePageState createState() => _FrameRatePageState();
}

class _FrameRatePageState extends State<FrameRatePage> {
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
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }
}
