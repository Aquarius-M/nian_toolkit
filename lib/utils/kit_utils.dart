part of '../toolkit.dart';

class KitUtils {
  static KitUtils? _instance;
  static KitUtils get instance {
    _instance ??= KitUtils._internal();
    return _instance!;
  }

  KitUtils._internal();

  /// 设备宽高比
  static final devicePixelRatio =
      PlatformDispatcher.instance.views.first.devicePixelRatio;

  /// 设备宽度
  static final deviceWidth =
      PlatformDispatcher.instance.views.first.physicalSize.width /
      devicePixelRatio;

  /// 设备高度
  static final deviceHeight =
      PlatformDispatcher.instance.views.first.physicalSize.height /
      devicePixelRatio;

  /// 获取包信息
  static Future<PackageInfo> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  }

  /// 获取系统信息
  static Future<AndroidDeviceInfo> getDeviceInfo() async {
    AndroidDeviceInfo deviceinfo = await DeviceInfoPlugin().androidInfo;
    return deviceinfo;
  }

  /// 获取手机本地路径
  static Future<String> getPhoneDocumentsPath() async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory!.path;
  }

  /// 获取手机数据库路径
  static Future<String> getPhoneDBPath() async {
    final directory = await getDatabasesPath();
    return directory;
  }

  /// 获取app缓存路径
  static Future<String> getCachePath() async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }

  static Future<String> getDeviceName() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return '${androidInfo.manufacturer} ${androidInfo.model}';
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.utsname.machine;
    } else {
      return 'Unsupported Platform';
    }
  }

  // 点击复制
  static void copy(BuildContext context, String? text, {String? toastText}) {
    Clipboard.setData(ClipboardData(text: text ?? ""));
    HapticFeedback.lightImpact();
    if (toastText != null) {
      showToast(context, message: toastText);
    }
  }

  static void showToast(
    BuildContext context, {
    required String message,
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 500),
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle,
              color: context.appColor.textPrimary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(message, style: context.f16MediumTextPrimary)),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isError ? Colors.redAccent : Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
