part of '../nian_toolkit.dart';

// 全局key
final GlobalKey _rootKey = GlobalKey();
final GlobalKey _mainPageKey = GlobalKey();
final GlobalKey<OverlayState> _overlayKey = GlobalKey<OverlayState>();

// 基础变量
ui.FlutterView _flutterView = ui.PlatformDispatcher.instance.implicitView!;
double _ratio = _flutterView.devicePixelRatio;
final Size _windowSize = _flutterView.physicalSize / _ratio;
const Size _dotSize = Size(50.0, 50.0);

const double _margin = 10.0;

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
