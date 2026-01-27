part of '../../toolkit.dart';

class ProxyPlugable extends StatelessWidget implements Pluggable {
  const ProxyPlugable({super.key});

  @override
  Widget? buildWidget(BuildContext? context) => this;
  @override
  String get name => '代理';

  @override
  Widget? iconWidget() => PluginIcons.proxy;

  @override
  int get index => 9999;

  @override
  void onTrigger() {}
  
  @override
  Widget build(BuildContext context) {
    return ProxyPage();
  }
}
