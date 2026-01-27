import 'package:flutter/material.dart';

import 'app_theme.dart';

extension TextStyleExt on BuildContext {
  /// 基本字体样式
  TextStyle get f32Bold =>
      appTextStyle(fontSize: 32, fontWeight: FontWeight.bold, lineHeight: 46);

  TextStyle get f28Bold =>
      appTextStyle(fontSize: 28, fontWeight: FontWeight.bold, lineHeight: 34);

  TextStyle get f28Medium =>
      appTextStyle(fontSize: 28, fontWeight: FontWeight.w500, lineHeight: 34);

  TextStyle get f28Regular =>
      appTextStyle(fontSize: 28, fontWeight: FontWeight.w400, lineHeight: 34);

  TextStyle get f24Bold =>
      appTextStyle(fontSize: 24, fontWeight: FontWeight.bold, lineHeight: 34);

  TextStyle get f24Medium =>
      appTextStyle(fontSize: 20, fontWeight: FontWeight.w500, lineHeight: 34);

  TextStyle get f24Regular =>
      appTextStyle(fontSize: 20, fontWeight: FontWeight.w400, lineHeight: 34);

  TextStyle get f20Bold =>
      appTextStyle(fontSize: 20, fontWeight: FontWeight.bold, lineHeight: 28);

  TextStyle get f20Medium =>
      appTextStyle(fontSize: 20, fontWeight: FontWeight.w500, lineHeight: 28);

  TextStyle get f20Regular =>
      appTextStyle(fontSize: 20, fontWeight: FontWeight.w400, lineHeight: 28);

  TextStyle get f18Bold =>
      appTextStyle(fontSize: 18, fontWeight: FontWeight.bold, lineHeight: 26);

  TextStyle get f18Medium =>
      appTextStyle(fontSize: 18, fontWeight: FontWeight.w500, lineHeight: 26);

  TextStyle get f18Regular =>
      appTextStyle(fontSize: 18, fontWeight: FontWeight.w400, lineHeight: 26);

  TextStyle get f16Bold =>
      appTextStyle(fontSize: 16, fontWeight: FontWeight.bold, lineHeight: 24);

  TextStyle get f16Medium =>
      appTextStyle(fontSize: 16, fontWeight: FontWeight.w500, lineHeight: 24);

  TextStyle get f16Regular =>
      appTextStyle(fontSize: 16, fontWeight: FontWeight.w400, lineHeight: 24);

  TextStyle get f15Bold =>
      appTextStyle(fontSize: 15, fontWeight: FontWeight.bold, lineHeight: 22);

  TextStyle get f15Medium =>
      appTextStyle(fontSize: 15, fontWeight: FontWeight.w500, lineHeight: 22);

  TextStyle get f15Regular =>
      appTextStyle(fontSize: 15, fontWeight: FontWeight.w400, lineHeight: 22);

  TextStyle get f14Bold =>
      appTextStyle(fontSize: 14, fontWeight: FontWeight.bold, lineHeight: 20);

  TextStyle get f14Medium =>
      appTextStyle(fontSize: 14, fontWeight: FontWeight.w500, lineHeight: 20);

  TextStyle get f14Regular =>
      appTextStyle(fontSize: 14, fontWeight: FontWeight.w400, lineHeight: 20);

  TextStyle get f13Bold =>
      appTextStyle(fontSize: 13, fontWeight: FontWeight.bold, lineHeight: 18);

  TextStyle get f13Medium =>
      appTextStyle(fontSize: 13, fontWeight: FontWeight.w500, lineHeight: 18);

  TextStyle get f13Regular =>
      appTextStyle(fontSize: 13, fontWeight: FontWeight.w400, lineHeight: 18);

  TextStyle get f12Bold =>
      appTextStyle(fontSize: 12, fontWeight: FontWeight.bold, lineHeight: 16);

  TextStyle get f12Medium =>
      appTextStyle(fontSize: 12, fontWeight: FontWeight.w500, lineHeight: 16);

  TextStyle get f12Regular =>
      appTextStyle(fontSize: 12, fontWeight: FontWeight.w400, lineHeight: 16);

  TextStyle get f11Bold =>
      appTextStyle(fontSize: 11, fontWeight: FontWeight.bold, lineHeight: 16);

  TextStyle get f11Medium =>
      appTextStyle(fontSize: 11, fontWeight: FontWeight.w500, lineHeight: 16);

  TextStyle get f11Regular =>
      appTextStyle(fontSize: 11, fontWeight: FontWeight.w400, lineHeight: 16);

  TextStyle get f10Bold =>
      appTextStyle(fontSize: 10, fontWeight: FontWeight.bold, lineHeight: 14);

  TextStyle get f10Medium =>
      appTextStyle(fontSize: 10, fontWeight: FontWeight.w500, lineHeight: 14);

  TextStyle get f10Regular =>
      appTextStyle(fontSize: 10, fontWeight: FontWeight.w400, lineHeight: 14);

  TextStyle get f9Bold =>
      appTextStyle(fontSize: 9, fontWeight: FontWeight.bold, lineHeight: 14);

  TextStyle get f9Medium =>
      appTextStyle(fontSize: 9, fontWeight: FontWeight.w500, lineHeight: 14);

  TextStyle get f9Regular =>
      appTextStyle(fontSize: 9, fontWeight: FontWeight.w400, lineHeight: 14);
}

extension TextStyleExt1 on BuildContext {
  /// f32Bold
  TextStyle get f32BoldAlwaysWhite =>
      f32Bold.copyWith(color: appColor.alwaysWhite);
  TextStyle get f32BoldAlwaysBlack =>
      f32Bold.copyWith(color: appColor.alwaysBlack);
  TextStyle get f32BoldAlwaysToast =>
      f32Bold.copyWith(color: appColor.alwaysToast);
  TextStyle get f32BoldAlwaysMask =>
      f32Bold.copyWith(color: appColor.alwaysMask);
  TextStyle get f32BoldTextPrimary =>
      f32Bold.copyWith(color: appColor.textPrimary);
  TextStyle get f32BoldTextSecondary =>
      f32Bold.copyWith(color: appColor.textSecondary);
  TextStyle get f32BoldTextTertiary =>
      f32Bold.copyWith(color: appColor.textTertiary);
  TextStyle get f32BoldTextDescription =>
      f32Bold.copyWith(color: appColor.textDescription);
  TextStyle get f32BoldTextTips => f32Bold.copyWith(color: appColor.textTips);
  TextStyle get f32BoldTextDisable =>
      f32Bold.copyWith(color: appColor.textDisable);
  TextStyle get f32BoldTextInversePrimary =>
      f32Bold.copyWith(color: appColor.textInversePrimary);
  TextStyle get f32BoldTextInverseSecondary =>
      f32Bold.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f32BoldTextInverseTertiary =>
      f32Bold.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f32BoldPrimary500 =>
      f32Bold.copyWith(color: appColor.primary500);

  /// f28字体
  TextStyle get f28BoldAlwaysWhite =>
      f28Bold.copyWith(color: appColor.alwaysWhite);
  TextStyle get f28BoldAlwaysBlack =>
      f28Bold.copyWith(color: appColor.alwaysBlack);
  TextStyle get f28BoldAlwaysToast =>
      f28Bold.copyWith(color: appColor.alwaysToast);
  TextStyle get f28BoldAlwaysMask =>
      f28Bold.copyWith(color: appColor.alwaysMask);
  TextStyle get f28BoldTextPrimary =>
      f28Bold.copyWith(color: appColor.textPrimary);
  TextStyle get f28BoldTextSecondary =>
      f28Bold.copyWith(color: appColor.textSecondary);
  TextStyle get f28BoldTextTertiary =>
      f28Bold.copyWith(color: appColor.textTertiary);
  TextStyle get f28BoldTextDescription =>
      f28Bold.copyWith(color: appColor.textDescription);
  TextStyle get f28BoldTextTips => f28Bold.copyWith(color: appColor.textTips);
  TextStyle get f28BoldTextDisable =>
      f28Bold.copyWith(color: appColor.textDisable);
  TextStyle get f28BoldTextInversePrimary =>
      f28Bold.copyWith(color: appColor.textInversePrimary);
  TextStyle get f28BoldTextInverseSecondary =>
      f28Bold.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f28BoldTextInverseTertiary =>
      f28Bold.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f28BoldPrimary500 =>
      f28Bold.copyWith(color: appColor.primary500);

  // f28Medium
  TextStyle get f28MediumAlwaysWhite =>
      f28Medium.copyWith(color: appColor.alwaysWhite);
  TextStyle get f28MediumAlwaysBlack =>
      f28Medium.copyWith(color: appColor.alwaysBlack);
  TextStyle get f28MediumAlwaysToast =>
      f28Medium.copyWith(color: appColor.alwaysToast);
  TextStyle get f28MediumAlwaysMask =>
      f28Medium.copyWith(color: appColor.alwaysMask);
  TextStyle get f28MediumTextPrimary =>
      f28Medium.copyWith(color: appColor.textPrimary);
  TextStyle get f28MediumTextSecondary =>
      f28Medium.copyWith(color: appColor.textSecondary);
  TextStyle get f28MediumTextTertiary =>
      f28Medium.copyWith(color: appColor.textTertiary);
  TextStyle get f28MediumTextDescription =>
      f28Medium.copyWith(color: appColor.textDescription);
  TextStyle get f28MediumTextTips =>
      f28Medium.copyWith(color: appColor.textTips);
  TextStyle get f28MediumTextDisable =>
      f28Medium.copyWith(color: appColor.textDisable);
  TextStyle get f28MediumTextInversePrimary =>
      f28Medium.copyWith(color: appColor.textInversePrimary);
  TextStyle get f28MediumTextInverseSecondary =>
      f28Medium.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f28MediumTextInverseTertiary =>
      f28Medium.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f28MediumPrimary500 =>
      f28Medium.copyWith(color: appColor.primary500);

  // f28Regular
  TextStyle get f28RegularAlwaysWhite =>
      f28Regular.copyWith(color: appColor.alwaysWhite);
  TextStyle get f28RegularAlwaysBlack =>
      f28Regular.copyWith(color: appColor.alwaysBlack);
  TextStyle get f28RegularAlwaysToast =>
      f28Regular.copyWith(color: appColor.alwaysToast);
  TextStyle get f28RegularAlwaysMask =>
      f28Regular.copyWith(color: appColor.alwaysMask);
  TextStyle get f28RegularTextPrimary =>
      f28Regular.copyWith(color: appColor.textPrimary);
  TextStyle get f28RegularTextSecondary =>
      f28Regular.copyWith(color: appColor.textSecondary);
  TextStyle get f28RegularTextTertiary =>
      f28Regular.copyWith(color: appColor.textTertiary);
  TextStyle get f28RegularTextDescription =>
      f28Regular.copyWith(color: appColor.textDescription);
  TextStyle get f28RegularTextTips =>
      f28Regular.copyWith(color: appColor.textTips);
  TextStyle get f28RegularTextDisable =>
      f28Regular.copyWith(color: appColor.textDisable);
  TextStyle get f28RegularTextInversePrimary =>
      f28Regular.copyWith(color: appColor.textInversePrimary);
  TextStyle get f28RegularTextInverseSecondary =>
      f28Regular.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f28RegularTextInverseTertiary =>
      f28Regular.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f28RegularPrimary500 =>
      f28Regular.copyWith(color: appColor.primary500);

  /// 参考32字体，将所有按照上面的方式进行扩展
  TextStyle get f24BoldAlwaysWhite =>
      f24Bold.copyWith(color: appColor.alwaysWhite);
  TextStyle get f24BoldAlwaysBlack =>
      f24Bold.copyWith(color: appColor.alwaysBlack);
  TextStyle get f24BoldAlwaysToast =>
      f24Bold.copyWith(color: appColor.alwaysToast);
  TextStyle get f24BoldAlwaysMask =>
      f24Bold.copyWith(color: appColor.alwaysMask);
  TextStyle get f24BoldTextPrimary =>
      f24Bold.copyWith(color: appColor.textPrimary);
  TextStyle get f24BoldTextSecondary =>
      f24Bold.copyWith(color: appColor.textSecondary);
  TextStyle get f24BoldTextTertiary =>
      f24Bold.copyWith(color: appColor.textTertiary);
  TextStyle get f24BoldTextDescription =>
      f24Bold.copyWith(color: appColor.textDescription);
  TextStyle get f24BoldTextTips => f24Bold.copyWith(color: appColor.textTips);
  TextStyle get f24BoldTextDisable =>
      f24Bold.copyWith(color: appColor.textDisable);
  TextStyle get f24BoldTextInversePrimary =>
      f24Bold.copyWith(color: appColor.textInversePrimary);
  TextStyle get f24BoldTextInverseSecondary =>
      f24Bold.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f24BoldTextInverseTertiary =>
      f24Bold.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f24BoldPrimary500 =>
      f24Bold.copyWith(color: appColor.primary500);

  // f24Medium
  TextStyle get f24MediumAlwaysWhite =>
      f24Medium.copyWith(color: appColor.alwaysWhite);
  TextStyle get f24MediumAlwaysBlack =>
      f24Medium.copyWith(color: appColor.alwaysBlack);
  TextStyle get f24MediumAlwaysToast =>
      f24Medium.copyWith(color: appColor.alwaysToast);
  TextStyle get f24MediumAlwaysMask =>
      f24Medium.copyWith(color: appColor.alwaysMask);
  TextStyle get f24MediumTextPrimary =>
      f24Medium.copyWith(color: appColor.textPrimary);
  TextStyle get f24MediumTextSecondary =>
      f24Medium.copyWith(color: appColor.textSecondary);
  TextStyle get f24MediumTextTertiary =>
      f24Medium.copyWith(color: appColor.textTertiary);
  TextStyle get f24MediumTextDescription =>
      f24Medium.copyWith(color: appColor.textDescription);
  TextStyle get f24MediumTextTips =>
      f24Medium.copyWith(color: appColor.textTips);
  TextStyle get f24MediumTextDisable =>
      f24Medium.copyWith(color: appColor.textDisable);
  TextStyle get f24MediumTextInversePrimary =>
      f24Medium.copyWith(color: appColor.textInversePrimary);
  TextStyle get f24MediumTextInverseSecondary =>
      f24Medium.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f24MediumTextInverseTertiary =>
      f24Medium.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f24MediumPrimary500 =>
      f24Medium.copyWith(color: appColor.primary500);

  // f24Regular
  TextStyle get f24RegularAlwaysWhite =>
      f24Regular.copyWith(color: appColor.alwaysWhite);
  TextStyle get f24RegularAlwaysBlack =>
      f24Regular.copyWith(color: appColor.alwaysBlack);
  TextStyle get f24RegularAlwaysToast =>
      f24Regular.copyWith(color: appColor.alwaysToast);
  TextStyle get f24RegularAlwaysMask =>
      f24Regular.copyWith(color: appColor.alwaysMask);
  TextStyle get f24RegularTextPrimary =>
      f24Regular.copyWith(color: appColor.textPrimary);
  TextStyle get f24RegularTextSecondary =>
      f24Regular.copyWith(color: appColor.textSecondary);
  TextStyle get f24RegularTextTertiary =>
      f24Regular.copyWith(color: appColor.textTertiary);
  TextStyle get f24RegularTextDescription =>
      f24Regular.copyWith(color: appColor.textDescription);
  TextStyle get f24RegularTextTips =>
      f24Regular.copyWith(color: appColor.textTips);
  TextStyle get f24RegularTextDisable =>
      f24Regular.copyWith(color: appColor.textDisable);
  TextStyle get f24RegularTextInversePrimary =>
      f24Regular.copyWith(color: appColor.textInversePrimary);
  TextStyle get f24RegularTextInverseSecondary =>
      f24Regular.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f24RegularTextInverseTertiary =>
      f24Regular.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f24RegularPrimary500 =>
      f24Regular.copyWith(color: appColor.primary500);

  // f20Bold
  TextStyle get f20BoldAlwaysWhite =>
      f20Bold.copyWith(color: appColor.alwaysWhite);
  TextStyle get f20BoldAlwaysBlack =>
      f20Bold.copyWith(color: appColor.alwaysBlack);
  TextStyle get f20BoldAlwaysToast =>
      f20Bold.copyWith(color: appColor.alwaysToast);
  TextStyle get f20BoldAlwaysMask =>
      f20Bold.copyWith(color: appColor.alwaysMask);
  TextStyle get f20BoldTextPrimary =>
      f20Bold.copyWith(color: appColor.textPrimary);
  TextStyle get f20BoldTextSecondary =>
      f20Bold.copyWith(color: appColor.textSecondary);
  TextStyle get f20BoldTextTertiary =>
      f20Bold.copyWith(color: appColor.textTertiary);
  TextStyle get f20BoldTextDescription =>
      f20Bold.copyWith(color: appColor.textDescription);
  TextStyle get f20BoldTextTips => f20Bold.copyWith(color: appColor.textTips);
  TextStyle get f20BoldTextDisable =>
      f20Bold.copyWith(color: appColor.textDisable);
  TextStyle get f20BoldTextInversePrimary =>
      f20Bold.copyWith(color: appColor.textInversePrimary);
  TextStyle get f20BoldTextInverseSecondary =>
      f20Bold.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f20BoldTextInverseTertiary =>
      f20Bold.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f20BoldPrimary500 =>
      f20Bold.copyWith(color: appColor.primary500);

  // f20Medium
  TextStyle get f20MediumAlwaysWhite =>
      f20Medium.copyWith(color: appColor.alwaysWhite);
  TextStyle get f20MediumAlwaysBlack =>
      f20Medium.copyWith(color: appColor.alwaysBlack);
  TextStyle get f20MediumAlwaysToast =>
      f20Medium.copyWith(color: appColor.alwaysToast);
  TextStyle get f20MediumAlwaysMask =>
      f20Medium.copyWith(color: appColor.alwaysMask);
  TextStyle get f20MediumTextPrimary =>
      f20Medium.copyWith(color: appColor.textPrimary);
  TextStyle get f20MediumTextSecondary =>
      f20Medium.copyWith(color: appColor.textSecondary);
  TextStyle get f20MediumTextTertiary =>
      f20Medium.copyWith(color: appColor.textTertiary);
  TextStyle get f20MediumTextDescription =>
      f20Medium.copyWith(color: appColor.textDescription);
  TextStyle get f20MediumTextTips =>
      f20Medium.copyWith(color: appColor.textTips);
  TextStyle get f20MediumTextDisable =>
      f20Medium.copyWith(color: appColor.textDisable);
  TextStyle get f20MediumTextInversePrimary =>
      f20Medium.copyWith(color: appColor.textInversePrimary);
  TextStyle get f20MediumTextInverseSecondary =>
      f20Medium.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f20MediumTextInverseTertiary =>
      f20Medium.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f20MediumPrimary500 =>
      f20Medium.copyWith(color: appColor.primary500);

  // f20Regular
  TextStyle get f20RegularAlwaysWhite =>
      f20Regular.copyWith(color: appColor.alwaysWhite);
  TextStyle get f20RegularAlwaysBlack =>
      f20Regular.copyWith(color: appColor.alwaysBlack);
  TextStyle get f20RegularAlwaysToast =>
      f20Regular.copyWith(color: appColor.alwaysToast);
  TextStyle get f20RegularAlwaysMask =>
      f20Regular.copyWith(color: appColor.alwaysMask);
  TextStyle get f20RegularTextPrimary =>
      f20Regular.copyWith(color: appColor.textPrimary);
  TextStyle get f20RegularTextSecondary =>
      f20Regular.copyWith(color: appColor.textSecondary);
  TextStyle get f20RegularTextTertiary =>
      f20Regular.copyWith(color: appColor.textTertiary);
  TextStyle get f20RegularTextDescription =>
      f20Regular.copyWith(color: appColor.textDescription);
  TextStyle get f20RegularTextTips =>
      f20Regular.copyWith(color: appColor.textTips);
  TextStyle get f20RegularTextDisable =>
      f20Regular.copyWith(color: appColor.textDisable);
  TextStyle get f20RegularTextInversePrimary =>
      f20Regular.copyWith(color: appColor.textInversePrimary);
  TextStyle get f20RegularTextInverseSecondary =>
      f20Regular.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f20RegularTextInverseTertiary =>
      f20Regular.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f20RegularPrimary500 =>
      f20Regular.copyWith(color: appColor.primary500);

  // f18Bold
  TextStyle get f18BoldAlwaysWhite =>
      f18Bold.copyWith(color: appColor.alwaysWhite);
  TextStyle get f18BoldAlwaysBlack =>
      f18Bold.copyWith(color: appColor.alwaysBlack);
  TextStyle get f18BoldAlwaysToast =>
      f18Bold.copyWith(color: appColor.alwaysToast);
  TextStyle get f18BoldAlwaysMask =>
      f18Bold.copyWith(color: appColor.alwaysMask);
  TextStyle get f18BoldTextPrimary =>
      f18Bold.copyWith(color: appColor.textPrimary);
  TextStyle get f18BoldTextSecondary =>
      f18Bold.copyWith(color: appColor.textSecondary);
  TextStyle get f18BoldTextTertiary =>
      f18Bold.copyWith(color: appColor.textTertiary);
  TextStyle get f18BoldTextDescription =>
      f18Bold.copyWith(color: appColor.textDescription);
  TextStyle get f18BoldTextTips => f18Bold.copyWith(color: appColor.textTips);
  TextStyle get f18BoldTextDisable =>
      f18Bold.copyWith(color: appColor.textDisable);
  TextStyle get f18BoldTextInversePrimary =>
      f18Bold.copyWith(color: appColor.textInversePrimary);
  TextStyle get f18BoldTextInverseSecondary =>
      f18Bold.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f18BoldTextInverseTertiary =>
      f18Bold.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f18BoldPrimary500 =>
      f18Bold.copyWith(color: appColor.primary500);

  // f18Medium
  TextStyle get f18MediumAlwaysWhite =>
      f18Medium.copyWith(color: appColor.alwaysWhite);
  TextStyle get f18MediumAlwaysBlack =>
      f18Medium.copyWith(color: appColor.alwaysBlack);
  TextStyle get f18MediumAlwaysToast =>
      f18Medium.copyWith(color: appColor.alwaysToast);
  TextStyle get f18MediumAlwaysMask =>
      f18Medium.copyWith(color: appColor.alwaysMask);
  TextStyle get f18MediumTextPrimary =>
      f18Medium.copyWith(color: appColor.textPrimary);
  TextStyle get f18MediumTextSecondary =>
      f18Medium.copyWith(color: appColor.textSecondary);
  TextStyle get f18MediumTextTertiary =>
      f18Medium.copyWith(color: appColor.textTertiary);
  TextStyle get f18MediumTextDescription =>
      f18Medium.copyWith(color: appColor.textDescription);
  TextStyle get f18MediumTextTips =>
      f18Medium.copyWith(color: appColor.textTips);
  TextStyle get f18MediumTextDisable =>
      f18Medium.copyWith(color: appColor.textDisable);
  TextStyle get f18MediumTextInversePrimary =>
      f18Medium.copyWith(color: appColor.textInversePrimary);
  TextStyle get f18MediumTextInverseSecondary =>
      f18Medium.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f18MediumTextInverseTertiary =>
      f18Medium.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f18MediumPrimary500 =>
      f18Medium.copyWith(color: appColor.primary500);

  // f18Regular
  TextStyle get f18RegularAlwaysWhite =>
      f18Regular.copyWith(color: appColor.alwaysWhite);
  TextStyle get f18RegularAlwaysBlack =>
      f18Regular.copyWith(color: appColor.alwaysBlack);
  TextStyle get f18RegularAlwaysToast =>
      f18Regular.copyWith(color: appColor.alwaysToast);
  TextStyle get f18RegularAlwaysMask =>
      f18Regular.copyWith(color: appColor.alwaysMask);
  TextStyle get f18RegularTextPrimary =>
      f18Regular.copyWith(color: appColor.textPrimary);
  TextStyle get f18RegularTextSecondary =>
      f18Regular.copyWith(color: appColor.textSecondary);
  TextStyle get f18RegularTextTertiary =>
      f18Regular.copyWith(color: appColor.textTertiary);
  TextStyle get f18RegularTextDescription =>
      f18Regular.copyWith(color: appColor.textDescription);
  TextStyle get f18RegularTextTips =>
      f18Regular.copyWith(color: appColor.textTips);
  TextStyle get f18RegularTextDisable =>
      f18Regular.copyWith(color: appColor.textDisable);
  TextStyle get f18RegularTextInversePrimary =>
      f18Regular.copyWith(color: appColor.textInversePrimary);
  TextStyle get f18RegularTextInverseSecondary =>
      f18Regular.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f18RegularTextInverseTertiary =>
      f18Regular.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f18RegularPrimary500 =>
      f18Regular.copyWith(color: appColor.primary500);

  // f16Bold
  TextStyle get f16BoldAlwaysWhite =>
      f16Bold.copyWith(color: appColor.alwaysWhite);
  TextStyle get f16BoldAlwaysBlack =>
      f16Bold.copyWith(color: appColor.alwaysBlack);
  TextStyle get f16BoldAlwaysToast =>
      f16Bold.copyWith(color: appColor.alwaysToast);
  TextStyle get f16BoldAlwaysMask =>
      f16Bold.copyWith(color: appColor.alwaysMask);
  TextStyle get f16BoldTextPrimary =>
      f16Bold.copyWith(color: appColor.textPrimary);
  TextStyle get f16BoldTextSecondary =>
      f16Bold.copyWith(color: appColor.textSecondary);
  TextStyle get f16BoldTextTertiary =>
      f16Bold.copyWith(color: appColor.textTertiary);
  TextStyle get f16BoldTextDescription =>
      f16Bold.copyWith(color: appColor.textDescription);
  TextStyle get f16BoldTextTips => f16Bold.copyWith(color: appColor.textTips);
  TextStyle get f16BoldTextDisable =>
      f16Bold.copyWith(color: appColor.textDisable);
  TextStyle get f16BoldTextInversePrimary =>
      f16Bold.copyWith(color: appColor.textInversePrimary);
  TextStyle get f16BoldTextInverseSecondary =>
      f16Bold.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f16BoldTextInverseTertiary =>
      f16Bold.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f16BoldPrimary500 =>
      f16Bold.copyWith(color: appColor.primary500);

  // f16Medium
  TextStyle get f16MediumAlwaysWhite =>
      f16Medium.copyWith(color: appColor.alwaysWhite);
  TextStyle get f16MediumAlwaysBlack =>
      f16Medium.copyWith(color: appColor.alwaysBlack);
  TextStyle get f16MediumAlwaysToast =>
      f16Medium.copyWith(color: appColor.alwaysToast);
  TextStyle get f16MediumAlwaysMask =>
      f16Medium.copyWith(color: appColor.alwaysMask);
  TextStyle get f16MediumTextPrimary =>
      f16Medium.copyWith(color: appColor.textPrimary);
  TextStyle get f16MediumTextSecondary =>
      f16Medium.copyWith(color: appColor.textSecondary);
  TextStyle get f16MediumTextTertiary =>
      f16Medium.copyWith(color: appColor.textTertiary);
  TextStyle get f16MediumTextDescription =>
      f16Medium.copyWith(color: appColor.textDescription);
  TextStyle get f16MediumTextTips =>
      f16Medium.copyWith(color: appColor.textTips);
  TextStyle get f16MediumTextDisable =>
      f16Medium.copyWith(color: appColor.textDisable);
  TextStyle get f16MediumTextInversePrimary =>
      f16Medium.copyWith(color: appColor.textInversePrimary);
  TextStyle get f16MediumTextInverseSecondary =>
      f16Medium.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f16MediumTextInverseTertiary =>
      f16Medium.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f16MediumPrimary500 =>
      f16Medium.copyWith(color: appColor.primary500);

  // f16Regular
  TextStyle get f16RegularAlwaysWhite =>
      f16Regular.copyWith(color: appColor.alwaysWhite);
  TextStyle get f16RegularAlwaysBlack =>
      f16Regular.copyWith(color: appColor.alwaysBlack);
  TextStyle get f16RegularAlwaysToast =>
      f16Regular.copyWith(color: appColor.alwaysToast);
  TextStyle get f16RegularAlwaysMask =>
      f16Regular.copyWith(color: appColor.alwaysMask);
  TextStyle get f16RegularTextPrimary =>
      f16Regular.copyWith(color: appColor.textPrimary);
  TextStyle get f16RegularTextSecondary =>
      f16Regular.copyWith(color: appColor.textSecondary);
  TextStyle get f16RegularTextTertiary =>
      f16Regular.copyWith(color: appColor.textTertiary);
  TextStyle get f16RegularTextDescription =>
      f16Regular.copyWith(color: appColor.textDescription);
  TextStyle get f16RegularTextTips =>
      f16Regular.copyWith(color: appColor.textTips);
  TextStyle get f16RegularTextDisable =>
      f16Regular.copyWith(color: appColor.textDisable);
  TextStyle get f16RegularTextInversePrimary =>
      f16Regular.copyWith(color: appColor.textInversePrimary);
  TextStyle get f16RegularTextInverseSecondary =>
      f16Regular.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f16RegularTextInverseTertiary =>
      f16Regular.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f16RegularPrimary500 =>
      f16Regular.copyWith(color: appColor.primary500);

  // f15Bold
  TextStyle get f15BoldAlwaysWhite =>
      f15Bold.copyWith(color: appColor.alwaysWhite);
  TextStyle get f15BoldAlwaysBlack =>
      f15Bold.copyWith(color: appColor.alwaysBlack);
  TextStyle get f15BoldAlwaysToast =>
      f15Bold.copyWith(color: appColor.alwaysToast);
  TextStyle get f15BoldAlwaysMask =>
      f15Bold.copyWith(color: appColor.alwaysMask);
  TextStyle get f15BoldTextPrimary =>
      f15Bold.copyWith(color: appColor.textPrimary);
  TextStyle get f15BoldTextSecondary =>
      f15Bold.copyWith(color: appColor.textSecondary);
  TextStyle get f15BoldTextTertiary =>
      f15Bold.copyWith(color: appColor.textTertiary);
  TextStyle get f15BoldTextDescription =>
      f15Bold.copyWith(color: appColor.textDescription);
  TextStyle get f15BoldTextTips => f15Bold.copyWith(color: appColor.textTips);
  TextStyle get f15BoldTextDisable =>
      f15Bold.copyWith(color: appColor.textDisable);
  TextStyle get f15BoldTextInversePrimary =>
      f15Bold.copyWith(color: appColor.textInversePrimary);
  TextStyle get f15BoldTextInverseSecondary =>
      f15Bold.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f15BoldTextInverseTertiary =>
      f15Bold.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f15BoldPrimary500 =>
      f15Bold.copyWith(color: appColor.primary500);

  // f15Medium
  TextStyle get f15MediumAlwaysWhite =>
      f15Medium.copyWith(color: appColor.alwaysWhite);
  TextStyle get f15MediumAlwaysBlack =>
      f15Medium.copyWith(color: appColor.alwaysBlack);
  TextStyle get f15MediumAlwaysToast =>
      f15Medium.copyWith(color: appColor.alwaysToast);
  TextStyle get f15MediumAlwaysMask =>
      f15Medium.copyWith(color: appColor.alwaysMask);
  TextStyle get f15MediumTextPrimary =>
      f15Medium.copyWith(color: appColor.textPrimary);
  TextStyle get f15MediumTextSecondary =>
      f15Medium.copyWith(color: appColor.textSecondary);
  TextStyle get f15MediumTextTertiary =>
      f15Medium.copyWith(color: appColor.textTertiary);
  TextStyle get f15MediumTextDescription =>
      f15Medium.copyWith(color: appColor.textDescription);
  TextStyle get f15MediumTextTips =>
      f15Medium.copyWith(color: appColor.textTips);
  TextStyle get f15MediumTextDisable =>
      f15Medium.copyWith(color: appColor.textDisable);
  TextStyle get f15MediumTextInversePrimary =>
      f15Medium.copyWith(color: appColor.textInversePrimary);
  TextStyle get f15MediumTextInverseSecondary =>
      f15Medium.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f15MediumTextInverseTertiary =>
      f15Medium.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f15MediumPrimary500 =>
      f15Medium.copyWith(color: appColor.primary500);

  // f15Regular
  TextStyle get f15RegularAlwaysWhite =>
      f15Regular.copyWith(color: appColor.alwaysWhite);
  TextStyle get f15RegularAlwaysBlack =>
      f15Regular.copyWith(color: appColor.alwaysBlack);
  TextStyle get f15RegularAlwaysToast =>
      f15Regular.copyWith(color: appColor.alwaysToast);
  TextStyle get f15RegularAlwaysMask =>
      f15Regular.copyWith(color: appColor.alwaysMask);
  TextStyle get f15RegularTextPrimary =>
      f15Regular.copyWith(color: appColor.textPrimary);
  TextStyle get f15RegularTextSecondary =>
      f15Regular.copyWith(color: appColor.textSecondary);
  TextStyle get f15RegularTextTertiary =>
      f15Regular.copyWith(color: appColor.textTertiary);
  TextStyle get f15RegularTextDescription =>
      f15Regular.copyWith(color: appColor.textDescription);
  TextStyle get f15RegularTextTips =>
      f15Regular.copyWith(color: appColor.textTips);
  TextStyle get f15RegularTextDisable =>
      f15Regular.copyWith(color: appColor.textDisable);
  TextStyle get f15RegularTextInversePrimary =>
      f15Regular.copyWith(color: appColor.textInversePrimary);
  TextStyle get f15RegularTextInverseSecondary =>
      f15Regular.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f15RegularTextInverseTertiary =>
      f15Regular.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f15RegularPrimary500 =>
      f15Regular.copyWith(color: appColor.primary500);

  // f14Bold
  TextStyle get f14BoldAlwaysWhite =>
      f14Bold.copyWith(color: appColor.alwaysWhite);
  TextStyle get f14BoldAlwaysBlack =>
      f14Bold.copyWith(color: appColor.alwaysBlack);
  TextStyle get f14BoldAlwaysToast =>
      f14Bold.copyWith(color: appColor.alwaysToast);
  TextStyle get f14BoldAlwaysMask =>
      f14Bold.copyWith(color: appColor.alwaysMask);
  TextStyle get f14BoldTextPrimary =>
      f14Bold.copyWith(color: appColor.textPrimary);
  TextStyle get f14BoldTextSecondary =>
      f14Bold.copyWith(color: appColor.textSecondary);
  TextStyle get f14BoldTextTertiary =>
      f14Bold.copyWith(color: appColor.textTertiary);
  TextStyle get f14BoldTextDescription =>
      f14Bold.copyWith(color: appColor.textDescription);
  TextStyle get f14BoldTextTips => f14Bold.copyWith(color: appColor.textTips);
  TextStyle get f14BoldTextDisable =>
      f14Bold.copyWith(color: appColor.textDisable);
  TextStyle get f14BoldTextInversePrimary =>
      f14Bold.copyWith(color: appColor.textInversePrimary);
  TextStyle get f14BoldTextInverseSecondary =>
      f14Bold.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f14BoldTextInverseTertiary =>
      f14Bold.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f14BoldPrimary500 =>
      f14Bold.copyWith(color: appColor.primary500);

  // f14Medium
  TextStyle get f14MediumAlwaysWhite =>
      f14Medium.copyWith(color: appColor.alwaysWhite);
  TextStyle get f14MediumAlwaysBlack =>
      f14Medium.copyWith(color: appColor.alwaysBlack);
  TextStyle get f14MediumAlwaysToast =>
      f14Medium.copyWith(color: appColor.alwaysToast);
  TextStyle get f14MediumAlwaysMask =>
      f14Medium.copyWith(color: appColor.alwaysMask);
  TextStyle get f14MediumTextPrimary =>
      f14Medium.copyWith(color: appColor.textPrimary);
  TextStyle get f14MediumTextSecondary =>
      f14Medium.copyWith(color: appColor.textSecondary);
  TextStyle get f14MediumTextTertiary =>
      f14Medium.copyWith(color: appColor.textTertiary);
  TextStyle get f14MediumTextDescription =>
      f14Medium.copyWith(color: appColor.textDescription);
  TextStyle get f14MediumTextTips =>
      f14Medium.copyWith(color: appColor.textTips);
  TextStyle get f14MediumTextDisable =>
      f14Medium.copyWith(color: appColor.textDisable);
  TextStyle get f14MediumTextInversePrimary =>
      f14Medium.copyWith(color: appColor.textInversePrimary);
  TextStyle get f14MediumTextInverseSecondary =>
      f14Medium.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f14MediumTextInverseTertiary =>
      f14Medium.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f14MediumPrimary500 =>
      f14Medium.copyWith(color: appColor.primary500);

  // f14Regular
  TextStyle get f14RegularAlwaysWhite =>
      f14Regular.copyWith(color: appColor.alwaysWhite);
  TextStyle get f14RegularAlwaysBlack =>
      f14Regular.copyWith(color: appColor.alwaysBlack);
  TextStyle get f14RegularAlwaysToast =>
      f14Regular.copyWith(color: appColor.alwaysToast);
  TextStyle get f14RegularAlwaysMask =>
      f14Regular.copyWith(color: appColor.alwaysMask);
  TextStyle get f14RegularTextPrimary =>
      f14Regular.copyWith(color: appColor.textPrimary);
  TextStyle get f14RegularTextSecondary =>
      f14Regular.copyWith(color: appColor.textSecondary);
  TextStyle get f14RegularTextTertiary =>
      f14Regular.copyWith(color: appColor.textTertiary);
  TextStyle get f14RegularTextDescription =>
      f14Regular.copyWith(color: appColor.textDescription);
  TextStyle get f14RegularTextTips =>
      f14Regular.copyWith(color: appColor.textTips);
  TextStyle get f14RegularTextDisable =>
      f14Regular.copyWith(color: appColor.textDisable);
  TextStyle get f14RegularTextInversePrimary =>
      f14Regular.copyWith(color: appColor.textInversePrimary);
  TextStyle get f14RegularTextInverseSecondary =>
      f14Regular.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f14RegularTextInverseTertiary =>
      f14Regular.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f14RegularPrimary500 =>
      f14Regular.copyWith(color: appColor.primary500);

  // f13Bold
  TextStyle get f13BoldAlwaysWhite =>
      f13Bold.copyWith(color: appColor.alwaysWhite);
  TextStyle get f13BoldAlwaysBlack =>
      f13Bold.copyWith(color: appColor.alwaysBlack);
  TextStyle get f13BoldAlwaysToast =>
      f13Bold.copyWith(color: appColor.alwaysToast);
  TextStyle get f13BoldAlwaysMask =>
      f13Bold.copyWith(color: appColor.alwaysMask);
  TextStyle get f13BoldTextPrimary =>
      f13Bold.copyWith(color: appColor.textPrimary);
  TextStyle get f13BoldTextSecondary =>
      f13Bold.copyWith(color: appColor.textSecondary);
  TextStyle get f13BoldTextTertiary =>
      f13Bold.copyWith(color: appColor.textTertiary);
  TextStyle get f13BoldTextDescription =>
      f13Bold.copyWith(color: appColor.textDescription);
  TextStyle get f13BoldTextTips => f13Bold.copyWith(color: appColor.textTips);
  TextStyle get f13BoldTextDisable =>
      f13Bold.copyWith(color: appColor.textDisable);
  TextStyle get f13BoldTextInversePrimary =>
      f13Bold.copyWith(color: appColor.textInversePrimary);
  TextStyle get f13BoldTextInverseSecondary =>
      f13Bold.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f13BoldTextInverseTertiary =>
      f13Bold.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f13BoldPrimary500 =>
      f13Bold.copyWith(color: appColor.primary500);

  // f13Medium
  TextStyle get f13MediumAlwaysWhite =>
      f13Medium.copyWith(color: appColor.alwaysWhite);
  TextStyle get f13MediumAlwaysBlack =>
      f13Medium.copyWith(color: appColor.alwaysBlack);
  TextStyle get f13MediumAlwaysToast =>
      f13Medium.copyWith(color: appColor.alwaysToast);
  TextStyle get f13MediumAlwaysMask =>
      f13Medium.copyWith(color: appColor.alwaysMask);
  TextStyle get f13MediumTextPrimary =>
      f13Medium.copyWith(color: appColor.textPrimary);
  TextStyle get f13MediumTextSecondary =>
      f13Medium.copyWith(color: appColor.textSecondary);
  TextStyle get f13MediumTextTertiary =>
      f13Medium.copyWith(color: appColor.textTertiary);
  TextStyle get f13MediumTextDescription =>
      f13Medium.copyWith(color: appColor.textDescription);
  TextStyle get f13MediumTextTips =>
      f13Medium.copyWith(color: appColor.textTips);
  TextStyle get f13MediumTextDisable =>
      f13Medium.copyWith(color: appColor.textDisable);
  TextStyle get f13MediumTextInversePrimary =>
      f13Medium.copyWith(color: appColor.textInversePrimary);
  TextStyle get f13MediumTextInverseSecondary =>
      f13Medium.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f13MediumTextInverseTertiary =>
      f13Medium.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f13MediumPrimary500 =>
      f13Medium.copyWith(color: appColor.primary500);

  // f13Regular
  TextStyle get f13RegularAlwaysWhite =>
      f13Regular.copyWith(color: appColor.alwaysWhite);
  TextStyle get f13RegularAlwaysBlack =>
      f13Regular.copyWith(color: appColor.alwaysBlack);
  TextStyle get f13RegularAlwaysToast =>
      f13Regular.copyWith(color: appColor.alwaysToast);
  TextStyle get f13RegularAlwaysMask =>
      f13Regular.copyWith(color: appColor.alwaysMask);
  TextStyle get f13RegularTextPrimary =>
      f13Regular.copyWith(color: appColor.textPrimary);
  TextStyle get f13RegularTextSecondary =>
      f13Regular.copyWith(color: appColor.textSecondary);
  TextStyle get f13RegularTextTertiary =>
      f13Regular.copyWith(color: appColor.textTertiary);
  TextStyle get f13RegularTextDescription =>
      f13Regular.copyWith(color: appColor.textDescription);
  TextStyle get f13RegularTextTips =>
      f13Regular.copyWith(color: appColor.textTips);
  TextStyle get f13RegularTextDisable =>
      f13Regular.copyWith(color: appColor.textDisable);
  TextStyle get f13RegularTextInversePrimary =>
      f13Regular.copyWith(color: appColor.textInversePrimary);
  TextStyle get f13RegularTextInverseSecondary =>
      f13Regular.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f13RegularTextInverseTertiary =>
      f13Regular.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f13RegularPrimary500 =>
      f13Regular.copyWith(color: appColor.primary500);

  // f12Bold
  TextStyle get f12BoldAlwaysWhite =>
      f12Bold.copyWith(color: appColor.alwaysWhite);
  TextStyle get f12BoldAlwaysBlack =>
      f12Bold.copyWith(color: appColor.alwaysBlack);
  TextStyle get f12BoldAlwaysToast =>
      f12Bold.copyWith(color: appColor.alwaysToast);
  TextStyle get f12BoldAlwaysMask =>
      f12Bold.copyWith(color: appColor.alwaysMask);
  TextStyle get f12BoldTextPrimary =>
      f12Bold.copyWith(color: appColor.textPrimary);
  TextStyle get f12BoldTextSecondary =>
      f12Bold.copyWith(color: appColor.textSecondary);
  TextStyle get f12BoldTextTertiary =>
      f12Bold.copyWith(color: appColor.textTertiary);
  TextStyle get f12BoldTextDescription =>
      f12Bold.copyWith(color: appColor.textDescription);
  TextStyle get f12BoldTextTips => f12Bold.copyWith(color: appColor.textTips);
  TextStyle get f12BoldTextDisable =>
      f12Bold.copyWith(color: appColor.textDisable);
  TextStyle get f12BoldTextInversePrimary =>
      f12Bold.copyWith(color: appColor.textInversePrimary);
  TextStyle get f12BoldTextInverseSecondary =>
      f12Bold.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f12BoldTextInverseTertiary =>
      f12Bold.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f12BoldPrimary500 =>
      f12Bold.copyWith(color: appColor.primary500);

  // f12Medium
  TextStyle get f12MediumAlwaysWhite =>
      f12Medium.copyWith(color: appColor.alwaysWhite);
  TextStyle get f12MediumAlwaysBlack =>
      f12Medium.copyWith(color: appColor.alwaysBlack);
  TextStyle get f12MediumAlwaysToast =>
      f12Medium.copyWith(color: appColor.alwaysToast);
  TextStyle get f12MediumAlwaysMask =>
      f12Medium.copyWith(color: appColor.alwaysMask);
  TextStyle get f12MediumTextPrimary =>
      f12Medium.copyWith(color: appColor.textPrimary);
  TextStyle get f12MediumTextSecondary =>
      f12Medium.copyWith(color: appColor.textSecondary);
  TextStyle get f12MediumTextTertiary =>
      f12Medium.copyWith(color: appColor.textTertiary);
  TextStyle get f12MediumTextDescription =>
      f12Medium.copyWith(color: appColor.textDescription);
  TextStyle get f12MediumTextTips =>
      f12Medium.copyWith(color: appColor.textTips);
  TextStyle get f12MediumTextDisable =>
      f12Medium.copyWith(color: appColor.textDisable);
  TextStyle get f12MediumTextInversePrimary =>
      f12Medium.copyWith(color: appColor.textInversePrimary);
  TextStyle get f12MediumTextInverseSecondary =>
      f12Medium.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f12MediumTextInverseTertiary =>
      f12Medium.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f12MediumPrimary500 =>
      f12Medium.copyWith(color: appColor.primary500);

  // f12Regular
  TextStyle get f12RegularAlwaysWhite =>
      f12Regular.copyWith(color: appColor.alwaysWhite);
  TextStyle get f12RegularAlwaysBlack =>
      f12Regular.copyWith(color: appColor.alwaysBlack);
  TextStyle get f12RegularAlwaysToast =>
      f12Regular.copyWith(color: appColor.alwaysToast);
  TextStyle get f12RegularAlwaysMask =>
      f12Regular.copyWith(color: appColor.alwaysMask);
  TextStyle get f12RegularTextPrimary =>
      f12Regular.copyWith(color: appColor.textPrimary);
  TextStyle get f12RegularTextSecondary =>
      f12Regular.copyWith(color: appColor.textSecondary);
  TextStyle get f12RegularTextTertiary =>
      f12Regular.copyWith(color: appColor.textTertiary);
  TextStyle get f12RegularTextDescription =>
      f12Regular.copyWith(color: appColor.textDescription);
  TextStyle get f12RegularTextTips =>
      f12Regular.copyWith(color: appColor.textTips);
  TextStyle get f12RegularTextDisable =>
      f12Regular.copyWith(color: appColor.textDisable);
  TextStyle get f12RegularTextInversePrimary =>
      f12Regular.copyWith(color: appColor.textInversePrimary);
  TextStyle get f12RegularTextInverseSecondary =>
      f12Regular.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f12RegularTextInverseTertiary =>
      f12Regular.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f12RegularPrimary500 =>
      f12Regular.copyWith(color: appColor.primary500);

  // f11Bold
  TextStyle get f11BoldAlwaysWhite =>
      f11Bold.copyWith(color: appColor.alwaysWhite);
  TextStyle get f11BoldAlwaysBlack =>
      f11Bold.copyWith(color: appColor.alwaysBlack);
  TextStyle get f11BoldAlwaysToast =>
      f11Bold.copyWith(color: appColor.alwaysToast);
  TextStyle get f11BoldAlwaysMask =>
      f11Bold.copyWith(color: appColor.alwaysMask);
  TextStyle get f11BoldTextPrimary =>
      f11Bold.copyWith(color: appColor.textPrimary);
  TextStyle get f11BoldTextSecondary =>
      f11Bold.copyWith(color: appColor.textSecondary);
  TextStyle get f11BoldTextTertiary =>
      f11Bold.copyWith(color: appColor.textTertiary);
  TextStyle get f11BoldTextDescription =>
      f11Bold.copyWith(color: appColor.textDescription);
  TextStyle get f11BoldTextTips => f11Bold.copyWith(color: appColor.textTips);
  TextStyle get f11BoldTextDisable =>
      f11Bold.copyWith(color: appColor.textDisable);
  TextStyle get f11BoldTextInversePrimary =>
      f11Bold.copyWith(color: appColor.textInversePrimary);
  TextStyle get f11BoldTextInverseSecondary =>
      f11Bold.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f11BoldTextInverseTertiary =>
      f11Bold.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f11BoldPrimary500 =>
      f11Bold.copyWith(color: appColor.primary500);

  // f11Medium
  TextStyle get f11MediumAlwaysWhite =>
      f11Medium.copyWith(color: appColor.alwaysWhite);
  TextStyle get f11MediumAlwaysBlack =>
      f11Medium.copyWith(color: appColor.alwaysBlack);
  TextStyle get f11MediumAlwaysToast =>
      f11Medium.copyWith(color: appColor.alwaysToast);
  TextStyle get f11MediumAlwaysMask =>
      f11Medium.copyWith(color: appColor.alwaysMask);
  TextStyle get f11MediumTextPrimary =>
      f11Medium.copyWith(color: appColor.textPrimary);
  TextStyle get f11MediumTextSecondary =>
      f11Medium.copyWith(color: appColor.textSecondary);
  TextStyle get f11MediumTextTertiary =>
      f11Medium.copyWith(color: appColor.textTertiary);
  TextStyle get f11MediumTextDescription =>
      f11Medium.copyWith(color: appColor.textDescription);
  TextStyle get f11MediumTextTips =>
      f11Medium.copyWith(color: appColor.textTips);
  TextStyle get f11MediumTextDisable =>
      f11Medium.copyWith(color: appColor.textDisable);
  TextStyle get f11MediumTextInversePrimary =>
      f11Medium.copyWith(color: appColor.textInversePrimary);
  TextStyle get f11MediumTextInverseSecondary =>
      f11Medium.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f11MediumTextInverseTertiary =>
      f11Medium.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f11MediumPrimary500 =>
      f11Medium.copyWith(color: appColor.primary500);

  // f11Regular
  TextStyle get f11RegularAlwaysWhite =>
      f11Regular.copyWith(color: appColor.alwaysWhite);
  TextStyle get f11RegularAlwaysBlack =>
      f11Regular.copyWith(color: appColor.alwaysBlack);
  TextStyle get f11RegularAlwaysToast =>
      f11Regular.copyWith(color: appColor.alwaysToast);
  TextStyle get f11RegularAlwaysMask =>
      f11Regular.copyWith(color: appColor.alwaysMask);
  TextStyle get f11RegularTextPrimary =>
      f11Regular.copyWith(color: appColor.textPrimary);
  TextStyle get f11RegularTextSecondary =>
      f11Regular.copyWith(color: appColor.textSecondary);
  TextStyle get f11RegularTextTertiary =>
      f11Regular.copyWith(color: appColor.textTertiary);
  TextStyle get f11RegularTextDescription =>
      f11Regular.copyWith(color: appColor.textDescription);
  TextStyle get f11RegularTextTips =>
      f11Regular.copyWith(color: appColor.textTips);
  TextStyle get f11RegularTextDisable =>
      f11Regular.copyWith(color: appColor.textDisable);
  TextStyle get f11RegularTextInversePrimary =>
      f11Regular.copyWith(color: appColor.textInversePrimary);
  TextStyle get f11RegularTextInverseSecondary =>
      f11Regular.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f11RegularTextInverseTertiary =>
      f11Regular.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f11RegularPrimary500 =>
      f11Regular.copyWith(color: appColor.primary500);

  // f10Bold
  TextStyle get f10BoldAlwaysWhite =>
      f10Bold.copyWith(color: appColor.alwaysWhite);
  TextStyle get f10BoldAlwaysBlack =>
      f10Bold.copyWith(color: appColor.alwaysBlack);
  TextStyle get f10BoldAlwaysToast =>
      f10Bold.copyWith(color: appColor.alwaysToast);
  TextStyle get f10BoldAlwaysMask =>
      f10Bold.copyWith(color: appColor.alwaysMask);
  TextStyle get f10BoldTextPrimary =>
      f10Bold.copyWith(color: appColor.textPrimary);
  TextStyle get f10BoldTextSecondary =>
      f10Bold.copyWith(color: appColor.textSecondary);
  TextStyle get f10BoldTextTertiary =>
      f10Bold.copyWith(color: appColor.textTertiary);
  TextStyle get f10BoldTextTips => f10Bold.copyWith(color: appColor.textTips);
  TextStyle get f10BoldTextDisable =>
      f10Bold.copyWith(color: appColor.textDisable);
  TextStyle get f10BoldTextInversePrimary =>
      f10Bold.copyWith(color: appColor.textInversePrimary);
  TextStyle get f10BoldTextInverseSecondary =>
      f10Bold.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f10BoldTextInverseTertiary =>
      f10Bold.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f10BoldPrimary500 =>
      f10Bold.copyWith(color: appColor.primary500);

  // f10Medium
  TextStyle get f10MediumAlwaysWhite =>
      f10Medium.copyWith(color: appColor.alwaysWhite);
  TextStyle get f10MediumAlwaysBlack =>
      f10Medium.copyWith(color: appColor.alwaysBlack);
  TextStyle get f10MediumAlwaysToast =>
      f10Medium.copyWith(color: appColor.alwaysToast);
  TextStyle get f10MediumAlwaysMask =>
      f10Medium.copyWith(color: appColor.alwaysMask);
  TextStyle get f10MediumTextPrimary =>
      f10Medium.copyWith(color: appColor.textPrimary);
  TextStyle get f10MediumTextSecondary =>
      f10Medium.copyWith(color: appColor.textSecondary);
  TextStyle get f10MediumTextTertiary =>
      f10Medium.copyWith(color: appColor.textTertiary);
  TextStyle get f10MediumTextDescription =>
      f10Medium.copyWith(color: appColor.textDescription);
  TextStyle get f10MediumTextTips =>
      f10Medium.copyWith(color: appColor.textTips);
  TextStyle get f10MediumTextDisable =>
      f10Medium.copyWith(color: appColor.textDisable);
  TextStyle get f10MediumTextInversePrimary =>
      f10Medium.copyWith(color: appColor.textInversePrimary);
  TextStyle get f10MediumTextInverseSecondary =>
      f10Medium.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f10MediumTextInverseTertiary =>
      f10Medium.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f10MediumPrimary500 =>
      f10Medium.copyWith(color: appColor.primary500);

  // f10Regular
  TextStyle get f10RegularAlwaysWhite =>
      f10Regular.copyWith(color: appColor.alwaysWhite);
  TextStyle get f10RegularAlwaysBlack =>
      f10Regular.copyWith(color: appColor.alwaysBlack);
  TextStyle get f10RegularAlwaysToast =>
      f10Regular.copyWith(color: appColor.alwaysToast);
  TextStyle get f10RegularAlwaysMask =>
      f10Regular.copyWith(color: appColor.alwaysMask);
  TextStyle get f10RegularTextPrimary =>
      f10Regular.copyWith(color: appColor.textPrimary);
  TextStyle get f10RegularTextSecondary =>
      f10Regular.copyWith(color: appColor.textSecondary);
  TextStyle get f10RegularTextTertiary =>
      f10Regular.copyWith(color: appColor.textTertiary);
  TextStyle get f10RegularTextTips =>
      f10Regular.copyWith(color: appColor.textTips);
  TextStyle get f10RegularTextDisable =>
      f10Regular.copyWith(color: appColor.textDisable);
  TextStyle get f10RegularTextInversePrimary =>
      f10Regular.copyWith(color: appColor.textInversePrimary);
  TextStyle get f10RegularTextInverseSecondary =>
      f10Regular.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f10RegularTextInverseTertiary =>
      f10Regular.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f10RegularPrimary500 =>
      f10Regular.copyWith(color: appColor.primary500);

  // f9Bold
  TextStyle get f9BoldAlwaysWhite =>
      f9Bold.copyWith(color: appColor.alwaysWhite);
  TextStyle get f9BoldAlwaysBlack =>
      f9Bold.copyWith(color: appColor.alwaysBlack);
  TextStyle get f9BoldAlwaysToast =>
      f9Bold.copyWith(color: appColor.alwaysToast);
  TextStyle get f9BoldAlwaysMask => f9Bold.copyWith(color: appColor.alwaysMask);
  TextStyle get f9BoldTextPrimary =>
      f9Bold.copyWith(color: appColor.textPrimary);
  TextStyle get f9BoldTextSecondary =>
      f9Bold.copyWith(color: appColor.textSecondary);
  TextStyle get f9BoldTextTertiary =>
      f9Bold.copyWith(color: appColor.textTertiary);
  TextStyle get f9BoldTextDescription =>
      f9Bold.copyWith(color: appColor.textDescription);
  TextStyle get f9BoldTextTips => f9Bold.copyWith(color: appColor.textTips);
  TextStyle get f9BoldTextDisable =>
      f9Bold.copyWith(color: appColor.textDisable);
  TextStyle get f9BoldTextInversePrimary =>
      f9Bold.copyWith(color: appColor.textInversePrimary);
  TextStyle get f9BoldTextInverseSecondary =>
      f9Bold.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f9BoldTextInverseTertiary =>
      f9Bold.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f9BoldPrimary500 => f9Bold.copyWith(color: appColor.primary500);

  // f9Medium
  TextStyle get f9MediumAlwaysWhite =>
      f9Medium.copyWith(color: appColor.alwaysWhite);
  TextStyle get f9MediumAlwaysBlack =>
      f9Medium.copyWith(color: appColor.alwaysBlack);
  TextStyle get f9MediumAlwaysToast =>
      f9Medium.copyWith(color: appColor.alwaysToast);
  TextStyle get f9MediumAlwaysMask =>
      f9Medium.copyWith(color: appColor.alwaysMask);
  TextStyle get f9MediumTextPrimary =>
      f9Medium.copyWith(color: appColor.textPrimary);
  TextStyle get f9MediumTextSecondary =>
      f9Medium.copyWith(color: appColor.textSecondary);
  TextStyle get f9MediumTextTertiary =>
      f9Medium.copyWith(color: appColor.textTertiary);
  TextStyle get f9MediumTextDescription =>
      f9Medium.copyWith(color: appColor.textDescription);
  TextStyle get f9MediumTextTips => f9Medium.copyWith(color: appColor.textTips);
  TextStyle get f9MediumTextDisable =>
      f9Medium.copyWith(color: appColor.textDisable);
  TextStyle get f9MediumTextInversePrimary =>
      f9Medium.copyWith(color: appColor.textInversePrimary);
  TextStyle get f9MediumTextInverseSecondary =>
      f9Medium.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f9MediumTextInverseTertiary =>
      f9Medium.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f9MediumPrimary500 =>
      f9Medium.copyWith(color: appColor.primary500);

  // f9Regular
  TextStyle get f9RegularAlwaysWhite =>
      f9Regular.copyWith(color: appColor.alwaysWhite);
  TextStyle get f9RegularAlwaysBlack =>
      f9Regular.copyWith(color: appColor.alwaysBlack);
  TextStyle get f9RegularAlwaysToast =>
      f9Regular.copyWith(color: appColor.alwaysToast);
  TextStyle get f9RegularAlwaysMask =>
      f9Regular.copyWith(color: appColor.alwaysMask);
  TextStyle get f9RegularTextPrimary =>
      f9Regular.copyWith(color: appColor.textPrimary);
  TextStyle get f9RegularTextSecondary =>
      f9Regular.copyWith(color: appColor.textSecondary);
  TextStyle get f9RegularTextTertiary =>
      f9Regular.copyWith(color: appColor.textTertiary);
  TextStyle get f9RegularTextDescription =>
      f9Regular.copyWith(color: appColor.textDescription);
  TextStyle get f9RegularTextTips =>
      f9Regular.copyWith(color: appColor.textTips);
  TextStyle get f9RegularTextDisable =>
      f9Regular.copyWith(color: appColor.textDisable);
  TextStyle get f9RegularTextInversePrimary =>
      f9Regular.copyWith(color: appColor.textInversePrimary);
  TextStyle get f9RegularTextInverseSecondary =>
      f9Regular.copyWith(color: appColor.textInverseSecondary);
  TextStyle get f9RegularTextInverseTertiary =>
      f9Regular.copyWith(color: appColor.textInverseTertiary);
  TextStyle get f9RegularPrimary500 =>
      f9Regular.copyWith(color: appColor.primary500);
}

TextStyle appTextStyle({
  required double fontSize,
  required FontWeight fontWeight,
  required double lineHeight,
  Color? color,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    height: lineHeight / fontSize,
    // letterSpacing: 1.5,
  );
}
