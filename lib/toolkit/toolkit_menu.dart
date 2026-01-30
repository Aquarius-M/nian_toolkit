import 'package:flutter/material.dart';

import 'package:reorderables/reorderables.dart';
import '../app_theme/theme.dart';
import '../icons/plugin_icons.dart';
import '../toolkit.dart';

class ToolkitMenu extends StatelessWidget {
  final bool isVisible;
  final List<Pluggable?> dataList;
  final Function(int oldIndex, int newIndex) onReorder;
  final Function(Pluggable) onPluginTap;
  final VoidCallback onClearCache;

  const ToolkitMenu({
    super.key,
    required this.isVisible,
    required this.dataList,
    required this.onReorder,
    required this.onPluginTap,
    required this.onClearCache,
  });

  @override
  Widget build(BuildContext context) {
    final manager = ToolkitStatusManager.instance;
    return ValueListenableBuilder<Offset>(
      valueListenable: manager.positionNotifier,
      builder: (context, position, child) {
        final screenSize = MediaQuery.of(context).size;
        final minX = manager.minX;
        final minY = manager.getMinY(context);

        final menuWidth = screenSize.width * 0.8;
        final menuHeight = screenSize.height * 0.2;
        final menuLeft =
            (position.dx + manager.ballSize.width / 2 - menuWidth / 2)
                .clamp(minX, screenSize.width - menuWidth - 8.0);

        final topWhenAbove = position.dy - menuHeight - 8.0;
        final topWhenBelow = position.dy + manager.ballSize.height + 8.0;
        final menuTop = (topWhenAbove < minY ? topWhenBelow : topWhenAbove)
            .clamp(minY, screenSize.height - menuHeight - 8.0);

        return Positioned(
          left: menuLeft,
          top: menuTop,
          child: IgnorePointer(
            ignoring: !isVisible,
            child: isVisible
                ? Container(
                    width: menuWidth,
                    height: menuHeight,
                    decoration: BoxDecoration(
                      color: context.appColor.backgroundPrimary,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: context.appColor.alwaysMask,
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ReorderableWrap(
                          spacing: 10.0,
                          runSpacing: 10.0,
                          onReorder: onReorder,
                          buildDraggableFeedback:
                              (context, constraints, child) {
                            return Material(
                              color: Colors.transparent,
                              elevation: 0,
                              child: child,
                            );
                          },
                          children: [
                            ...dataList.asMap().entries.map((entry) {
                              final data = entry.value;
                              if (data == null) {
                                return const SizedBox(key: ValueKey('empty'));
                              }
                              return SizedBox(
                                key: ValueKey(data.name),
                                width: 60,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FloatingActionButton.small(
                                      elevation: 2,
                                      backgroundColor:
                                          context.appColor.backgroundInput,
                                      onPressed: () {
                                        ToolKitPluginManager.instance
                                            .activatePluggable(data);
                                        data.onTrigger();
                                        onPluginTap(data);
                                      },
                                      child: Center(
                                        child: data.iconWidget() ??
                                            Text(
                                              data.name
                                                  .substring(0, 1)
                                                  .toUpperCase(),
                                              style: context.f32Bold.copyWith(
                                                color: PluginIcons.defaultColor,
                                              ),
                                            ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      data.name,
                                      style: context.f13MediumTextPrimary,
                                    ),
                                  ],
                                ),
                              );
                            }),
                            SizedBox(
                              key: const ValueKey("delete_cache"),
                              width: 60,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FloatingActionButton.small(
                                    elevation: 2,
                                    backgroundColor:
                                        context.appColor.backgroundInput,
                                    onPressed: () async {
                                      await ProxyUtils.instance.clearProxy();
                                      onClearCache();
                                    },
                                    child: PluginIcons.clear,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "清除缓存",
                                    style: context.f13MediumTextPrimary,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        );
      },
    );
  }
}
