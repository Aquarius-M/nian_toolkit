part of '../../nian_toolkit.dart';

class DatabasePluggable extends StatelessWidget implements Pluggable {
  const DatabasePluggable({super.key});

  @override
  Widget? buildWidget(BuildContext? context) => this;

  @override
  ImageProvider<Object> get iconImageProvider => MemoryImage(databaseIconBytes);

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
