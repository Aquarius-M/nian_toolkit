import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:nian_toolkit/nian_toolkit.dart';

import 'pannel_widget.dart';

/// 应用信息页面
class AppInfoPage extends StatefulWidget {
  const AppInfoPage({super.key});

  @override
  State<AppInfoPage> createState() => _AppInfoPageState();
}

class _AppInfoPageState extends State<AppInfoPage> {
  String? wifiIP = '';
  String? proxyIp = '';
  String? packageName = '';
  String? packageVersion = "";
  String? buildNumber = "";
  String? buildSignature = "";
  String? getCachePath = "";
  String? getPhoneDocumentsPath = "";
  String? installerStore = "";
  String? appName = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final info = NetworkInfo();
    wifiIP = await info.getWifiIP();

    final platformInfo = await KitDeviceUtils.getPackageInfo();

    appName = platformInfo.appName;
    packageName = platformInfo.packageName;
    packageVersion = platformInfo.version;
    buildNumber = platformInfo.buildNumber;
    buildSignature = platformInfo.buildSignature;
    installerStore = platformInfo.installerStore;
    getCachePath = await KitDeviceUtils.getCachePath();
    getPhoneDocumentsPath = await KitDeviceUtils.getPhoneDocumentsPath();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PannelWidget('IP地址', text: wifiIP, onTap: () {
            KitStringUtils.copy(wifiIP, toastText: '已复制IP地址');
          }),
          PannelWidget('app名称', text: '$appName'),
          PannelWidget('版本号', text: '$packageVersion'),
          PannelWidget('构建版本号', text: '$buildNumber'),
          PannelWidget('包名', text: '$packageName'),
          PannelWidget('签名', text: '$buildSignature'),
          PannelWidget('安装', text: '$installerStore'),
          PannelWidget('缓存路径', text: '$getCachePath', onTap: () {
            KitStringUtils.copy(getCachePath, toastText: '已复制缓存路径');
          }),
          PannelWidget('文件路径', text: '$getPhoneDocumentsPath', onTap: () {
            KitStringUtils.copy(getPhoneDocumentsPath, toastText: '已复制文件路径');
          }),
        ],
      ),
    );
  }
}
