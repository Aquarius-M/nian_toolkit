import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProxyPage extends StatefulWidget {
  const ProxyPage({super.key});

  @override
  State<ProxyPage> createState() => _ProxyPageState();
}

class _ProxyPageState extends State<ProxyPage> {
  bool isOpen = false;
  TextEditingController? textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    _loadProxySettings();
  }

  @override
  void dispose() {
    textEditingController?.dispose();
    super.dispose();
  }

  /// 加载代理设置
  void _loadProxySettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final url = prefs.getString('proxy_url') ?? '';
      final enabled = prefs.getBool('proxy_enabled') ?? false;

      if (mounted) {
        setState(() {
          isOpen = enabled;
          textEditingController?.text = url;
        });
      }
    } catch (e) {
      log('加载代理设置失败: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '代理配置',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final proxyUrl = textEditingController!.text.trim();

              // 验证代理地址格式
              if (isOpen && proxyUrl.isEmpty) {
                _showSnackBar(context, '请输入代理地址', isError: true);
                return;
              }

              if (isOpen && !_isValidProxyUrl(proxyUrl)) {
                _showSnackBar(
                  context,
                  '代理地址格式错误 (示例: 192.168.1.10:8888)',
                  isError: true,
                );
                return;
              }

              // 保存代理设置
              await _saveProxySettings(proxyUrl, isOpen);

              if (mounted) {
                _showSnackBar(
                  context,
                  isOpen ? '代理已启用' : '代理已关闭',
                  isError: false,
                );
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.black),
            child: const Text('保存'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildStatusCard(theme),
          const SizedBox(height: 16),
          _buildConfigCard(theme),
          const SizedBox(height: 16),
          _buildInstructionCard(theme),
        ],
      ),
    );
  }

  void _showSnackBar(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isError ? Colors.redAccent : Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildStatusCard(ThemeData theme) {
    return Card(
      elevation: 0,
      color: isOpen ? Colors.green.withValues(alpha: 0.1) : theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isOpen
              ? Colors.green.withValues(alpha: 0.3)
              : Colors.grey.withValues(alpha: 0.2),
        ),
      ),
      child: SwitchListTile.adaptive(
        value: isOpen,
        onChanged: (value) {
          setState(() {
            isOpen = value;
          });
        },
        title: Text(
          isOpen ? '代理已开启' : '代理已关闭',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isOpen ? Colors.green : theme.textTheme.bodyLarge?.color,
          ),
        ),
        subtitle: Text(
          isOpen ? '网络请求将通过代理服务器转发' : '直接连接网络，不经过代理',
          style: TextStyle(
            fontSize: 12,
            color: theme.textTheme.bodySmall?.color,
          ),
        ),
        secondary: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isOpen ? Colors.green : Colors.grey,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.compare_arrows,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildConfigCard(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.dns_rounded, color: Colors.black, size: 20),
            const SizedBox(width: 8),
            Text(
              '代理配置',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: theme.textTheme.titleMedium?.color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          ),
          child: TextFormField(
            controller: textEditingController,
            style: const TextStyle(fontSize: 16, fontFamily: 'monospace'),
            decoration: InputDecoration(
              hintText: "192.168.1.10:8888",
              hintStyle: TextStyle(color: Colors.grey.withValues(alpha: 0.5)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              suffixIcon: textEditingController!.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 18),
                      onPressed: () {
                        setState(() {
                          textEditingController!.clear();
                        });
                      },
                    )
                  : null,
            ),
            onChanged: (_) => setState(() {}),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'HOST:PORT',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '请输入有效的 IPv4 地址和端口号',
                style: TextStyle(
                  fontSize: 12,
                  color: theme.textTheme.bodySmall?.color,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInstructionCard(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: Colors.blue.shade700,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '使用说明',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildStepItem(1, '在输入框中填写抓包工具（如 Charles/Fiddler）的 IP 和端口。'),
          const SizedBox(height: 8),
          _buildStepItem(2, '开启顶部的「代理开关」。'),
          const SizedBox(height: 8),
          _buildStepItem(3, '点击右上角「保存」按钮生效。'),
          const SizedBox(height: 8),
          _buildStepItem(4, '抓包结束后，请务必关闭代理，以免影响正常网络访问。'),
        ],
      ),
    );
  }

  Widget _buildStepItem(int index, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 2),
          width: 16,
          height: 16,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Text(
            '$index',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              color: Colors.blue.shade900.withValues(alpha: 0.8),
            ),
          ),
        ),
      ],
    );
  }

  /// 验证代理URL格式
  bool _isValidProxyUrl(String url) {
    final regex = RegExp(r'^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}:\d{1,5}$');
    return regex.hasMatch(url);
  }

  /// 保存代理设置
  Future<void> _saveProxySettings(String url, bool enabled) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('proxy_url', url);
      await prefs.setBool('proxy_enabled', enabled);

      log('代理设置已保存: URL=$url, 启用=$enabled');
    } catch (e) {
      log('保存代理设置失败: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('保存设置失败')));
      }
    }
  }
}
