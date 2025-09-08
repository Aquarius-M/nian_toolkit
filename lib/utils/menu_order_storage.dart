part of '../../nian_toolkit.dart';

/// 菜单排序存储工具类
class MenuOrderStorage {
  static const String _keyMenuOrder = 'toolkit_menu_order';

  /// 保存菜单项排序
  static Future<bool> saveMenuOrder(List<Pluggable?> menuItems) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // 将菜单项转换为可序列化的数据（使用插件名称作为标识）
      final orderList = menuItems
          .where((item) => item != null)
          .map((item) => item!.name)
          .toList();

      return await prefs.setStringList(_keyMenuOrder, orderList);
    } catch (e) {
      debugPrint('Error saving menu order: $e');
      return false;
    }
  }

  /// 加载菜单项排序
  static Future<List<String>?> loadMenuOrder() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getStringList(_keyMenuOrder);
    } catch (e) {
      debugPrint('Error loading menu order: $e');
      return null;
    }
  }

  /// 根据保存的排序重新排列菜单项
  static List<Pluggable?> reorderMenuItems(
    List<Pluggable?> originalItems,
    List<String>? savedOrder,
  ) {
    if (savedOrder == null || savedOrder.isEmpty) {
      return originalItems;
    }

    try {
      // 创建名称到插件的映射
      final Map<String, Pluggable> nameToPlugin = {};
      for (final item in originalItems) {
        if (item != null) {
          nameToPlugin[item.name] = item;
        }
      }

      // 按照保存的顺序重新排列
      final List<Pluggable?> reorderedItems = [];

      // 首先添加按保存顺序排列的项目
      for (final name in savedOrder) {
        if (nameToPlugin.containsKey(name)) {
          reorderedItems.add(nameToPlugin[name]);
          nameToPlugin.remove(name); // 移除已添加的项目
        }
      }

      // 添加新增的项目（不在保存的顺序中的）
      reorderedItems.addAll(nameToPlugin.values);

      return reorderedItems;
    } catch (e) {
      debugPrint('Error reordering menu items: $e');
      return originalItems;
    }
  }

  /// 清除保存的菜单排序
  static Future<bool> clearMenuOrder() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_keyMenuOrder);
    } catch (e) {
      debugPrint('Error clearing menu order: $e');
      return false;
    }
  }
}
