// ignore_for_file: constant_identifier_names
part of '../nian_toolkit.dart';

class KitDeviceUtils {
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
}

class KitStringUtils {
  // 点击复制
  static void copy(String? text, {String? toastText}) {
    Clipboard.setData(ClipboardData(text: text!));
    HapticFeedback.lightImpact();
  }
}

class KitColorUtils {
  /// 取随机颜色
  static Color randomColor() {
    var red = math.Random.secure().nextInt(255);
    var greed = math.Random.secure().nextInt(255);
    var blue = math.Random.secure().nextInt(255);
    return Color.fromARGB(255, red, greed, blue);
  }
}
