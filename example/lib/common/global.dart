import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

ThemeData baseThemeData = ThemeData.from(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    // 主色调
    primary: Colors.pink,
    // appbar颜色
    onPrimary: Colors.purple,
    // 按钮颜色
    primaryContainer: Colors.pink,
    // 按钮内容
    onPrimaryContainer: Colors.white,

    secondary: Colors.pink,
    onSecondary: Colors.pink,

    error: Colors.black12,
    onError: Colors.redAccent,

    // 页面背景
    surface: Colors.white,
    // 页面上其他元素颜色
    onSurface: Colors.black,
  ),
  useMaterial3: true,
);
