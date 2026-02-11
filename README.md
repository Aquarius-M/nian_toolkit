# nian_toolkit

应用内调试工具箱（Dev Toolkit），通过悬浮球在任意页面唤起菜单，提供网络请求查看、日志查看、设备信息、文件管理、数据库查看、路由记录、性能/帧率等能力。

> 这是一个以 Flutter 侧实现为主的工具包，适合在 Debug/QA 环境中集成。

## 特性

- 悬浮球/菜单：拖拽吸边、图标拖动排序、清除缓存（重置悬浮球位置并清空代理配置）
- 网络请求面板：配合 `DioInspectorInterceptor` 记录并展示请求列表
- 代理配置：保存代理开关与地址（是否应用到网络层需要你在项目里接入）
- 日志面板：可读取/清空按天生成的日志文件（配合 `autoCollectLogs` 自动采集）
- 设备与应用信息：device_info_plus / package_info_plus 等信息展示
- 文件管理：基于应用沙盒目录浏览
- 数据库查看：基于 sqflite + sqlite_viewer2
- 路由记录：配合 `RouteHistoryObserver` 展示路由栈与历史
- Widget 信息/详情：仅在 Debug 模式下显示（`kDebugMode`）
- 颜色选择器、正则工具、对齐尺、帧率、性能等

## 环境要求

- Flutter：建议使用 fvm（项目内包含 `.fvmrc`）
- Dart SDK：见 pubspec.yaml
- 平台：主要面向 iOS/Android（包含 `dart:io`、sqflite 等依赖，Web 不支持）

## 安装

推荐优先使用 pub.dev 依赖；如果是单仓或私有仓，也可以使用 path/git。

### Pub 依赖

```yaml
dependencies:
  nian_toolkit: ^0.0.1
```

### Git 依赖

```yaml
dependencies:
  nian_toolkit:
    git:
      url: <your-repo-url>
      path: plugins/nian_toolkit
```

## 快速开始

### 1) 用 ToolKit.run 包裹你的 App

在 `main.dart`：

```dart
import 'package:flutter/material.dart';
import 'package:nian_toolkit/toolkit.dart';

void main() {
  ToolKit.run(
    const MyApp(),
    autoCollectLogs: false,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Scaffold(body: Center(child: Text('Hello'))),
    );
  }
}
```

说明：

- `ToolKit.run()` 内部会调用 `runApp()`，你的项目里不要再额外调用 `runApp()`。
- 同一进程只允许存在一个 ToolKit 实例（重复调用会抛错）。

### 2) 在需要时显示/隐藏工具箱

```dart
ToolKit.show(isDarkMode: false);
ToolKit.hide();
```

显示后会出现悬浮球：

- 点击悬浮球：打开/关闭菜单
- 拖动悬浮球：移动位置，松手自动吸边并持久化

## 关键能力接入

### 路由记录

在你自己的 `MaterialApp` 上挂载观察器：

```dart
import 'package:flutter/material.dart';
import 'package:nian_toolkit/toolkit.dart';

MaterialApp(
  navigatorObservers: [RouteHistoryObserver()],
)
```

否则「路由记录」面板会为空。

### 网络请求面板（Dio）

给你的 Dio 添加拦截器：

```dart
import 'package:dio/dio.dart';
import 'package:nian_toolkit/toolkit.dart';

final dio = Dio();
dio.interceptors.add(DioInspectorInterceptor());
```

否则「网络请求」面板不会记录任何请求。

### 日志自动采集

启用 `autoCollectLogs: true` 后会通过 `runZonedGuarded` 捕获：

- `print()` 输出
- 未捕获异常（会写入文件）

日志文件位置：`ApplicationDocumentsDirectory/log/.YYYY-MM-DD.log`（按天生成）。

## 自定义插件

实现 `Pluggable` 并在 `ToolKit.run` 的 `pluginsList` 中传入：

```dart
class CustomPluggable implements Pluggable {
  @override
  String get name => '自定义';

  @override
  int get index => 10000;

  @override
  void onTrigger() {}

  @override
  Widget? iconWidget() => const Icon(Icons.extension);

  @override
  Widget? buildWidget(BuildContext context) {
    return const Scaffold(
      appBar: AppBar(title: Text('自定义工具')),
      body: Center(child: Text('Hello Toolkit')),
    );
  }
}

ToolKit.run(
  const MyApp(),
  pluginsList: [CustomPluggable()],
);
```

参考示例：example/lib/custom_plug/custom_pluggable.dart

## 开发与运行（fvm）

```bash
fvm install
fvm flutter pub get

cd example
fvm flutter pub get
fvm flutter run
```

## 常见问题

### 为什么工具箱不显示？

- 确认使用 `ToolKit.run()` 启动应用
- 确认调用过 `ToolKit.show()`（默认是隐藏）
- 确认没有在同一进程创建多个 ToolKit（会抛错）

### 为什么「路由记录」没有数据？

- 给你的 `MaterialApp` 增加 `navigatorObservers: [RouteHistoryObserver()]`

### 为什么「网络请求」面板没有数据？

- 给 Dio 增加 `DioInspectorInterceptor()` 拦截器

### 代理配置是否会自动生效？

- 当前只负责保存代理配置；是否应用到你的网络层（Dio/HttpClient）需要你在项目里接入。
```
String proxyUrl = await ProxyUtils.instance.getProxy((url) {
  AppLog.i(url == "" ? "DIRECT" : "PROXY $url", tag: "proxy");
});
```

### 「清除缓存」会清什么？

- 重置悬浮球位置
- 清空已保存的代理配置（`proxy_url` / `proxy_enabled`）
  

## 感谢
  感谢[flutter_ume](https://github.com/bytedance/flutter_ume) 提供的灵感和部分调试工具。

## License

仓库内 [LICENSE](file:///Users/nephkis/Desktop/%E8%87%AA%E5%BB%BA/matrix_chat/plugins/nian_toolkit/LICENSE) 目前还是占位内容，尚未补全。
