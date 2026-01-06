part of '../../nian_toolkit.dart';

class ProxyPlugable extends StatefulWidget implements Pluggable {
  const ProxyPlugable({super.key});

  @override
  State<ProxyPlugable> createState() => _ProxyPlugableState();

  @override
  Widget? buildWidget(BuildContext? context) => this;

  @override
  String get name => '代理';

  @override
  ImageProvider<Object> get iconImageProvider => MemoryImage(proxyIconBytes);

  @override
  int get index => 9999;

  @override
  void onTrigger() {}
}

class _ProxyPlugableState extends State<ProxyPlugable> {
  bool isOpen = false;
  TextEditingController? textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    _loadProxySettings();
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
        title: const Text(
          '代理设置',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final proxyUrl = textEditingController!.text.trim();

              // 验证代理地址格式
              if (isOpen && proxyUrl.isEmpty) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('请输入代理地址')));
                return;
              }

              if (isOpen && !_isValidProxyUrl(proxyUrl)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('代理地址格式不正确，请使用 IP:端口 格式')),
                );
                return;
              }

              // 保存代理设置
              await _saveProxySettings(proxyUrl, isOpen);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isOpen ? '代理已启用: $proxyUrl' : '代理已禁用'),
                  backgroundColor: isOpen ? Colors.green : Colors.orange,
                ),
              );
            },
            icon: const Icon(Icons.save),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              '代理地址',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: textEditingController,
              style: const TextStyle(fontSize: 16),
              decoration: const InputDecoration(
                hintText: "示例: 127.0.0.1:8888",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                prefixIcon: Icon(Icons.language),
              ),
            ),
            const SizedBox(height: 16),
            _buildRow(
              '启用代理',
              CupertinoSwitch(
                value: isOpen,
                onChanged: (value) {
                  setState(() {
                    isOpen = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('使用说明：', style: TextStyle(fontWeight: FontWeight.w500)),
                  SizedBox(height: 4),
                  Text('1. 输入代理服务器的IP地址和端口号'),
                  Text('2. 开启代理开关'),
                  Text('3. 点击保存按钮应用设置'),
                  Text('4. 设置会在应用重启后自动恢复'),
                ],
              ),
            ),
          ],
        ),
      ),
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

  Widget _buildRow(String title, Widget child) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        child,
      ],
    );
  }

  @override
  void dispose() {
    textEditingController?.dispose();
    super.dispose();
  }
}
