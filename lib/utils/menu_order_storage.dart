part of '../../nian_toolkit.dart';

/// 菜单项信息
class _PluggableInfo {
  final int index;
  final String name;

  _PluggableInfo(this.index, this.name);

  /// 序列化为字符串：index|name
  String serialize() => '$index|$name';

  /// 从字符串反序列化
  static _PluggableInfo? deserialize(String str) {
    try {
      final parts = str.split('|');
      if (parts.length != 2) return null;
      final index = int.tryParse(parts[0]);
      if (index == null) return null;
      return _PluggableInfo(index, parts[1]);
    } catch (e) {
      return null;
    }
  }
}

/// 菜单排序存储工具类
class MenuOrderStorage {
  static const String _keyMenuOrder = 'toolkit_menu_order';

  /// 保存菜单项排序
  static Future<bool> saveMenuOrder(List<Pluggable?> menuItems) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // 将菜单项转换为可序列化的数据（同时保存 index 和 name）
      final orderList = menuItems
          .where((item) => item != null)
          .map((item) => _PluggableInfo(item!.index, item.name).serialize())
          .toList();

      return await prefs.setStringList(_keyMenuOrder, orderList);
    } catch (e) {
      debugPrint('Error saving menu order: $e');
      return false;
    }
  }

  /// 加载菜单项排序
  static Future<List<_PluggableInfo>?> loadMenuOrder() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final stringList = prefs.getStringList(_keyMenuOrder);
      if (stringList == null) return null;

      // 反序列化为 _PluggableInfo 列表
      return stringList
          .map((str) => _PluggableInfo.deserialize(str))
          .whereType<_PluggableInfo>()
          .toList();
    } catch (e) {
      debugPrint('Error loading menu order: $e');
      return null;
    }
  }

  /// 根据保存的排序重新排列菜单项
  static List<Pluggable?> reorderMenuItems(
    List<Pluggable?> originalItems,
    List<_PluggableInfo>? savedOrder,
  ) {
    if (savedOrder == null || savedOrder.isEmpty) {
      return originalItems;
    }

    try {
      // 创建 index 和 name 到插件的映射
      final Map<int, Pluggable> indexToPlugin = {};
      final Map<String, Pluggable> nameToPlugin = {};
      for (final item in originalItems) {
        if (item != null) {
          indexToPlugin[item.index] = item;
          nameToPlugin[item.name] = item;
        }
      }

      // 验证保存的数据有效性
      int foundByIndex = 0;
      int foundByName = 0;
      int notFound = 0;

      for (final info in savedOrder) {
        if (indexToPlugin.containsKey(info.index)) {
          foundByIndex++;
        } else if (nameToPlugin.containsKey(info.name)) {
          foundByName++;
        } else {
          notFound++;
        }
      }

      // 计算总体匹配率
      final totalFound = foundByIndex + foundByName;
      final matchRate = totalFound / savedOrder.length;

      // 如果匹配率低于 50%，说明数据可能已过期
      if (matchRate < 0.5) {
        debugPrint(
          'Menu order validation failed: only $totalFound/${savedOrder.length} '
          'items found (${(matchRate * 100).toStringAsFixed(1)}%). '
          'Clearing saved order and using default order.',
        );
        // 异步清除缓存，不阻塞当前操作
        clearMenuOrder();
        return originalItems;
      }

      // 如果有 index 变化，输出警告信息
      if (foundByName > 0) {
        debugPrint(
          'Warning: $foundByName pluggable(s) index changed, '
          'matched by name instead.',
        );
      }

      // 按照保存的顺序重新排列
      final List<Pluggable?> reorderedItems = [];
      final Set<int> usedIndices = {};

      // 按保存的顺序添加项目（优先使用 index 匹配，其次使用 name 匹配）
      for (final info in savedOrder) {
        Pluggable? plugin;

        // 优先通过 index 匹配
        if (indexToPlugin.containsKey(info.index)) {
          plugin = indexToPlugin[info.index];
        }
        // 如果 index 找不到，尝试通过 name 匹配
        else if (nameToPlugin.containsKey(info.name)) {
          plugin = nameToPlugin[info.name];
          debugPrint(
            'Pluggable "${info.name}" index changed: ${info.index} -> ${plugin!.index}',
          );
        }

        if (plugin != null) {
          reorderedItems.add(plugin);
          usedIndices.add(plugin.index);
        }
      }

      // 添加新增的项目（不在保存的顺序中的）
      final newPlugins = originalItems
          .where((item) => item != null && !usedIndices.contains(item.index))
          .toList();

      if (newPlugins.isNotEmpty) {
        debugPrint(
          'Found ${newPlugins.length} new pluggable(s) not in saved order.',
        );
        reorderedItems.addAll(newPlugins);
      }

      if (notFound > 0) {
        debugPrint(
          'Warning: $notFound pluggable(s) from saved order were not found. '
          'They may have been removed.',
        );
      }

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
