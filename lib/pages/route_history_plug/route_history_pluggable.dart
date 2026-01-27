part of '../../toolkit.dart';

class RouteHistoryPluggable extends StatelessWidget implements Pluggable {
  const RouteHistoryPluggable({super.key});

  @override
  Widget? buildWidget(BuildContext? context) => this;

  @override
  Widget? iconWidget() => PluginIcons.routeHistory;

  @override
  String get name => '路由记录';

  @override
  int get index => 9986;

  @override
  void onTrigger() {}

  @override
  Widget build(BuildContext context) {
    return const RouteHistoryPage();
  }
}
