import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PluginIcons {
  static const iconSize = 32.0;

  static const defaultColor = Color(0xFFA4634D);

  static Widget _buildIcon(String assetPath, {Color? color}) {
    final effectiveColor = color ?? defaultColor;
    return SvgPicture.asset(
      assetPath,
      package: 'nian_toolkit',
      width: iconSize,
      height: iconSize,
      colorFilter: ColorFilter.mode(effectiveColor, BlendMode.srcIn),
    );
  }

  static Widget get main => _buildIcon('assets/ghost.svg');

  static Widget get clear => _buildIcon('assets/clear.svg');

  static Widget get alignRuler => _buildIcon('assets/align_ruler.svg');

  static Widget get appDeviceInfo => _buildIcon('assets/app_device_info.svg');

  static Widget get appLog => _buildIcon('assets/app_log.svg');

  static Widget get colorPicker => _buildIcon('assets/color_picker.svg');

  static Widget get database => _buildIcon('assets/database.svg');

  static Widget get dio => _buildIcon('assets/dio.svg');

  static Widget get fileManager => _buildIcon('assets/file_manager.svg');

  static Widget get frameRate => _buildIcon('assets/frame_rate.svg');

  static Widget get performance => _buildIcon('assets/performance.svg');

  static Widget get proxy => _buildIcon('assets/proxy.svg');

  static Widget get regular => _buildIcon('assets/regular.svg');

  static Widget get routeHistory => _buildIcon('assets/route_history.svg');

  static Widget get widgetDetail => _buildIcon('assets/widget_detail.svg');

  static Widget get widgetInfo => _buildIcon('assets/widget_info.svg');
}
