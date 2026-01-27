part of '../../toolkit.dart';

class FileManagerPluggable extends StatelessWidget implements Pluggable {
  const FileManagerPluggable({super.key});

  @override
  Widget? buildWidget(BuildContext? context) => this;

  @override
  Widget? iconWidget() => PluginIcons.fileManager;

  @override
  String get name => '文件管理';

  @override
  int get index => 9987;

  @override
  void onTrigger() {}

  @override
  Widget build(BuildContext context) {
    return const FileManagerPage();
  }
}
