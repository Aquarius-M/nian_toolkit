import 'package:flutter/material.dart';

class AppColor {
  /// 固定色
  Color alwaysBlack = Color(0xFF000000);
  Color alwaysWhite = Color(0xFFFFFFFF);
  Color alwaysMask = Color(0xFF000000).withValues(alpha: 0.4);
  Color alwaysToast = Color(0xFF000000).withValues(alpha: 0.9);
  Color alwaysTransparent = Colors.transparent;

  late Color primary50;
  late Color primary100;
  late Color primary200;
  late Color primary300;
  late Color primary400;
  late Color primary500;
  late Color primary600;
  late Color primary700;
  late Color primary800;
  late Color primary900;

  /// Gray / Solid 中性灰阶
  late Color graySolid50;
  late Color graySolid100;
  late Color graySolid200;
  late Color graySolid300;
  late Color graySolid400;
  late Color graySolid500;
  late Color graySolid600;
  late Color graySolid700;
  late Color graySolid800;
  late Color graySolid900;

  /// Gray / Alpha 中性灰透明阶
  late Color grayAlpha5;
  late Color grayAlpha10;
  late Color grayAlpha20;
  late Color grayAlpha30;
  late Color grayAlpha40;
  late Color grayAlpha50;
  late Color grayAlpha60;
  late Color grayAlpha70;
  late Color grayAlpha80;
  late Color grayAlpha90;

  /// Status 状态色
  late Color success;
  late Color success5;
  late Color success10;
  late Color success20;
  late Color success30;
  late Color success40;
  late Color success50;
  late Color success60;
  late Color success70;
  late Color success80;
  late Color success90;
  late Color success100;

  late Color error;
  late Color error5;
  late Color error10;
  late Color error20;
  late Color error30;
  late Color error40;
  late Color error50;
  late Color error60;
  late Color error70;
  late Color error80;
  late Color error90;
  late Color error100;

  /// Text文字色
  // late Color textTitle;
  late Color textPrimary;
  late Color textSecondary;
  late Color textTertiary;
  late Color textDescription;
  late Color textTips;
  late Color textDisable;
  late Color textInversePrimary;
  late Color textInverseSecondary;
  late Color textInverseTertiary;

  /// Borders线条色
  late Color borderGutter;
  late Color borderSubtle;
  late Color borderInput;
  late Color borderButtonStrong;
  late Color borderButtonLine;

  /// backgroud背景色
  late Color backgroundPrimary;
  late Color backgroundSecondary;
  late Color backgroundTertiary;
  late Color backgroundInversePrimary;
  late Color backgroundInverseDisabled;
  late Color backgroundMask40;
  late Color backgroundMask20;
  late Color backgroundInput;
  late Color backgroundDisabled;
  late Color backgroundPopup;

  /// Functional 功能色
  late Color tradeGreenDefault;
  late Color tradeGreenFocus;
  late Color tradeGreenPressed;
  late Color tradeGreenDisable;
  late Color tradeGreenBackground;
  late Color tradeRedDefault;
  late Color tradeRedFocus;
  late Color tradeRedPressed;
  late Color tradeRedDisable;
  late Color tradeRedBackground;

  late Color klineGreen;
  late Color klinePurple;
  late Color klinePink;
  late Color klineBlue;
  late Color klineYellow;

  factory AppColor.light() => AppColor._light;
  factory AppColor.dark() => AppColor._dark;

  static final AppColor _dark = AppColor._darkInit();
  static final AppColor _light = AppColor._lightInit();

  AppColor._lightInit() {
    primary50 = Color(0xFFFDF8F6); // 50 - 最浅
    primary100 = Color(0xFFFAF0EB); // 100
    primary200 = Color(0xFFF4DDD1); // 200
    primary300 = Color(0xFFECC4B0); // 300
    primary400 = Color(0xFFE0A085); // 400
    primary500 = Color(0xFFA4634D); // 500 - 主色
    primary600 = Color(0xFF8B5542); // 600
    primary700 = Color(0xFF6F4537); // 700
    primary800 = Color(0xFF52342C); // 800
    primary900 = Color(0xFF2A1B16); // 900 - 最深

    // Gray / Solid
    graySolid50 = Color(0xFFFCFCFD);
    graySolid100 = Color(0xFFF9F9FB);
    graySolid200 = Color(0xFFF3F3F6);
    graySolid300 = Color(0xFFEEEEF2);
    graySolid400 = Color(0xFFE8E8ED);
    graySolid500 = Color(0xFFE2E2E9);
    graySolid600 = Color(0xFFAEAEC1);
    graySolid700 = Color(0xFF7A7A9A);
    graySolid800 = Color(0xFF4F4F68);
    graySolid900 = Color(0xFF282834);

    // Gray / Alpha (base: #E2E2E9)
    grayAlpha5 = const Color(0xFFE2E2E9).withValues(alpha: 0.05);
    grayAlpha10 = const Color(0xFFE2E2E9).withValues(alpha: 0.10);
    grayAlpha20 = const Color(0xFFE2E2E9).withValues(alpha: 0.20);
    grayAlpha30 = const Color(0xFFE2E2E9).withValues(alpha: 0.30);
    grayAlpha40 = const Color(0xFFE2E2E9).withValues(alpha: 0.40);
    grayAlpha50 = const Color(0xFFE2E2E9).withValues(alpha: 0.50);
    grayAlpha60 = const Color(0xFFE2E2E9).withValues(alpha: 0.60);
    grayAlpha70 = const Color(0xFFE2E2E9).withValues(alpha: 0.70);
    grayAlpha80 = const Color(0xFFE2E2E9).withValues(alpha: 0.80);
    grayAlpha90 = const Color(0xFFE2E2E9).withValues(alpha: 0.90);

    // Status 状态色
    success = Color(0xFF17CF60);
    success5 = success.withValues(alpha: 0.05);
    success10 = success.withValues(alpha: 0.10);
    success20 = success.withValues(alpha: 0.20);
    success30 = success.withValues(alpha: 0.30);
    success40 = success.withValues(alpha: 0.40);
    success50 = success.withValues(alpha: 0.50);
    success60 = success.withValues(alpha: 0.60);
    success70 = success.withValues(alpha: 0.70);
    success80 = success.withValues(alpha: 0.80);
    success90 = success.withValues(alpha: 0.90);
    success100 = success; // 1.0

    error = Color(0xFFE32D2D);
    error5 = error.withValues(alpha: 0.05);
    error10 = error.withValues(alpha: 0.10);
    error20 = error.withValues(alpha: 0.20);
    error30 = error.withValues(alpha: 0.30);
    error40 = error.withValues(alpha: 0.40);
    error50 = error.withValues(alpha: 0.50);
    error60 = error.withValues(alpha: 0.60);
    error70 = error.withValues(alpha: 0.70);
    error80 = error.withValues(alpha: 0.80);
    error90 = error.withValues(alpha: 0.90);
    error100 = error; // 1.0

    // Text文字色
    textPrimary = Color(0xFF050506); // Primary
    textSecondary = Color(0xFF282834); // Secondary
    textTertiary = Color(0xFF4F4F68); // Tertiary
    textDescription = Color(0xFF7A7A9A); // Description
    textTips = Color(0xFFAEAEC1); // Tips
    textDisable = Color(0xFFE2E2E9); // Disbled
    textInversePrimary = Color(0xFFFFFFFF); // Inverse-Primary
    textInverseSecondary = Color(0xFFAEAEC1); // inverse-secondary
    textInverseTertiary = Color(0xFF7A7A9A); // Inverse-tertiary

    // Background背景色
    backgroundPrimary = Color(0xFFFFFFFF); // Primary
    backgroundSecondary = Color(0xFFF9F9FB); // Secondary
    backgroundTertiary = Color(0xFFEEEEF2); // Tertiary
    backgroundInversePrimary = Color(0xFF050506); // Inverse-Primary
    backgroundInverseDisabled = Color(0xFF363738); // Inverse-Disabled
    backgroundMask40 = Color(0xFF000000).withValues(alpha: 0.4); // Mask40
    backgroundMask20 = Color(0xFF000000).withValues(alpha: 0.2); // Mask20
    backgroundInput = Color(0xFFF7F7FB); // Input
    backgroundDisabled = Color(0xFFCACAD3); // Disabled
    backgroundPopup = const Color(0xFFF1F1F1); // Popup

    // Border边框色
    borderGutter = Color(0xFFF5F5F5); // Gutter
    borderSubtle = Color(0xFFEEEEEE); // Subtle
    borderInput = Color(0xFFEDF0F5); // Input
    borderButtonStrong = Color(0xFF111111); // Button-Strong
    borderButtonLine = Color(0xFFCECECE); // Button-Line

    // Functional 功能色 - Trade
    tradeGreenDefault = Color(0xFF008E8E); // Green-default
    tradeGreenFocus = Color(0xFF00BDA3); // Green-focus
    tradeGreenPressed = Color(0xFF007364); // Green-pressed
    tradeGreenDisable = Color(0xFF9FEAE0); // Green-disable
    tradeGreenBackground = Color(0xFFD2FBF5); // Green-background
    tradeRedDefault = Color(0xFFEE2E76); // Red-default
    tradeRedFocus = Color(0xFFFF5393); // Red-focus
    tradeRedPressed = Color(0xFFB2104C); // Red-pressed
    tradeRedDisable = Color(0xFFFFD0E1); // Red-disable
    tradeRedBackground = Color(0xFFFFE7F0);

    // Functional 功能色 - Kline
    klineGreen = Color(0xFF6DA544); // green
    klinePurple = Color(0xFF8F3EFF); // purple
    klinePink = Color(0xFFFF3BA7); // pink
    klineBlue = Color(0xFF1F71FF); // blue
    klineYellow = Color(0xFFFFCC31); // yellow
  }

  AppColor._darkInit() {
    primary50 = Color(0xFF2A1B16); // 50 - 在dark模式中最深
    primary100 = Color(0xFF52342C); // 100
    primary200 = Color(0xFF6F4537); // 200
    primary300 = Color(0xFF8B5542); // 300
    primary400 = Color(0xFFA4634D); // 400
    primary500 = Color(0xFFA4634D); // 500 - 主色保持一致
    primary600 = Color(0xFFE0A085); // 600
    primary700 = Color(0xFFECC4B0); // 700
    primary800 = Color(0xFFF4DDD1); // 800
    primary900 = Color(0xFFFAF0EB); // 900 - 在dark模式中最浅

    // Gray / Solid
    graySolid50 = Color(0xFF050506);
    graySolid100 = Color(0xFF0C0C0E);
    graySolid200 = Color(0xFF101013);
    graySolid300 = Color(0xFF151519);
    graySolid400 = Color(0xFF1B1B20);
    graySolid500 = Color(0xFF444450);
    graySolid600 = Color(0xFF6E6E82);
    graySolid700 = Color(0xFF9E9EAD);
    graySolid800 = Color(0xFFCDCDD5);
    graySolid900 = Color(0xFFE6E6EA);

    // Gray / Alpha (base: #101013)
    grayAlpha5 = const Color(0xFF101013).withValues(alpha: 0.05);
    grayAlpha10 = const Color(0xFF101013).withValues(alpha: 0.10);
    grayAlpha20 = const Color(0xFF101013).withValues(alpha: 0.20);
    grayAlpha30 = const Color(0xFF101013).withValues(alpha: 0.30);
    grayAlpha40 = const Color(0xFF101013).withValues(alpha: 0.40);
    grayAlpha50 = const Color(0xFF101013).withValues(alpha: 0.50);
    grayAlpha60 = const Color(0xFF101013).withValues(alpha: 0.60);
    grayAlpha70 = const Color(0xFF101013).withValues(alpha: 0.70);
    grayAlpha80 = const Color(0xFF101013).withValues(alpha: 0.80);
    grayAlpha90 = const Color(0xFF101013).withValues(alpha: 0.90);

    // Status 状态色
    success = Color(0xFF17CF60);
    success5 = success.withValues(alpha: 0.05);
    success10 = success.withValues(alpha: 0.10);
    success20 = success.withValues(alpha: 0.20);
    success30 = success.withValues(alpha: 0.30);
    success40 = success.withValues(alpha: 0.40);
    success50 = success.withValues(alpha: 0.50);
    success60 = success.withValues(alpha: 0.60);
    success70 = success.withValues(alpha: 0.70);
    success80 = success.withValues(alpha: 0.80);
    success90 = success.withValues(alpha: 0.90);
    success100 = success; // 1.0

    error = Color(0xFFE32D2D);
    error5 = error.withValues(alpha: 0.05);
    error10 = error.withValues(alpha: 0.10);
    error20 = error.withValues(alpha: 0.20);
    error30 = error.withValues(alpha: 0.30);
    error40 = error.withValues(alpha: 0.40);
    error50 = error.withValues(alpha: 0.50);
    error60 = error.withValues(alpha: 0.60);
    error70 = error.withValues(alpha: 0.70);
    error80 = error.withValues(alpha: 0.80);
    error90 = error.withValues(alpha: 0.90);
    error100 = error; // 1.0

    // Text文字色
    textPrimary = Color(0xFFFFFFFF); // Primary
    textSecondary = Color(0xFFE2E2E9); // Secondary
    textTertiary = Color(0xFFAEAEC1); // Tertiary
    textDescription = Color(0xFF7A7A9A); // Description
    textTips = Color(0xFF4F4F68); // Tips
    textDisable = Color(0xFF414157); // Disbled
    textInversePrimary = Color(0xFF000000); // Inverse-Primary
    textInverseSecondary = Color(0xFF282834); // inverse-secondary
    textInverseTertiary = Color(0xFF3A3A51); // Inverse-tertiary

    // Background背景色
    backgroundPrimary = Color(0xFF050506); // Primary
    backgroundSecondary = Color(0xFF101013); // Secondary
    backgroundTertiary = Color(0xFF1B1B20); // Tertiary
    backgroundInversePrimary = Color(0xFFFFFFFF); // Inverse-Primary
    backgroundInverseDisabled = Color(0xFF363738); // Inverse-Disabled
    backgroundMask40 = Color(0xFF000000).withValues(alpha: 0.4); // Mask40
    backgroundMask20 = Color(0xFF000000).withValues(alpha: 0.2); // Mask20
    backgroundInput = Color(0xFF1B1B20); // Input
    backgroundDisabled = Color(0xFF282B31); // Disabled
    backgroundPopup = const Color(0xFF19191A); // Popup

    // Border边框色
    borderGutter = Color(0xFF1D1D22); // Gutter
    borderSubtle = Color(0xFF27272E); // Subtle
    borderInput = Color(0xFF393942); // Input
    borderButtonStrong = Color(0xFFFFFFFF); // Button-Strong
    borderButtonLine = Color(0xFF4E4E5A); // Button-Line

    // Functional 功能色 - Trade
    tradeGreenDefault = Color(0xFF00B6AA); // Green-default
    tradeGreenFocus = Color(0xFF00D1B5); // Green-focus
    tradeGreenPressed = Color(0xFF008876); // Green-pressed
    tradeGreenDisable = Color(0xFF00493F); // Green-disable
    tradeGreenBackground = Color(0xFF00302A); // Green-background
    tradeRedDefault = Color(0xFFEE2E76); // Red-default
    tradeRedFocus = Color(0xFFFF5393); // Red-focus
    tradeRedPressed = Color(0xFFB2104C); // Red-pressed
    tradeRedDisable = Color(0xFF470820); // Red-disable
    tradeRedBackground = Color(0xFF280110);

    // Functional 功能色 - Kline
    klineGreen = Color(0xFF6DA544); // green
    klinePurple = Color(0xFF8F3EFF); // purple
    klinePink = Color(0xFFFF3BA7); // pink
    klineBlue = Color(0xFF1F71FF); // blue
    klineYellow = Color(0xFFFFCC31); // yellow
  }
}

enum UpDownColorType {
  // 绿涨红跌
  greenUpRedDown,
  // 红涨绿跌
  redUpGreenDown,
}
