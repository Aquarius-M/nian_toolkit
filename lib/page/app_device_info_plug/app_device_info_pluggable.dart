part of '../../nian_toolkit.dart';

class AppInfoPluggable extends StatefulWidget implements Pluggable {
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
  State<AppInfoPluggable> createState() => _ApplnfoPluggableState();
}

class _ApplnfoPluggableState extends State<AppInfoPluggable>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          controller: tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: "App信息"),
            Tab(text: "设备信息"),
          ],
          onTap: (value) {
            tabController?.animateTo(value);
            pageController.animateToPage(
              value,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
            );
          },
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                children: const [AppInfoPage(), DeviceInfoPage()],
                onPageChanged: (value) {
                  tabController?.animateTo(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
