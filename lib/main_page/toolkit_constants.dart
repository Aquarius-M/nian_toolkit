part of '../../nian_toolkit.dart';

/// 工具包主页面的常量定义
class ToolKitConstants {
  // 布局相关常量
  static const EdgeInsets layoutMargins = EdgeInsets.all(16.0);
  static const Offset positionConstraints = Offset(0.0, 50.0); // minX, minY
  static const Offset positionOffsets = Offset(
    0.0,
    50.0,
  ); // maxXOffset, maxYOffset

  // 菜单相关常量

  static Size menuSize = Size(
    KitUtils.deviceWidth * 0.8,
    KitUtils.deviceHeight * 0.2,
  );
  static const EdgeInsets menuPadding = EdgeInsets.all(16.0);
  static const double menuSpacing = 8.0;

  // 图标尺寸常量
  static const Size iconSizes = Size(30.0, 24.0); // iconSize, closeIconSize
  static const Size menuItemConfig = Size(60.0, 26.0); // itemSize, iconSize
  static const EdgeInsets menuItemPadding = EdgeInsets.all(6.0);
  static const double menuItemSpacing = 8.0;
}
