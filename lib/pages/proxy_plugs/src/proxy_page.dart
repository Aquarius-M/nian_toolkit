import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nian_toolkit/toolkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app_theme/theme.dart';

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('代理配置', style: context.f18MediumTextPrimary),
        actions: [
          TextButton(
            onPressed: () async {
              final proxyUrl = textEditingController!.text.trim();

              if (isOpen && proxyUrl.isEmpty) {
                KitUtils.showToast(context, message: '请输入代理地址', isError: true);
                return;
              }

              if (isOpen && !_isValidProxyUrl(proxyUrl)) {
                _showSnackBar(
                  '代理地址格式错误 (示例: 192.168.1.10:8888)',
                  isError: true,
                );
                return;
              }

              await _saveProxySettings(proxyUrl, isOpen);

              if (mounted) {
                _showSnackBar(isOpen ? '代理已启用' : '代理已关闭', isError: false);
              }
            },
            child: Text('保存', style: context.f16MediumTextPrimary),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildStatusCard(),
          const SizedBox(height: 16),
          _buildConfigCard(),
          const SizedBox(height: 16),
          _buildInstructionCard(),
        ],
      ),
    );
  }

  void _showSnackBar(String message, {bool isError = false}) {
    KitUtils.showToast(context, message: message, isError: isError);
  }

  Widget _buildStatusCard() {
    return Card(
      elevation: 0,
      color: isOpen ? Colors.green.withValues(alpha: 0.1) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isOpen
              ? context.appColor.success.withValues(alpha: 0.3)
              : context.appColor.backgroundDisabled.withValues(alpha: 0.2),
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
            color: isOpen ? Colors.green : null,
          ),
        ),
        subtitle: Text(isOpen ? '网络请求将通过代理服务器转发' : '直接连接网络，不经过代理'),
        secondary: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isOpen
                ? context.appColor.success
                : context.appColor.backgroundDisabled,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.compare_arrows,
            color: isOpen
                ? context.appColor.alwaysBlack
                : context.appColor.alwaysWhite,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildConfigCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.dns_rounded,
              color: context.appColor.textPrimary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text('代理配置', style: context.f16MediumTextPrimary),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: TextFormField(
            controller: textEditingController,
            style: context.f16MediumTextPrimary,
            decoration: InputDecoration(
              filled: true,
              fillColor: context.appColor.backgroundInput,
              hintText: "192.168.1.10:8888",
              hintStyle: context.f16MediumTextDisable,
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: context.appColor.primary500),
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              suffixIcon: textEditingController!.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: context.appColor.textPrimary,
                        size: 18,
                      ),
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
                color: context.appColor.klineYellow.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'HOST:PORT',
                style: context.f10Bold.copyWith(
                  color: context.appColor.klineYellow,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '请输入有效的 IPv4 地址和端口号',
                style: context.f12Medium.copyWith(
                  color: context.appColor.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInstructionCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.appColor.backgroundInput.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.appColor.borderInput),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: context.appColor.textPrimary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text('使用说明', style: context.f15BoldTextPrimary),
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
            color: context.appColor.textDescription.withValues(alpha: 0.5),
            shape: BoxShape.circle,
          ),
          child: Text(
            '$index',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: context.appColor.textPrimary,
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
              color: context.appColor.textPrimary,
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
        KitUtils.showToast(context, message: '保存设置失败', isError: true);
      }
    }
  }
}
