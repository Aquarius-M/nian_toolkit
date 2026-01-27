part of '../../toolkit.dart';

class AppInfoPluggable extends StatelessWidget implements Pluggable {
  const AppInfoPluggable({super.key});

  @override
  Widget? buildWidget(BuildContext? context) => this;

  @override
  Widget? iconWidget() => PluginIcons.appDeviceInfo;

  @override
  String get name => '应用信息';

  @override
  int get index => 9996;
  @override
  void onTrigger() {}

  @override
  Widget build(BuildContext context) {
    return const AppDeviceInfoPage();
  }
}
