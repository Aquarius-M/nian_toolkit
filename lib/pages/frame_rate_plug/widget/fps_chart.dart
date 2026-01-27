import 'dart:io';

import 'package:flutter/material.dart';

import 'fps_info.dart';

double kPerBarHeightRatio = 2.5;

class BarChartPainter extends CustomPainter {
  List<FpsInfo> datas;

  BarChartPainter({required this.datas});

  @override
  bool shouldRepaint(BarChartPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(BarChartPainter oldDelegate) => false;

  void _drawAxis(Canvas canvas, Size size) {
    final double sw = size.width;
    final double sh = size.height;

    // 使用 Paint 定义路径的样式
    final Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    // 使用 Path 定义绘制的路径，从画布的左上角到左下角在到右下角
    final Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, sh)
      ..lineTo(sw, sh);

    // 使用 drawPath 方法绘制路径
    canvas.drawPath(path, paint);
  }

  // void _drawLabels(Canvas canvas, Size size) {
  //   double labelFontSize = 10;
  //   final double sh = size.height;
  //   final List<double> yAxisLabels = [];

  //   yAxisLabels.add(10);
  //   yAxisLabels.add(20);
  //   yAxisLabels.add(30);
  //   yAxisLabels.add(40);
  //   yAxisLabels.add(50);
  //   yAxisLabels.add(60);
  //   yAxisLabels.add(70);
  //   yAxisLabels.add(80);

  //   yAxisLabels.asMap().forEach(
  //     (index, label) {
  //       // 标识的高度为画布高度减去标识的值
  //       final double top = sh - label * kPerBarHeightRatio;
  //       // final rect = Rect.fromLTWH(0, top, 4, 1);
  //       final Offset textOffset = Offset(
  //         -20.toDouble(),
  //         top - labelFontSize / 2,
  //       );

  //       // 绘制文字需要用 `TextPainter`，最后调用 paint 方法绘制文字
  //       TextPainter(
  //         text: TextSpan(
  //           text: label.toStringAsFixed(0),
  //           style: TextStyle(
  //             fontSize: labelFontSize,
  //             color: const Color(0xff4a4b5b),
  //           ),
  //         ),
  //         textAlign: TextAlign.end,
  //         textDirection: TextDirection.ltr,
  //         // textWidthBasis: TextWidthBasis.longestLine,
  //       )
  //         ..layout(minWidth: 0, maxWidth: 24)
  //         ..paint(canvas, textOffset);
  //     },
  //   );
  // }

  @override
  void paint(Canvas canvas, Size size) {
    _drawAxis(canvas, size);
    // _drawLabels(canvas, size);
  }
}

class FpsBarChart extends StatefulWidget {
  final List<FpsInfo> data;

  const FpsBarChart({
    super.key,
    required this.data,
  });

  @override
  // ignore: library_private_types_in_public_api
  _FpsBarChartState createState() => _FpsBarChartState();
}

class _FpsBarChartState extends State<FpsBarChart>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 32;
    double height =
        MediaQuery.of(context).size.height - (Platform.isAndroid ? 600 : 700);
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.only(top: 30, left: 0),
      child: Stack(
        children: <Widget>[
          CustomPaint(
            size: Size(width, height),
            foregroundPainter: BarChartPainter(datas: widget.data),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: _histogramWidget(width, height),
          )
        ],
      ),
    );
  }

  Widget _histogramWidget(double width, double height) {
    return SizedBox(
      width: width,
      height: height - 24,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          int value = widget.data[index].getValue().toInt();
          return Container(
            width: 10,
            padding: EdgeInsets.only(
              top: height - 24 - value * kPerBarHeightRatio.toDouble() < 0
                  ? 0
                  : height - 24 - value * kPerBarHeightRatio.toDouble(),
            ),
            child: Container(
              color: value <= 18
                  ? const Color(0xff55a8fd)
                  : value <= 33
                      ? const Color(0xfffad337)
                      : value <= 66
                          ? const Color(0xFFF48FB1)
                          : const Color(0xFFD32F2F),
              child: value >= 3
                  ? Align(
                      child: Text(
                        "$value",
                        style: const TextStyle(
                          fontSize: 6,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          );
        },
        itemCount: widget.data.length,
        // itemExtent: 20,
      ),
    );
  }
}
