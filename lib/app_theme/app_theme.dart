part of '../app_theme/theme.dart';

extension ContextThemeExtension on BuildContext {
  AppColor get appColor {
    return AppTheme.of(this)?.appColors ?? AppColor.light();
  }
}

class AppTheme extends InheritedWidget {
  const AppTheme({super.key, required this.appColors, required super.child});

  final AppColor appColors;
  //创建of方法从子树中的widget获取共享数据
  static AppTheme? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppTheme>();
  }

  @override
  bool updateShouldNotify(covariant AppTheme oldWidget) {
    return appColors != oldWidget.appColors;
  }
}
