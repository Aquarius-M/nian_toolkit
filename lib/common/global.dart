part of '../nian_toolkit.dart';

// 全局key
final GlobalKey rootKey = GlobalKey();
final GlobalKey _mainPageKey = GlobalKey();
final GlobalKey<OverlayState> _overlayKey = GlobalKey<OverlayState>();

// 基础变量

const Size _dotSize = Size(50.0, 50.0);

const double _margin = 10.0;

// 全局主按钮位置状态管理
class _GlobalPositionNotifier extends ChangeNotifier {
  Offset _position = Offset(
    KitUtils.deviceWidth - _dotSize.width - ToolKitConstants.layoutMargins.left,
    KitUtils.deviceHeight - (4 * _dotSize.height),
  );

  Offset get position => _position;

  void updatePosition(double dx, double dy) {
    _position = Offset(dx, dy);
    notifyListeners();
  }
}

final _GlobalPositionNotifier _globalPositionNotifier =
    _GlobalPositionNotifier();

// 主题
final ThemeData _devThemeData = ThemeData(
  useMaterial3: false,
  primaryColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    foregroundColor: Color(0xff000000),
    iconTheme: IconThemeData(color: Color(0xff000000)),
    centerTitle: true,
    titleTextStyle: TextStyle(fontSize: 18, color: Color(0xff000000)),
  ),
  canvasColor: Colors.white,
);
