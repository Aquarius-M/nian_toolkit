part of '../../toolkit.dart';

class AlignRulerPluggable extends StatelessWidget implements Pluggable {
  const AlignRulerPluggable({super.key});

  @override
  Widget buildWidget(BuildContext? context) => this;

  @override
  Widget? iconWidget() => PluginIcons.alignRuler;

  @override
  int get index => 9988;

  @override
  String get name => '标尺';

  @override
  void onTrigger() {}

  @override
  Widget build(BuildContext context) {
    return const AlignRulerPage();
  }
}
