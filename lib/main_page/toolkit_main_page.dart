part of '../../nian_toolkit.dart';

class ToolKitMainPage extends StatefulWidget {
  ToolKitMainPage({Key? key}) : super(key: _mainPageKey);

  @override
  State<ToolKitMainPage> createState() => _ToolKitMainPageState();
}

/// 工具包主页面状态管理类
class _ToolKitMainPageState extends State<ToolKitMainPage> {
  // 合并后的状态管理
  late PositionState _position;
  late UIState _uiState;

  // 插件数据
  List<Pluggable?> _dataList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeStates();
    // 异步加载插件数据，不阻塞初始化
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadPluginData();
    });
  }

  /// 初始化所有状态
  void _initializeStates() {
    _position = PositionState(
      dx:
          _windowSize.width -
          _dotSize.width -
          ToolKitConstants.layoutMargins.left,
      dy: _windowSize.height - (4 * _dotSize.height),
    );
    _uiState = UIState();
    _isLoading = true; // 初始化时设置为加载状态
  }

  /// 加载插件数据
  void _loadPluginData() async {
    _isLoading = true;
    
    // 获取所有已注册的插件
    final allPlugins = ToolKitPluginManager.instance.pluginsMap.values
        .where((plugin) => plugin != null)
        .cast<Pluggable>()
        .toList();
    
    // 从本地存储加载保存的排序
    final savedOrder = await MenuOrderStorage.loadMenuOrder();
    
    // 根据保存的排序重新排列插件，只显示已导入的插件
    _dataList = MenuOrderStorage.reorderMenuItems(allPlugins, savedOrder);
    
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // ==================== 事件处理方法 ====================

  /// 处理菜单项重新排序
  void _handleMenuReorder(List<Pluggable?> reorderedList) {
    setState(() {
      _dataList = reorderedList;
    });
    // 排序保存逻辑已在 ToolKitMenuWidget 中实现
  }

  /// 处理菜单项点击事件
  Future<void> _handleMenuItemTap(Pluggable pluginData) async {
    try {
      if (!mounted) return;

      _uiState.currentSelected = pluginData;
      ToolKitPluginManager.instance.activatePluggable(pluginData);
      _handleAction(pluginData);
      pluginData.onTrigger();
    } catch (e) {
      debugPrint('Error handling menu item tap: $e');
      // 发生错误时重置状态
      if (mounted) {
        setState(() {
          _uiState.reset();
        });
      }
    }
  }

  /// 关闭菜单
  void _closeMenu() {
    try {
      if (!mounted) return;

      setState(() {
        _uiState.closeMenu();
      });
    } catch (e) {
      debugPrint('Error closing menu: $e');
    }
  }

  /// 处理插件激活操作
  void _handleAction(Pluggable data) {
    try {
      if (!mounted) return;

      final widget = data.buildWidget(context);
      if (widget == null) {
        debugPrint('Plugin returned null widget');
        return;
      }

      _uiState.currentWidget = widget;
      setState(() {
        _uiState.showedMenu = false;
        _uiState.hasActivePage = true;
      });
    } catch (e) {
      debugPrint('Error handling plugin action: $e');
      // 发生错误时关闭菜单
      if (mounted) {
        _closeMenu();
      }
    }
  }

  // ==================== 拖拽事件处理 ====================

  /// 计算拖拽边界范围
  Rect _getDragBounds(Size screenSize) {
    return Rect.fromLTRB(
      ToolKitConstants.positionConstraints.dx +
          ToolKitConstants.layoutMargins.left,
      ToolKitConstants.positionConstraints.dy +
          ToolKitConstants.layoutMargins.top,
      screenSize.width -
          _dotSize.width -
          ToolKitConstants.layoutMargins.right -
          ToolKitConstants.positionOffsets.dx,
      screenSize.height -
          _dotSize.height -
          ToolKitConstants.layoutMargins.bottom -
          ToolKitConstants.positionOffsets.dy,
    );
  }

  /// 限制位置在边界范围内
  Offset _constrainPosition(Offset position, Size screenSize) {
    final bounds = _getDragBounds(screenSize);
    return Offset(
      position.dx.clamp(bounds.left, bounds.right),
      position.dy.clamp(bounds.top, bounds.bottom),
    );
  }

  /// 处理拖拽更新事件
  void dragEvent(DragUpdateDetails details) {
    // 计算新位置（相对于按钮中心点）
    final newPosition = Offset(
      details.globalPosition.dx - _dotSize.width / 2,
      details.globalPosition.dy - _dotSize.height / 2,
    );

    // 限制位置在边界范围内
    final constrainedPosition = _constrainPosition(
      newPosition,
      MediaQuery.of(context).size,
    );

    _position.updatePosition(constrainedPosition.dx, constrainedPosition.dy);
    setState(() {});
  }

  /// 处理拖拽结束事件，实现自动吸附功能
  void dragEnd(DragEndDetails details) {
    final screenSize = MediaQuery.of(context).size;
    final margin = ToolKitConstants.layoutMargins.left;

    // 自动吸附到左右边缘
    if (_position.dx + _dotSize.width / 2 < screenSize.width / 2) {
      _position.dx = margin;
    } else {
      _position.dx = screenSize.width - _dotSize.width - margin;
    }

    // 确保Y轴位置在允许范围内
    final maxYOffset = ToolKitConstants.positionOffsets.dy;
    final minY = ToolKitConstants.positionConstraints.dy;

    if (_position.dy + _dotSize.height > screenSize.height - maxYOffset) {
      _position.dy = screenSize.height - _dotSize.height - margin - maxYOffset;
    } else if (_position.dy < minY) {
      _position.dy = minY + margin;
    }

    // 最终边界检查
    _position.dx = _position.dx.clamp(
      margin,
      screenSize.width - _dotSize.width - margin,
    );
    _position.dy = _position.dy.clamp(
      minY + margin,
      screenSize.height - _dotSize.height - margin - maxYOffset,
    );

    setState(() {});
  }

  /// 处理主按钮点击事件
  void onTap() {
    if (_uiState.hasActivePage || _uiState.currentSelected != null) {
      // 如果有激活的页面，点击主按钮关闭页面
      _closeActivatedPluggable();
      return;
    }
    // 否则切换菜单显示状态
    _toggleMenu();
  }

  /// 切换菜单显示状态
  void _toggleMenu() {
    try {
      if (!mounted) return;

      setState(() {
        _uiState.showedMenu = !_uiState.showedMenu;
      });
    } catch (e) {
      debugPrint('Error toggling menu: $e');
      // 发生错误时重置菜单状态
      if (mounted) {
        setState(() {
          _uiState.showedMenu = false;
        });
      }
    }
  }

  /// 关闭当前激活的插件
  void _closeActivatedPluggable() {
    try {
      if (!mounted) return;

      if (_uiState.currentSelected != null) {
        ToolKitPluginManager.instance.deactivatePluggable(
          _uiState.currentSelected!,
        );
        _uiState.currentSelected = null;
      }
      _uiState.hasActivePage = false;
      _uiState.showedMenu = false;
      setState(() {});
    } catch (e) {
      debugPrint('Error closing activated pluggable: $e');
      // 强制重置状态
      if (mounted) {
        setState(() {
          _uiState.reset();
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 当前激活的页面内容（如果有的话）
        if (_uiState.hasActivePage && _uiState.currentWidget != null)
          _uiState.currentWidget!,
        // 悬浮菜单
        if (_uiState.showedMenu)
          ToolKitMenuWidget(
            dataList: _dataList,
            isLoading: _isLoading,
            onMenuItemTap: _handleMenuItemTap,
            onCloseMenu: _closeMenu,
            buttonPosition: Offset(_position.dx, _position.dy),
            buttonSize: _dotSize,
            parentContext: context,
            onReorder: _handleMenuReorder,
          ),
        // 主按钮
        Positioned(
          left: _position.dx,
          top: _position.dy,
          child: GestureDetector(
            onTap: onTap,
            onVerticalDragEnd: dragEnd,
            onHorizontalDragEnd: dragEnd,
            onHorizontalDragUpdate: dragEvent,
            onVerticalDragUpdate: dragEvent,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: const Offset(0.0, 0.0),
                    blurRadius: 2.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              width: _dotSize.width,
              height: _dotSize.height,
              child: Center(child: _buildLogoWidget()),
            ),
          ),
        ),
      ],
    );
  }

  /// 构建主按钮图标组件
  /// 根据不同状态显示不同图标：
  /// 1. 显示菜单且无活动页面时 -> 关闭图标 (Icons.close)
  /// 2. 有选中的插件时 -> 插件图标 (_uiState.currentSelected!.iconImageProvider)
  /// 3. 默认状态 -> 主图标 (MemoryImage(mainIconBytes))
  Widget _buildLogoWidget() {
    Widget child;

    // 状态1：显示菜单且没有活动页面时，显示关闭图标
    if (_uiState.showedMenu && !_uiState.hasActivePage) {
      child = Icon(
        Icons.close,
        size: ToolKitConstants.iconSizes.height,
        color: Colors.black,
      );
    }
    // 状态2：有选中的插件时，显示插件图标
    else if (_uiState.currentSelected != null) {
      child = Image(
        gaplessPlayback: true,
        image: _uiState.currentSelected!.iconImageProvider,
        fit: BoxFit.contain,
      );
    }
    // 状态3：默认状态，显示主图标
    else {
      child = Image(
        gaplessPlayback: true,
        image: MemoryImage(mainIconBytes),
        fit: BoxFit.contain,
      );
    }

    return SizedBox(
      height: ToolKitConstants.iconSizes.width,
      width: ToolKitConstants.iconSizes.width,
      child: child,
    );
  }
}
