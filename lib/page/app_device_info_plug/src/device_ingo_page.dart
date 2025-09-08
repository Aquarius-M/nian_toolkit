import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

import 'pannel_widget.dart';

/// 设备信息页面
class DeviceInfoPage extends StatefulWidget {
  const DeviceInfoPage({super.key});

  @override
  State<DeviceInfoPage> createState() => _DeviceInfoPageState();
}

class _DeviceInfoPageState extends State<DeviceInfoPage> {
  AndroidDeviceInfo? androidDeviceInfo;
  IosDeviceInfo? iosDeviceInfo;
  @override
  void initState() {
    super.initState();
    getDeviceInfo();
  }

  void getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      androidDeviceInfo = await deviceInfo.androidInfo;
    } else if (Platform.isIOS) {
      iosDeviceInfo = await deviceInfo.iosInfo;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Platform.isAndroid ? buildAndroidInfo() : buildIOSInfo(),
    );
  }

  Widget buildAndroidInfo() {
    return Column(
      children: [
        PannelWidget('安全修补程序', text: androidDeviceInfo?.version.securityPatch),
        PannelWidget('SDK版本',
            text: androidDeviceInfo?.version.sdkInt.toString()),
        PannelWidget('操作系统版本', text: androidDeviceInfo?.version.release),
        PannelWidget('SDK预览版本',
            text: androidDeviceInfo?.version.previewSdkInt.toString()),
        PannelWidget('内部值', text: androidDeviceInfo?.version.incremental),
        PannelWidget('开发代号', text: androidDeviceInfo?.version.codename),
        PannelWidget('基本操作系统', text: androidDeviceInfo?.version.baseOS),
        PannelWidget('board', text: androidDeviceInfo?.board),
        PannelWidget('bootloader', text: androidDeviceInfo?.bootloader),
        PannelWidget('brand', text: androidDeviceInfo?.brand),
        PannelWidget('device', text: androidDeviceInfo?.device),
        PannelWidget('display', text: androidDeviceInfo?.display),
        PannelWidget('fingerprint', text: androidDeviceInfo?.fingerprint),
        PannelWidget('hardware', text: androidDeviceInfo?.hardware),
        PannelWidget('host', text: androidDeviceInfo?.host),
        PannelWidget('id', text: androidDeviceInfo?.id),
        PannelWidget('manufacturer', text: androidDeviceInfo?.manufacturer),
        PannelWidget('model', text: androidDeviceInfo?.model),
        PannelWidget('product', text: androidDeviceInfo?.product),
        PannelWidget('supported32BitAbis',
            text: androidDeviceInfo?.supported32BitAbis.toString()),
        PannelWidget('supported64BitAbis',
            text: androidDeviceInfo?.supported64BitAbis.toString()),
        PannelWidget('supportedAbis',
            text: androidDeviceInfo?.supportedAbis.toString()),
        PannelWidget('tags', text: androidDeviceInfo?.tags),
        PannelWidget('type', text: androidDeviceInfo?.type),
        PannelWidget('isPhysicalDevice',
            text: androidDeviceInfo?.isPhysicalDevice.toString()),
      ],
    );
  }

  Widget buildIOSInfo() {
    return Column(
      children: [
        PannelWidget('设备名称', text: iosDeviceInfo?.name),
        PannelWidget('系统名称', text: iosDeviceInfo?.systemName),
        PannelWidget('系统版本', text: iosDeviceInfo?.systemVersion),
        PannelWidget('模型', text: iosDeviceInfo?.model),
        PannelWidget('本地化模型', text: iosDeviceInfo?.localizedModel),
        PannelWidget('供应商标识符', text: iosDeviceInfo?.identifierForVendor),
        PannelWidget('是否为物理设备',
            text: iosDeviceInfo?.isPhysicalDevice.toString()),
        PannelWidget('操作系统名称', text: iosDeviceInfo?.utsname.sysname),
        PannelWidget('网络节点名称', text: iosDeviceInfo?.utsname.nodename),
        PannelWidget('发布等级', text: iosDeviceInfo?.utsname.release),
        PannelWidget('版本等级', text: iosDeviceInfo?.utsname.version),
        PannelWidget('硬件类型', text: iosDeviceInfo?.utsname.machine),
      ],
    );
  }
}
