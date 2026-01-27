import 'package:flutter/material.dart';
import '../../../app_theme/app_theme_text_style.dart';
import 'app_info_page.dart';
import 'device_ingo_page.dart';

class AppDeviceInfoPage extends StatefulWidget {
  const AppDeviceInfoPage({super.key});

  @override
  State<AppDeviceInfoPage> createState() => _AppDeviceInfoPageState();
}

class _AppDeviceInfoPageState extends State<AppDeviceInfoPage>
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
          isScrollable: false,
          tabs: const [
            Tab(text: "App信息"),
            Tab(text: "设备信息"),
          ],
          labelStyle: context.f16MediumTextPrimary,
          unselectedLabelStyle: context.f16MediumTextTertiary,
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
      body: Column(
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
    );
  }
}
