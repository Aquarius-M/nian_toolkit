part of '../../toolkit.dart';

class DatabasePluggable extends StatelessWidget implements Pluggable {
  const DatabasePluggable({super.key});

  @override
  Widget? buildWidget(BuildContext? context) => this;

  @override
  Widget? iconWidget() => PluginIcons.database;

  @override
  String get name => '数据库';

  @override
  int get index => 9995;

  @override
  void onTrigger() {}

  @override
  Widget build(BuildContext context) {
    return const DatabaseList();
  }
}
