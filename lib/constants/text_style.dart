import 'package:bobofood/constants/font.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 100 - Thin
// 200 - Extra Light (Ultra Light)
// 300 - Light
// 400 - Regular (Normal、Book、Roman)
// 500 - Medium
// 600 - Semi Bold (Demi Bold)
// 700 - Bold
// 800 - Extra Bold (Ultra Bold)
// 900 - Black (Heavy)
class FontWeightEnum {
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.bold;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}

class AppTextStyle {
  static TextStyle poppins({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      fontFamily: AppFont.poppins,
      fontWeight: fontWeight,
      fontSize: fontSize ?? 15.sp,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle roboto({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      fontFamily: AppFont.roboto,
      fontWeight: fontWeight,
      fontSize: fontSize ?? 15.sp,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle robotoMono({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      fontFamily: AppFont.robotoMono,
      fontWeight: fontWeight,
      fontSize: fontSize ?? 15.sp,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle poppinsHeading1({Color? color}) {
    return poppins(
        fontSize: 32.sp,
        fontWeight: FontWeightEnum.bold,
        color: color,
        letterSpacing: -0.02,
        height: 1.2);
  }

  static TextStyle poppinsHeading2({Color? color}) {
    return poppins(
        fontSize: 24.sp,
        fontWeight: FontWeightEnum.bold,
        color: color,
        letterSpacing: -0.01,
        height: 1);
  }

  static TextStyle poppinLarge({Color? color}) {
    return poppins(
        fontSize: 17.sp,
        fontWeight: FontWeightEnum.bold,
        color: color,
        letterSpacing: -0.01,
        height: 1.3);
  }

  static TextStyle poppinMedium({Color? color}) {
    return poppins(
        fontSize: 15.sp,
        color: color,
        fontWeight: FontWeightEnum.regular,
        height: 1.3);
  }

  static TextStyle poppinSmall({Color? color}) {
    return poppins(
        fontSize: 12.sp,
        color: color,
        fontWeight: FontWeightEnum.medium,
        height: 1.3);
  }

  static TextStyle poppinLarge400({Color? color}) {
    return poppins(
        fontSize: 17.sp,
        color: color,
        fontWeight: FontWeightEnum.regular,
        letterSpacing: -0.01,
        height: 1.5);
  }

  static TextStyle poppinLarge600({Color? color}) {
    return poppins(
        fontSize: 17.sp,
        color: color,
        fontWeight: FontWeightEnum.semiBold,
        letterSpacing: -0.01,
        height: 1.5);
  }

  static TextStyle poppinLarge700({Color? color}) {
    return poppins(
        fontSize: 17.sp,
        color: color,
        fontWeight: FontWeightEnum.bold,
        letterSpacing: -0.01,
        height: 1.5);
  }

  static TextStyle poppinMedium400({Color? color}) {
    return poppins(
        fontSize: 15.sp,
        color: color,
        fontWeight: FontWeightEnum.regular,
        height: 1.7);
  }

  static TextStyle poppinMedium600({Color? color}) {
    return poppins(
        fontSize: 15.sp,
        color: color,
        fontWeight: FontWeightEnum.semiBold,
        height: 1.7);
  }

  static TextStyle poppinMedium700({Color? color}) {
    return poppins(
        fontSize: 15.sp,
        color: color,
        fontWeight: FontWeightEnum.bold,
        height: 1.7);
  }

  static TextStyle poppinSmall400({Color? color}) {
    return poppins(
        fontSize: 12.sp,
        color: color,
        fontWeight: FontWeightEnum.regular,
        height: 1.7);
  }

  static TextStyle poppinSmall600({Color? color}) {
    return poppins(
        fontSize: 12.sp,
        color: color,
        fontWeight: FontWeightEnum.semiBold,
        height: 1.7);
  }

  static TextStyle poppinSmall700({Color? color}) {
    return poppins(
        fontSize: 12.sp,
        color: color,
        fontWeight: FontWeightEnum.bold,
        height: 1.7);
  }

  static TextStyle robotoHeading({Color? color}) {
    return robotoMono(
      fontSize: 24.sp,
      color: color,
      fontWeight: FontWeightEnum.semiBold,
      letterSpacing: -0.02,
    );
  }

  static TextStyle robotoLarge({Color? color}) {
    return robotoMono(
        fontSize: 17.sp,
        color: color,
        fontWeight: FontWeightEnum.semiBold,
        letterSpacing: -0.01,
        height: 1.3);
  }

  static TextStyle robotoMedium({Color? color}) {
    return robotoMono(
        fontSize: 15.sp,
        color: color,
        fontWeight: FontWeightEnum.semiBold,
        height: 1.3);
  }

  static TextStyle robotoSmall({Color? color}) {
    return robotoMono(
        fontSize: 12.sp,
        color: color,
        fontWeight: FontWeightEnum.semiBold,
        height: 1.3);
  }

  static TextStyle robotoMonoMedium({Color? color}) {
    return robotoMono(
        fontSize: 15.sp,
        color: color,
        fontWeight: FontWeightEnum.regular,
        height: 1.7);
  }
}
