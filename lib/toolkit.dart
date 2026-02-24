library;

import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:nian_toolkit/pages/dio_plug/src/dio_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlite_viewer2/sqlite_viewer.dart';

import 'app_theme/theme.dart';
import 'icons/plugin_icons.dart';

import 'pages/color_picker_plug/src/color_picker_page.dart';
import 'pages/align_ruler_plug/src/align_ruler_page.dart';
import 'pages/app_device_info_plug/src/app_device_info_page.dart';
import 'pages/app_log_plug/src/app_log_page.dart';
import 'pages/file_manager_plug/src/file_manager_page.dart';
import 'pages/frame_rate_plug/src/frame_rate_page.dart';
import 'pages/performance_plug/performance_pluggable.dart';
import 'pages/pluggable.dart';
import 'pages/proxy_plugs/src/proxy_page.dart';
import 'pages/route_history_plug/src/route_history_page.dart';
import 'pages/widget_detail_plug/widgets/search_bar.dart';

import 'toolkit/toolkit_widget.dart';

import 'utils/log_writer.dart';

export 'utils/kit_utils.dart';
export 'utils/proxy_utils.dart';
export 'utils/log_writer.dart';
export 'utils/dio_inspector_interceptor.dart';
export 'utils/route_history_observer.dart';
export 'pages/pluggable.dart';

part 'manager/plugin_manager.dart';
part 'manager/toolkit_status_manager.dart';

part 'widget/hit_test.dart';
part 'widget/inspector_overlay.dart';

part 'pages/align_ruler_plug/align_ruler_pluggable.dart';
part 'pages/app_device_info_plug/app_device_info_pluggable.dart';
part 'pages/app_log_plug/app_log_pluggable.dart';
part 'pages/color_picker_plug/color_picker_pluggable.dart';
part 'pages/database_plug/database_pluggable.dart';
part 'pages/dio_plug/dio_pluggable.dart';
part 'pages/file_manager_plug/file_manager_pluggable.dart';
part 'pages/frame_rate_plug/frame_rate_pluggable.dart';
part 'pages/proxy_plugs/proxy_pluggable.dart';
part 'pages/regular_plug/regular_pluggable.dart';
part 'pages/route_history_plug/route_history_pluggable.dart';
part 'pages/widget_detail_plug/widget_detail_pluggable.dart';
part 'pages/widget_info_plug/widget_info_pluggable.dart';

// ==================== 全局 Key 管理 ====================
class ToolkitKeys {
  static final GlobalKey rootKey = GlobalKey();
  static final GlobalKey mainPageKey = GlobalKey();
  static final GlobalKey<OverlayState> overlayKey = GlobalKey<OverlayState>();
}

class ToolKit {
  /// 【app】主应用
  ///
  /// 【showKit】是否显示kit
  ///
  /// 【pluginsList】自定义插件列表

  static void run(
    /// 主应用
    Widget app, {
    /// 自定义插件列表
    final List<Pluggable>? pluginsList,

    /// 是否自动收集日志
    bool? autoCollectLogs,
  }) {
    autoCollectLogs ??= false;
    if (autoCollectLogs) {
      LogWriter.run(() {
        runApp(_ToolKit(pluginsList: pluginsList, child: app));
      });
    } else {
      runApp(_ToolKit(pluginsList: pluginsList, child: app));
    }
  }

  static void show({bool isDarkMode = false}) {
    _devKitState?.show(isDarkMode: isDarkMode);
  }

  static void hide() {
    _devKitState?.hide();
  }
}

class _ToolKit extends StatefulWidget {
  final Widget child;

  /// 自定义插件列表
  final List<Pluggable>? pluginsList;

  const _ToolKit({required this.child, this.pluginsList});

  @override
  State<_ToolKit> createState() => __ToolKitState();
}

/// Hold the [_devKitState] as a global variable.
__ToolKitState? _devKitState;

class __ToolKitState extends State<_ToolKit> with WidgetsBindingObserver {
  __ToolKitState() {
    // 确保只有单个
    assert(_devKitState == null, '同时只能使用一个ToolKit。');
    if (_devKitState != null) {
      throw StateError('同时只能使用一个ToolKit。');
    }
    _devKitState = this;
  }

  late Widget _child;

  late bool _isDarkMode;

  OverlayEntry _overlayEntry = OverlayEntry(
    builder: (_) => const SizedBox.shrink(),
  );

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this); // 注册监听器
    super.initState();
    _registerPlugins();

    _isDarkMode = false;

    _replaceChild();
    // 延迟到下一帧执行，确保overlay已经准备好
    WidgetsBinding.instance.addPostFrameCallback((_) {
      /// 默认隐藏
      _injectOverlay(false);
    });
  }

  void show({required bool isDarkMode}) {
    ToolkitStatusManager.instance.closeMenu();
    if (_isDarkMode != isDarkMode) {
      setState(() {
        _isDarkMode = isDarkMode;
      });
    }
    _injectOverlay(true);
  }

  void hide() {
    ToolkitStatusManager.instance.closeMenu();
    _injectOverlay(false);
  }

  void _replaceChild() {
    Widget layoutChild = Stack(
      children: <Widget>[
        RepaintBoundary(key: ToolkitKeys.rootKey, child: widget.child),
        MediaQuery(
          data: MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.implicitView!,
          ),
          child: ScaffoldMessenger(child: Overlay(key: ToolkitKeys.overlayKey)),
        ),
      ],
    );

    // Support PluggableWithNestedWidget
    final allPlugins = [
      ...?widget.pluginsList,
      ...ToolKitPluginManager.instance.commonList
    ];
    for (final plugin in allPlugins) {
      if (plugin is PluggableWithNestedWidget) {
        layoutChild = plugin.buildNestedWidget(layoutChild);
      }
    }

    _child = layoutChild;
  }

  void _injectOverlay(bool isShow) {
    if (isShow) {
      // 确保overlay state存在
      if (ToolkitKeys.overlayKey.currentState != null) {
        if (_overlayEntry.mounted) {
          return;
        }
        _overlayEntry = OverlayEntry(
          builder: (_) =>
              Material(type: MaterialType.transparency, child: ToolKitWidget()),
        );
        ToolkitKeys.overlayKey.currentState!.insert(_overlayEntry);
      }
    } else {
      if (_overlayEntry.mounted) {
        _overlayEntry.remove();
      }
    }
  }

  Future<void> _registerPlugins() async {
    await ToolKitPluginManager.instance.registerAll(widget.pluginsList ?? []);
    await ToolKitPluginManager.instance.registerAll(
      ToolKitPluginManager.instance.commonList,
    );
  }

  Future<void> reRegisterPlugins() async {
    ToolKitPluginManager.instance.clear();
    await _registerPlugins();
  }

  @override
  void dispose() {
    super.dispose();
    // Do the cleaning at last.
    _devKitState = null;
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    final appColors = _isDarkMode ? AppColor.dark() : AppColor.light();
    return AppTheme(
      appColors: appColors,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
        theme: AppThemeData.light(context),
        darkTheme: AppThemeData.dark(context),
        builder: (_, child) {
          return Material(
            type: MaterialType.transparency,
            child: MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: GestureDetector(
                onTap: () {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');

                  FocusScopeNode focus = FocusScope.of(context);
                  if (!focus.hasPrimaryFocus && focus.focusedChild != null) {
                    FocusManager.instance.primaryFocus!.unfocus();
                  }
                  // ToolkitStatusManager.instance.closeMenu();
                },
                child: child,
              ),
            ),
          );
        },
        home: _child,
      ),
    );
  }
}
