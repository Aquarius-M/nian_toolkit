import 'package:flutter/material.dart';
import 'package:nian_toolkit/icons/plugin_icons.dart';
import 'package:nian_toolkit/toolkit.dart';

import '../app_theme/theme.dart';

class ToolkitBall extends StatelessWidget {
  final bool hasActivePage;
  final Pluggable? currentSelected;
  final VoidCallback onTap;

  const ToolkitBall({
    super.key,
    required this.hasActivePage,
    required this.currentSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final manager = ToolkitStatusManager.instance;
    final minX = manager.minX;
    final maxX = manager.getMaxX(context);
    final minY = manager.getMinY(context);
    final maxY = manager.getMaxY(context);

    return ValueListenableBuilder<Offset>(
      valueListenable: manager.positionNotifier,
      builder: (context, position, child) {
        return Positioned(
          left: position.dx,
          top: position.dy,
          child: GestureDetector(
            onPanUpdate: (d) {
              final next = position + d.delta;
              final updated = Offset(
                next.dx.clamp(minX, maxX),
                next.dy.clamp(minY, maxY),
              );
              manager.positionNotifier.value = updated;
              manager.savePosition(updated);
            },
            onPanEnd: (_) {
              final screen = MediaQuery.of(context).size;
              final isLeft = position.dx < screen.width / 2;
              final updated = Offset(
                isLeft ? minX : maxX,
                position.dy.clamp(minY, maxY),
              );
              manager.positionNotifier.value = updated;
              manager.savePosition(updated);
            },
            onTap: onTap,
            child: Container(
              width: manager.ballSize.width,
              height: manager.ballSize.height,
              decoration: BoxDecoration(
                color: context.appColor.backgroundPopup,
                borderRadius: BorderRadius.circular(manager.ballSize.width / 2),
                boxShadow: [
                  BoxShadow(blurRadius: 10, color: context.appColor.alwaysMask),
                ],
              ),
              child: Center(child: _buildBallIcon(context)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBallIcon(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: ToolkitStatusManager.instance.menuOpenNotifier,
      builder: (context, isMenuOpen, child) {
        if (isMenuOpen && !hasActivePage) {
          return const Icon(Icons.close);
        }
        if (currentSelected != null) {
          return Center(
            child: currentSelected!.iconWidget() ??
                Text(
                  currentSelected!.name.substring(0, 1).toUpperCase(),
                  style: context.f16Bold.copyWith(
                    color: PluginIcons.defaultColor,
                  ),
                ),
          );
        }
        return PluginIcons.main;
      },
    );
  }
}
