part of '../../nian_toolkit.dart';

/// 位置状态管理类
class PositionState {
  double dx;
  double dy;

  PositionState({required this.dx, required this.dy});

  Offset get offset => Offset(dx, dy);

  void updatePosition(double newDx, double newDy) {
    dx = newDx;
    dy = newDy;
  }
}

/// 界面状态管理类
class UIState {
  bool showedMenu;
  bool hasActivePage;
  Widget? currentWidget;
  Pluggable? currentSelected;

  UIState()
      : showedMenu = false,
        hasActivePage = false,
        currentWidget = null,
        currentSelected = null;

  void reset() {
    showedMenu = false;
    hasActivePage = false;
    currentWidget = null;
    currentSelected = null;
  }

  void closeMenu() {
    showedMenu = false;
    hasActivePage = false;
  }
}