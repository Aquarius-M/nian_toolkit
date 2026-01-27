import 'package:flutter/material.dart';
import 'package:nian_toolkit/toolkit.dart';
import 'package:nian_toolkit/icons/plugin_icons.dart';

class PerformancePluggable extends StatefulWidget implements Pluggable {
  const PerformancePluggable({super.key});

  @override
  State<PerformancePluggable> createState() => _PerformancePluggableState();

  @override
  Widget buildWidget(BuildContext? context) => this;

  @override
  Widget? iconWidget() => PluginIcons.performance;

  @override
  String get name => '性能';

  @override
  void onTrigger() {}

  @override
  int get index => 9992;
}

class _PerformancePluggableState extends State<PerformancePluggable> {
  double _overlayY = 60.0;

  void _overlayPanUpdate(DragUpdateDetails dragDetails) {
    final mediaQuery = MediaQuery.of(context);
    final minY = mediaQuery.padding.top;
    final maxY =
        (mediaQuery.size.height - kToolbarHeight - mediaQuery.padding.bottom)
            .clamp(minY, mediaQuery.size.height);
    final newY = dragDetails.globalPosition.dy.clamp(minY, maxY);
    setState(() {
      _overlayY = newY.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          left: 0,
          top: _overlayY,
          child: GestureDetector(
            onVerticalDragUpdate: _overlayPanUpdate,
            child: Container(
              width: MediaQuery.of(context).size.width - 32,
              margin: const EdgeInsets.only(left: 16, right: 16),
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: PerformanceOverlay.allEnabled(),
            ),
          ),
        ),
      ],
    );
  }
}
