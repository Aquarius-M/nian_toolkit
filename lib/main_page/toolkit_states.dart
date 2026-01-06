part of '../../nian_toolkit.dart';

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
