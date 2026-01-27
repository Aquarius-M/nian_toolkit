part of '../../toolkit.dart';

class FrameRatePluggable extends StatelessWidget implements Pluggable {
  /// 展示性能监控数据
  static bool debugShowPerformanceMonitor = true;

  const FrameRatePluggable({super.key});

  @override
  Widget? iconWidget() => PluginIcons.frameRate;

  @override
  void onTrigger() {}

  @override
  String get name => "帧率";

  @override
  int get index => 9989;

  @override
  Widget? buildWidget(BuildContext? context) => this;

  @override
  Widget build(BuildContext context) {
    return const FrameRatePage();
  }
}
