part of '../../nian_toolkit.dart';

class ApplogPluggable extends StatelessWidget implements Pluggable {
  const ApplogPluggable({super.key});

  @override
  Widget? buildWidget(BuildContext? context) => this;

  @override
  Widget? iconWidget() => PluginIcons.appLog;

  @override
  String get name => '日志';

  @override
  int get index => 9997;

  @override
  void onTrigger() {}

  @override
  Widget build(BuildContext context) {
    return const LogListPage();
  }
}
