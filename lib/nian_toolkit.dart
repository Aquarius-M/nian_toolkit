library;

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:nian_toolkit/page/dio_plug/src/instances.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_viewer2/sqlite_viewer.dart';
import 'package:reorderables/reorderables.dart';

import 'main_page/icon.dart';
import 'main_page/toolkit_main_icon.dart';
import 'page/align_ruler_plug/icon.dart';
import 'page/app_device_info_plug/icon.dart';
import 'page/app_device_info_plug/src/app_info_page.dart';
import 'page/app_device_info_plug/src/device_ingo_page.dart';
import 'page/app_log_plug/icon.dart';
import 'page/app_log_plug/src/app_log_page.dart';
import 'page/color_picker_plug/color_picker_pluggable.dart';
import 'page/database_plug/icon.dart';
import 'page/dio_plug/icon.dart';
import 'page/frame_rate_plug/icon.dart';
import 'page/frame_rate_plug/widget/performance_observer_widget.dart';
import 'page/performance_plug/performance_pluggable.dart';
import 'page/proxy_plugs/icon.dart';
import 'page/regular_plug/icon.dart';
import 'page/widget_detail_plug/icon.dart';
import 'page/widget_detail_plug/widgets/search_bar.dart';
import 'page/widget_info_plug/icon.dart';
import 'widget/inspector_overlay.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'main.dart';
part 'common/global.dart';
part 'common/error_config.dart';

part 'manager/pluggable.dart';
part 'manager/plugin_manager.dart';

part 'main_page/toolkit_constants.dart';
part 'main_page/toolkit_states.dart';
part 'main_page/toolkit_main_page.dart';
part 'main_page/toolkit_menu_widget.dart';

part 'widget/hit_test.dart';
part 'widget/dragable_widget.dart';

part 'page/align_ruler_plug/align_ruler_pluggable.dart';
part 'page/app_device_info_plug/app_device_info_pluggable.dart';
part 'page/app_log_plug/app_log_pluggable.dart';
part 'page/database_plug/database_pluggable.dart';
part 'page/frame_rate_plug/frame_rate_pluggable.dart';
part 'page/proxy_plugs/proxy_pluggable.dart';
part 'page/regular_plug/regular_pluggable.dart';
part 'page/widget_detail_plug/widget_detail_pluggable.dart';
part 'page/widget_info_plug/widget_info_pluggable.dart';
part 'page/dio_plug/dio_pluggable.dart';
part 'page/dio_plug/dio_inspector_interceptor.dart';

part 'utils/kit_utils.dart';
part 'utils/menu_order_storage.dart';
part 'manager/proxy_manager.dart';
