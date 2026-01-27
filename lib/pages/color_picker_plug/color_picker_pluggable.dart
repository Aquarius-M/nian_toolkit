part of '../../toolkit.dart';

class ColorPickerPluggable extends StatelessWidget implements Pluggable {
  final double scale;
  final Size size;

  const ColorPickerPluggable({
    super.key,
    this.scale = 10.0,
    this.size = const Size(100, 100),
  });

  @override
  Widget buildWidget(BuildContext? context) => this;

  @override
  Widget? iconWidget() => PluginIcons.colorPicker;

  @override
  String get name => '取色器';

  @override
  int get index => 9990;

  @override
  void onTrigger() {}

  @override
  Widget build(BuildContext context) {
    return ColorPickerPage(scale: scale, size: size);
  }
}
