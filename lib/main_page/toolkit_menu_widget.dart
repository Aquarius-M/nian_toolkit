part of '../../nian_toolkit.dart';

/// 工具包菜单组件
class ToolKitMenuWidget extends StatefulWidget {
  final List<Pluggable?> dataList;
  final bool isLoading;
  final Function(Pluggable) onMenuItemTap;
  final VoidCallback onCloseMenu;
  final Offset buttonPosition;
  final Size buttonSize;
  final BuildContext parentContext;
  final Function(List<Pluggable?>)? onReorder; // 新增排序回调

  const ToolKitMenuWidget({
    super.key,
    required this.dataList,
    required this.isLoading,
    required this.onMenuItemTap,
    required this.onCloseMenu,
    required this.buttonPosition,
    required this.buttonSize,
    required this.parentContext,
    this.onReorder,
  });

  @override
  State<ToolKitMenuWidget> createState() => _ToolKitMenuWidgetState();
}

class _ToolKitMenuWidgetState extends State<ToolKitMenuWidget> {
  late List<Pluggable?> _dataList;

  @override
  void initState() {
    super.initState();
    _dataList = List.from(widget.dataList);
  }

  @override
  void didUpdateWidget(ToolKitMenuWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dataList != widget.dataList) {
      _dataList = List.from(widget.dataList);
    }
  }

  /// 获取按钮中心点坐标
  Offset _getButtonCenter() {
    return Offset(
      widget.buttonPosition.dx + widget.buttonSize.width / 2,
      widget.buttonPosition.dy + widget.buttonSize.height / 2,
    );
  }

  /// 判断按钮是否在屏幕左半部分
  bool _isButtonOnLeftSide() {
    final screenWidth = MediaQuery.of(widget.parentContext).size.width;
    final buttonCenter = _getButtonCenter();
    return buttonCenter.dx < screenWidth / 2;
  }

  /// 判断按钮是否在屏幕上半部分
  bool _isButtonOnTopSide() {
    final screenHeight = MediaQuery.of(widget.parentContext).size.height;
    final buttonCenter = _getButtonCenter();
    return buttonCenter.dy < screenHeight / 2;
  }

  /// 计算菜单的左边位置 - 根据主按钮位置动态调整
  double _calculateMenuLeft() {
    try {
      final screenWidth = MediaQuery.of(widget.parentContext).size.width;
      final menuWidth = ToolKitConstants.menuSize.width;
      final menuPadding = ToolKitConstants.menuPadding.left;

      // 边界检查
      if (screenWidth <= 0 || widget.buttonSize.width <= 0) {
        debugPrint('Invalid screen or button dimensions');
        return menuPadding;
      }

      final isOnLeft = _isButtonOnLeftSide();

      final left = isOnLeft
          ? widget
                .buttonPosition
                .dx // 按钮在左侧，菜单左边框与按钮左边框对齐
          : widget.buttonPosition.dx +
                widget.buttonSize.width -
                menuWidth; // 按钮在右侧，菜单右边框与按钮右边框对齐

      // 确保菜单不会超出屏幕边界
      final minLeft = menuPadding;
      final maxLeft = screenWidth - menuWidth - menuPadding;

      if (maxLeft < minLeft) {
        debugPrint('Screen too small for menu');
        return minLeft;
      }

      return left.clamp(minLeft, maxLeft);
    } catch (e) {
      debugPrint('Error calculating menu left position: $e');
      return ToolKitConstants.menuPadding.left;
    }
  }

  /// 计算菜单的顶部位置 - 根据主按钮位置动态调整
  double _calculateMenuTop() {
    try {
      final screenHeight = MediaQuery.of(widget.parentContext).size.height;
      final menuHeight = ToolKitConstants.menuSize.height;

      // 边界检查
      if (screenHeight <= 0 || widget.buttonSize.height <= 0) {
        debugPrint('Invalid screen or button dimensions');
        return ToolKitConstants.menuSpacing;
      }

      final isOnTop = _isButtonOnTopSide();

      // 根据按钮位置决定菜单显示在上方还是下方
      final top = isOnTop
          ? widget.buttonPosition.dy +
                widget.buttonSize.height +
                ToolKitConstants
                    .menuSpacing // 按钮在上半部分，菜单显示在按钮下方
          : widget.buttonPosition.dy -
                menuHeight -
                ToolKitConstants.menuSpacing; // 按钮在下半部分，菜单显示在按钮上方

      // 确保菜单不会超出屏幕边界
      final minTop = ToolKitConstants.menuSpacing;
      final maxTop = screenHeight - menuHeight - ToolKitConstants.menuSpacing;

      if (maxTop < minTop) {
        debugPrint('Screen too small for menu');
        return minTop;
      }

      return top.clamp(minTop, maxTop);
    } catch (e) {
      debugPrint('Error calculating menu top position: $e');
      return ToolKitConstants.menuSpacing;
    }
  }

  /// 构建菜单内容
  Widget _buildMenuContent() {
    return Container(
      width: ToolKitConstants.menuSize.width,
      height: ToolKitConstants.menuSize.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: !widget.isLoading
          ? _dataList.isEmpty
                ? const Center(child: Text('Empty'))
                : SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: ToolKitConstants.menuItemPadding,
                      child: ReorderableWrap(
                        spacing: ToolKitConstants.menuItemSpacing,
                        runSpacing: ToolKitConstants.menuItemSpacing,
                        alignment: WrapAlignment.center,
                        onReorder: (int oldIndex, int newIndex) {
                          setState(() {
                            final item = _dataList.removeAt(oldIndex);
                            _dataList.insert(newIndex, item);
                          });
                          // 保存菜单排序到本地存储
                          MenuOrderStorage.saveMenuOrder(_dataList);
                          // 调用外部回调
                          widget.onReorder?.call(_dataList);
                        },
                        children: _dataList.asMap().entries.map((entry) {
                          final data = entry.value;
                          if (data == null) {
                            return const SizedBox(key: ValueKey('empty'));
                          }
                          return SizedBox(
                            key: ValueKey(data.name), // 为每个item添加唯一key
                            width: ToolKitConstants.menuItemConfig.width,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton.small(
                                  elevation: 2,
                                  backgroundColor: Colors.white,
                                  onPressed: () => widget.onMenuItemTap(data),
                                  child: Image(
                                    image: data.iconImageProvider,
                                    width:
                                        ToolKitConstants.menuItemConfig.height,
                                    height:
                                        ToolKitConstants.menuItemConfig.height,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(data.name),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )
          : const Center(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 菜单背景遮罩层 - 点击空白区域关闭菜单
        Positioned.fill(
          child: GestureDetector(
            onTap: widget.onCloseMenu,
            child: Container(color: Colors.transparent),
          ),
        ),
        // 悬浮菜单定位在主按钮附近
        Positioned(
          left: _calculateMenuLeft(),
          top: _calculateMenuTop(),
          child: _buildMenuContent(),
        ),
      ],
    );
  }
}
