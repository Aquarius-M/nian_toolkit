import 'package:flutter/material.dart';
import 'package:nian_toolkit/nian_toolkit.dart';

class CustomPluggable implements Pluggable {
  static final CustomPluggable _instance = CustomPluggable._internal();

  factory CustomPluggable() {
    return _instance;
  }

  CustomPluggable._internal();

  GlobalKey<NavigatorState>? navKey;

  @override
  Widget? buildWidget(BuildContext? context) {
    return Scaffold(appBar: AppBar(title: const Text("自定义工具")));
  }

  @override
  Widget? iconWidget() => null;

  @override
  int get index => 9999;

  @override
  String get name => 'test';

  @override
  void onTrigger() {}
}
