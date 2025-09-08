part of '../nian_toolkit.dart';

class ProxyManager {
  static ProxyManager? _instance;
  static ProxyManager get instance {
    _instance ??= ProxyManager._internal();
    return _instance!;
  }

  ProxyManager._internal();

  static const String _proxyUrlKey = 'proxy_url';
  static const String _proxyEnabledKey = 'proxy_enabled';

  String _proxyUrl = '';
  bool _isEnabled = false;

  // 代理设置变化回调
  Function(String url, bool enabled)? onProxyChanged;

  String get proxyUrl => _proxyUrl;
  bool get isEnabled => _isEnabled;

  Future<String> getProxy(Function(String)? callback) async {
    final prefs = await SharedPreferences.getInstance();
    _proxyUrl = prefs.getString(_proxyUrlKey) ?? '';
    _isEnabled = prefs.getBool(_proxyEnabledKey) ?? false;
    if (_isEnabled) {
      callback?.call(_proxyUrl);
      return _proxyUrl;
    } else {
      callback?.call("");
      return '';
    }
  }

  /// 设置代理
  Future<void> setProxy(String url, bool enabled) async {
    _proxyUrl = url;
    _isEnabled = enabled;

    // 保存到本地存储
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_proxyUrlKey, url);
    await prefs.setBool(_proxyEnabledKey, enabled);

    // 通知代理设置变化
    onProxyChanged?.call(url, enabled);
  }

  /// 获取代理信息
  Map<String, dynamic> getProxyInfo() {
    return {'url': _proxyUrl, 'status': _isEnabled};
  }

  /// 清除代理设置
  Future<void> clearProxy() async {
    await setProxy('', false);
  }

  /// 获取当前有效的代理URL（只有启用时才返回）
  String getEffectiveProxyUrl() {
    return _isEnabled ? _proxyUrl : '';
  }
}
