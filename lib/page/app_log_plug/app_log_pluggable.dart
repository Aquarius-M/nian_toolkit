part of '../../nian_toolkit.dart';

class ApplogPluggable extends StatelessWidget implements Pluggable {
  const ApplogPluggable({super.key});

  @override
  Widget? buildWidget(BuildContext? context) => this;

  @override
  ImageProvider<Object> get iconImageProvider => MemoryImage(appLogIconBytes);

  @override
  String get name => '日志';

  @override
  int get index => 7;

  @override
  void onTrigger() {}

  @override
  Widget build(BuildContext context) {
    return const LogListPage();
  }
}
