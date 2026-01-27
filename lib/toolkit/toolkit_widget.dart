import 'package:flutter/material.dart';

import '../toolkit.dart';
import 'toolkit_ball.dart';
import 'toolkit_menu.dart';

class ToolKitWidget extends StatefulWidget {
  const ToolKitWidget({super.key});

  @override
  State<ToolKitWidget> createState() => _ToolKitWidgetState();
}

class _ToolKitWidgetState extends State<ToolKitWidget> {
  List<Pluggable?> _dataList = [];

  Pluggable? _currentSelected;
  Widget? _currentWidget;
  bool _hasActivePage = false;

  @override
  void initState() {
    super.initState();
    _dataList = List.from(ToolKitPluginManager.instance.pluginsMap.values);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      final manager = ToolkitStatusManager.instance;
      final initialPosition = await manager.getInitialPosition(context);
      if (!mounted) return;
      manager.positionNotifier.value = initialPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    final manager = ToolkitStatusManager.instance;

    final currentSelected = _currentSelected;
    final hasActivePage = currentSelected != null;

    return ValueListenableBuilder<Offset>(
      valueListenable: manager.positionNotifier,
      builder: (context, position, child) {
        if (position == Offset.zero) {
          return const SizedBox.shrink();
        }
        return Stack(
          children: [
            if (_hasActivePage && _currentWidget != null) _currentWidget!,
            ValueListenableBuilder<bool>(
              valueListenable: manager.menuOpenNotifier,
              builder: (context, menuOpen, child) {
                return ToolkitMenu(
                  isVisible: menuOpen && !hasActivePage,
                  dataList: _dataList,
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      final item = _dataList.removeAt(oldIndex);
                      _dataList.insert(newIndex, item);
                    });
                  },
                  onPluginTap: (data) {
                    _openPluggable(data);
                  },
                  onClearCache: () {
                    if (!mounted) return;
                    manager.closeMenu();
                    manager.resetPosition(context);
                  },
                );
              },
            ),
            ToolkitBall(
              hasActivePage: hasActivePage,
              currentSelected: _currentSelected,
              onTap: () {
                if (hasActivePage) {
                  _closeActivatedPluggable();
                  return;
                }
                manager.toggleMenu();
              },
            ),
          ],
        );
      },
    );
  }

  void _openPluggable(Pluggable data) {
    if (!mounted) return;
    final widget = data.buildWidget(context);
    _currentSelected = data;
    _currentWidget = widget;
    setState(() {
      ToolkitStatusManager.instance.closeMenu();
      _hasActivePage = widget != null;
    });
  }

  void _closeActivatedPluggable() {
    if (!mounted) return;
    if (_currentSelected != null) {
      ToolKitPluginManager.instance.deactivatePluggable(_currentSelected!);
    }
    setState(() {
      _currentSelected = null;
      _currentWidget = null;
      _hasActivePage = false;
      ToolkitStatusManager.instance.closeMenu();
    });
  }
}
