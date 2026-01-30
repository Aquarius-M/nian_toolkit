part of '../toolkit.dart';

class ToolkitStatusManager {
  static ToolkitStatusManager? _instance;

  static ToolkitStatusManager get instance {
    _instance ??= ToolkitStatusManager._();
    return _instance!;
  }

  ToolkitStatusManager._();

  final ValueNotifier<Offset> positionNotifier = ValueNotifier(Offset.zero);
  final ValueNotifier<bool> menuOpenNotifier = ValueNotifier(false);
  final Size ballSize = Size(50, 50);
  final double minX = 8.0;

  static const String _prefsKeyX = 'toolkit_ball_x';
  static const String _prefsKeyY = 'toolkit_ball_y';

  double getMinY(BuildContext context) => MediaQuery.of(context).padding.top;
  double getMaxX(BuildContext context) =>
      MediaQuery.of(context).size.width - ballSize.width - minX;
  double getMaxY(BuildContext context) =>
      MediaQuery.of(context).size.height -
      ballSize.height -
      MediaQuery.of(context).padding.bottom;

  void resetPosition(BuildContext context) {
    _clearSavedPosition();
    positionNotifier.value = Offset(getMaxX(context), getMaxY(context));
  }

  Future<void> savePosition(Offset position) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_prefsKeyX, position.dx);
    await prefs.setDouble(_prefsKeyY, position.dy);
  }

  Future<void> _clearSavedPosition() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefsKeyX);
    await prefs.remove(_prefsKeyY);
  }

  Future<Offset> getInitialPosition(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final double? x = prefs.getDouble(_prefsKeyX);
    final double? y = prefs.getDouble(_prefsKeyY);
    final minY = getMinY(context);
    final maxX = getMaxX(context);
    final maxY = getMaxY(context);
    if (x != null && y != null) {
      final clampedX = x.clamp(minX, maxX);
      final clampedY = y.clamp(minY, maxY);
      return Offset(clampedX.toDouble(), clampedY.toDouble());
    }
    return Offset(maxX, maxY);
  }

  void closeMenu() {
    menuOpenNotifier.value = false;
  }

  void toggleMenu() {
    menuOpenNotifier.value = !menuOpenNotifier.value;
  }
}
