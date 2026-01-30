part of '../app_theme/theme.dart';

class AppThemeData {
  static final AppColor _lightColors = AppColor.light();
  static final AppColor _darkColors = AppColor.dark();

  static ThemeData dark(BuildContext context) => ThemeData(
    splashFactory: NoSplash.splashFactory,
    brightness: Brightness.dark,
    fontFamily: 'Satoshi',
    focusColor: _darkColors.primary500,
    primaryColor: _darkColors.primary500,
    scaffoldBackgroundColor: _darkColors.backgroundPrimary,
    cardColor: _darkColors.backgroundPrimary,
    dividerColor: _darkColors.borderSubtle,
    highlightColor: Colors.transparent,
    hintColor: _darkColors.textDisable,
    splashColor: Colors.transparent,
    tabBarTheme: TabBarThemeData(dividerColor: Colors.transparent),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _darkColors.backgroundPrimary,
      elevation: 1,
      selectedItemColor: _darkColors.primary500,
      unselectedItemColor: _darkColors.textTips,
      unselectedLabelStyle: context.f11Medium,
      selectedLabelStyle: context.f11Medium,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: _darkColors.backgroundPrimary,
      iconTheme: IconThemeData(color: _darkColors.textPrimary),
      titleTextStyle: context.f18MediumTextPrimary.copyWith(letterSpacing: 0),
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: _darkColors.primary500,
      selectionHandleColor: _darkColors.primary500,
    ),
  );
  static ThemeData light(BuildContext context) => ThemeData(
    splashFactory: NoSplash.splashFactory,
    brightness: Brightness.light,
    fontFamily: 'Satoshi',
    focusColor: _lightColors.primary500,
    primaryColor: _lightColors.primary500,
    scaffoldBackgroundColor: _lightColors.backgroundPrimary,
    cardColor: _lightColors.backgroundPrimary,
    dividerColor: _lightColors.borderSubtle,
    highlightColor: Colors.transparent,
    hintColor: _lightColors.textDisable,
    splashColor: Colors.transparent,
    tabBarTheme: TabBarThemeData(dividerColor: Colors.transparent),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _lightColors.backgroundPrimary,
      elevation: 1,
      selectedItemColor: _lightColors.primary500,
      unselectedItemColor: _lightColors.textTips,
      unselectedLabelStyle: context.f11Medium,
      selectedLabelStyle: context.f11Medium,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: _lightColors.backgroundPrimary,
      iconTheme: IconThemeData(color: _lightColors.textPrimary),
      titleTextStyle: context.f18MediumTextPrimary.copyWith(letterSpacing: 0),
      centerTitle: true,
      elevation: 0,
      toolbarHeight: 54,
      scrolledUnderElevation: 0,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: _lightColors.primary500,
      selectionHandleColor: _lightColors.primary100,
    ),
  );
}
