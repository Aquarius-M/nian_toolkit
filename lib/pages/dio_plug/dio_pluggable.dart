// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../../toolkit.dart';

class DioPluggable extends StatefulWidget implements Pluggable {
  const DioPluggable({super.key});

  @override
  Widget? buildWidget(BuildContext? context) => this;

  @override
  Widget? iconWidget() => PluginIcons.dio;

  @override
  int get index => 9998;

  @override
  String get name => '网络请求';

  @override
  void onTrigger() {}

  @override
  State<StatefulWidget> createState() {
    return _DioPluggableState();
  }
}

class _DioPluggableState extends State<DioPluggable> {
  @override
  Widget build(BuildContext context) {
    return const DioPage();
  }
}
