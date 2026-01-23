part of '../../nian_toolkit.dart';

class ToolKitMainPage extends StatefulWidget {
  ToolKitMainPage({Key? key}) : super(key: ToolkitKeys.mainPageKey);

  @override
  State<ToolKitMainPage> createState() => _ToolKitMainPageState();
}

/// 工具包主页面状态管理类
class _ToolKitMainPageState extends State<ToolKitMainPage> {
  // UI状态管理
  late UIState _uiState;

  // 插件数据
  List<Pluggable?> _dataList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _uiState = UIState();

    // 监听全局位置变化，触发UI更新
    toolkitPosition.addListener(_onPositionChanged);

    // 异步加载插件数据和初始化位置
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initPosition();
      _loadPluginData();
    });
  }

  @override
  void dispose() {
    // 移除全局位置监听器
    toolkitPosition.removeListener(_onPositionChanged);
    super.dispose();
  }

  /// 位置变化回调
  void _onPositionChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  /// 初始化位置
  void _initPosition({bool? reInit}) {
    if (!mounted) return;
    final size = MediaQuery.of(context).size;
    toolkitPosition.initPosition(size, reInit: reInit);
  }

  /// 加载插件数据
  void _loadPluginData() async {
    setState(() {
      _isLoading = true;
    });

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

  /// 处理清除缓存
  Future _handleClearCache() async {
    _toggleMenu();
    _initPosition(reInit: true);
    final state = _devKitState;
    if (state != null) {
      await state.reRegisterPlugins();
      if (mounted) {
        _loadPluginData();
      }
    } else {
      _loadPluginData();
    }
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

  // ==================== 拖拽与交互处理 ====================

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
  Widget build(BuildContext context) {
    final position = toolkitPosition.position;
    final screenSize = MediaQuery.of(context).size;

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
            buttonPosition: position,
            buttonSize: ToolkitConfig.dotSize,
            parentContext: context,
            onReorder: _handleMenuReorder,
            onClearCache: () async {
              await _handleClearCache();
            },
          ),

        // 主按钮
        Positioned(
          left: position.dx,
          top: position.dy,
          child: GestureDetector(
            onTap: onTap,
            // 使用 onPan 系列回调统一处理拖拽，逻辑委托给 toolkitPosition
            onPanUpdate: (details) =>
                toolkitPosition.handleDragUpdate(details, screenSize),
            onPanEnd: (details) => toolkitPosition.handleDragEnd(screenSize),
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
              width: ToolkitConfig.dotSize.width,
              height: ToolkitConfig.dotSize.height,
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
  /// 2. 有选中的插件时 -> 插件图标
  /// 3. 默认状态 -> 主图标
  Widget _buildLogoWidget() {
    Widget child;

    // 状态1：显示菜单且没有活动页面时，显示关闭图标
    if (_uiState.showedMenu && !_uiState.hasActivePage) {
      child = Icon(
        Icons.close,
        size: PluginIcons.iconSize,
        color: Colors.black,
      );
    }
    // 状态2：有选中的插件时，显示插件图标
    else if (_uiState.currentSelected != null) {
      child = Center(
        child:
            _uiState.currentSelected!.iconWidget() ??
            Text(
              _uiState.currentSelected!.name.substring(0, 1).toUpperCase(),
              style: TextStyle(
                fontSize: 16.0,
                color: PluginIcons.defaultColor,
                fontWeight: FontWeight.bold,
              ),
            ),
      );
    }
    // 状态3：默认状态，显示主图标
    else {
      child = PluginIcons.main;
    }

    return SizedBox(
      height: PluginIcons.iconSize,
      width: PluginIcons.iconSize,
      child: child,
    );
  }
}
