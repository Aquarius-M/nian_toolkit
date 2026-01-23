part of '../nian_toolkit.dart';

// ==================== 全局 Key 管理 ====================
class ToolkitKeys {
  static final GlobalKey rootKey = GlobalKey();
  static final GlobalKey mainPageKey = GlobalKey();
  static final GlobalKey<OverlayState> overlayKey = GlobalKey<OverlayState>();
}

// ==================== 样式与布局配置 ====================
class ToolkitConfig {
  // 悬浮球配置
  static const Size dotSize = Size(50.0, 50.0);
  static const double dotMargin = 16.0; // 屏幕边缘间距
  static const double safeHeight = 50.0; // 底部安全距离

  // 菜单配置
  static const EdgeInsets menuItemPadding = EdgeInsets.all(16.0);
  static const double menuSpacing = 8.0;
  static const Size menuItemSize = Size(60.0, 26.0);

  // 动态获取菜单大小
  static Size getMenuSize(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Size(size.width * 0.8, size.height * 0.2);
  }
}

// ==================== 全局位置状态管理 ====================
class ToolkitPositionNotifier extends ChangeNotifier {
  static final ToolkitPositionNotifier _instance =
      ToolkitPositionNotifier._internal();
  factory ToolkitPositionNotifier() => _instance;
  ToolkitPositionNotifier._internal();

  Offset _position = Offset.zero;
  Offset get position => _position;

  bool _hasInitialized = false;

  /// 初始化位置
  void initPosition(Size screenSize, {bool? reInit}) {
    if (reInit == true) {
      _hasInitialized = false;
    }
    if (!_hasInitialized) {
      _position = Offset(
        screenSize.width -
            ToolkitConfig.dotSize.width -
            ToolkitConfig.dotMargin,
        screenSize.height * 0.8,
      );
      _hasInitialized = true;
    }
  }

  /// 更新位置（绝对位置）
  void updatePosition(Offset newPosition) {
    _position = newPosition;
    notifyListeners();
  }

  /// 处理拖拽更新
  void handleDragUpdate(DragUpdateDetails details, Size screenSize) {
    final newX = _position.dx + details.delta.dx;
    final newY = _position.dy + details.delta.dy;

    // 限制在屏幕内
    final maxX = screenSize.width - ToolkitConfig.dotSize.width;
    final maxY =
        screenSize.height -
        ToolkitConfig.dotSize.height -
        ToolkitConfig.safeHeight;

    final clampedX = newX.clamp(0.0, maxX);
    final clampedY = newY.clamp(ToolkitConfig.safeHeight, maxY);

    updatePosition(Offset(clampedX, clampedY));
  }

  /// 处理拖拽结束（自动吸附）
  void handleDragEnd(Size screenSize) {
    final double centerX = _position.dx + ToolkitConfig.dotSize.width / 2;
    final double screenCenterX = screenSize.width / 2;

    double targetX;
    // 吸附到左右两侧，保留 margin
    if (centerX < screenCenterX) {
      targetX = ToolkitConfig.dotMargin;
    } else {
      targetX =
          screenSize.width -
          ToolkitConfig.dotSize.width -
          ToolkitConfig.dotMargin;
    }

    // Y轴保持在安全区域内
    final minY = ToolkitConfig.safeHeight;
    final maxY =
        screenSize.height -
        ToolkitConfig.dotSize.height -
        ToolkitConfig.safeHeight;

    final targetY = _position.dy.clamp(minY, maxY);

    updatePosition(Offset(targetX, targetY));
  }
}

final ToolkitPositionNotifier toolkitPosition = ToolkitPositionNotifier();

// ==================== 主题配置 ====================
final ThemeData toolkitThemeData = ThemeData(
  useMaterial3: false,
  primaryColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    foregroundColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.black),
    centerTitle: true,
    titleTextStyle: TextStyle(fontSize: 18, color: Colors.black),
  ),
  canvasColor: Colors.white,
);
