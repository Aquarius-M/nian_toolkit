import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../app_theme/app_color.dart';
import '../../../app_theme/app_theme.dart';
import 'collection_util.dart';
import 'fps_info.dart';
import 'fps_widget.dart';

class PerformanceObserverWidget extends StatefulWidget {
  const PerformanceObserverWidget(
    this.view,
    this.onDragEnd,
    this.onDragUpdate, {
    super.key,
  });

  final FlutterView view;
  final void Function(DragEndDetails details) onDragEnd;
  final void Function(DragUpdateDetails details) onDragUpdate;

  @override
  // ignore: library_private_types_in_public_api
  _PerformanceObserverWidgetState createState() =>
      _PerformanceObserverWidgetState();
}

class _PerformanceObserverWidgetState extends State<PerformanceObserverWidget> {
  bool startRecording = false;
  bool fpsPageShowing = false;

  ValueNotifier? controller;
  OverlayEntry? fpsInfoPage;

  double currentFps = 0.0;

  @override
  void initState() {
    super.initState();
    controller = ValueNotifier("");
  }

  void onTimings(List<FrameTiming> timings) {
    double duration = 0;
    for (var element in timings) {
      FrameTiming frameTiming = element;
      duration = frameTiming.totalSpan.inMilliseconds.toDouble();
      FpsInfo fpsInfo = FpsInfo();
      fpsInfo.totalSpan = max(0, duration);
      CommonStorage.instance.save(fpsInfo);
      currentFps = fpsInfo.totalSpan ?? 0;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    if (controller!.value != "") {
      stop();
    }
    super.dispose();
  }

  void start() {
    WidgetsBinding.instance.addTimingsCallback(onTimings);
  }

  void stop() {
    WidgetsBinding.instance.removeTimingsCallback(onTimings);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            fpsMonitor();
          },
          onVerticalDragEnd: widget.onDragEnd,
          onHorizontalDragEnd: widget.onDragEnd,
          onHorizontalDragUpdate: widget.onDragUpdate,
          onVerticalDragUpdate: widget.onDragUpdate,
          child: RepaintBoundary(
            child: ValueListenableBuilder(
              valueListenable: controller!,
              builder: (context, snapshot, _) {
                return Container(
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    //设置四周圆角 角度
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    //设置四周边框
                    border: Border.all(
                      width: 2,
                      color: context.appColor.textPrimary,
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                  child: !startRecording
                      ? const Row(
                          children: <Widget>[
                            Text(
                              '开始监听FPS',
                              style: TextStyle(
                                fontSize: 16,
                                // color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Icon(Icons.play_arrow),
                          ],
                        )
                      : fpsPageShowing
                      ? const Row()
                      : const Row(
                          children: <Widget>[
                            Text(
                              '结束监听FPS',
                              style: TextStyle(
                                fontSize: 16,
                                // color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Icon(Icons.pause),
                          ],
                        ),
                );
              },
            ),
          ),
        ),
        startRecording
            ? Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  "$currentFps",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: currentFps <= 18
                        ? Colors.green
                        : currentFps <= 33
                        ? const Color(0xfffad337)
                        : currentFps <= 66
                        ? const Color(0xFFF48FB1)
                        : const Color(0xFFD32F2F),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  void fpsMonitor() {
    if (!startRecording) {
      setState(() {
        start();
        startRecording = true;
        controller!.value = startRecording;
      });
    } else {
      if (!fpsPageShowing) {
        final appColors = AppTheme.of(context)?.appColors ?? AppColor.light();
        final theme = Theme.of(context);
        setState(() {
          startRecording = false;
          controller!.value = "";
        });
        fpsInfoPage ??= OverlayEntry(
          builder: (_) {
            return AppTheme(
              appColors: appColors,
              child: Theme(
                data: theme,
                child: Scaffold(
                  body: Column(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            fpsInfoPage!.remove();
                            fpsPageShowing = false;
                          },
                          child: Container(color: context.appColor.alwaysMask),
                        ),
                      ),
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: context.appColor.backgroundPopup,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0),
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(
                                right: 20,
                                top: 20,
                                bottom: 10,
                              ),
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                child: const Text(
                                  '返回',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onTap: () {
                                  startRecording = false;
                                  fpsInfoPage!.remove();
                                  fpsPageShowing = false;
                                  CommonStorage.instance.clear();
                                  controller!.value = startRecording;
                                  // stop();
                                  // setState(() {});
                                },
                              ),
                            ),
                            const FpsPage(),
                            SizedBox(
                              height: MediaQuery.of(context).padding.bottom,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
        fpsPageShowing = true;
        Overlay.of(context).insert(fpsInfoPage!);
      }
    }
  }
}
