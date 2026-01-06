import 'package:flutter/material.dart';
import 'package:nian_toolkit/nian_toolkit.dart';
import 'icon.dart' as icon;

class PerformancePluggable extends StatefulWidget implements Pluggable {
  const PerformancePluggable({super.key});

  @override
  State<PerformancePluggable> createState() => _PerformancePluggableState();

  @override
  Widget buildWidget(BuildContext? context) => this;

  @override
  ImageProvider<Object> get iconImageProvider => MemoryImage(icon.iconBytes);

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
    setState(() {
      _overlayY = dragDetails.globalPosition.dy;
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
              width: MediaQuery.of(context).size.width,
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
