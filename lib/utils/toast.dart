import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/button/app_button.dart';
import 'package:bobofood/constants/colors.dart';
import 'package:bobofood/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AppToast {
  static show(
    String msg, {
    Toast? toastLength,
    int timeInSecForIosWeb = 1,
    double? fontSize,
    String? fontAsset,
    ToastGravity? gravity,
    Color? backgroundColor,
    Color? textColor,
    bool webShowClose = false,
    webBgColor = "linear-gradient(to right, #00b09b, #96c93d)",
    webPosition = "right",
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      timeInSecForIosWeb: timeInSecForIosWeb,
      fontSize: fontSize,
      fontAsset: fontAsset,
      gravity: gravity ?? ToastGravity.CENTER,
      backgroundColor: backgroundColor,
      textColor: textColor,
      webShowClose: webShowClose,
      webBgColor: webBgColor,
      webPosition: webPosition,
    );
  }

  static showLoading(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static showSnackbar(
    String msg, {
    String? title,
    Color? backgroundColor,
    Color? textColor,
    Duration? duration,
  }) {
    Get.closeCurrentSnackbar();
    Get.snackbar(
      title ?? "提示",
      msg,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(10),
      backgroundColor: backgroundColor ?? Colors.grey.withValues(alpha: 0.3),
      duration: duration ?? const Duration(milliseconds: 3000),
      colorText: textColor ?? Colors.black,
      borderRadius: 10,
    );
  }

  static cancel() {
    Fluttertoast.cancel();
  }

  static showDialog(
      {Widget? child,
      String? title,
      String? description,
      String? cancelText,
      String? confirmText,
      bool? showCancel,
      bool? showConfirm,
      AppButtonType? cancelType,
      AppButtonType? confirmType,
      VoidCallback? onCancel,
      VoidCallback? onConfirm}) {
    Get.dialog(
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              padding: EdgeInsets.all(20.r),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.colors.background.elementBackground,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(title ?? 'This is a label',
                      style: AppTextStyle.poppinsHeading2(
                          color: AppColors.colors.typography.heading)),
                  SizedBox(height: 12.h),
                  AppText(description ?? 'This is a description.',
                      style: AppTextStyle.poppinMedium400(
                          color: AppColors.colors.typography.heading)),
                  if (child != null) ...[
                    SizedBox(height: 16.h),
                    child,
                  ],
                  SizedBox(height: 20.h),
                  Row(
                    spacing: 8.w,
                    children: [
                      if (showCancel ?? true)
                        Expanded(
                          child: AppButton(
                            type: cancelType ?? AppButtonType.outline,
                            size: AppButtonSize.small,
                            text: cancelText ?? 'Cancel',
                            height: 44.h,
                            onTap: () {
                              if (onCancel != null) {
                                onCancel.call();
                              } else {
                                Get.back();
                              }
                            },
                          ),
                        ),
                      if (showConfirm ?? true)
                        Expanded(
                          child: AppButton(
                            type: confirmType ?? AppButtonType.primary,
                            size: AppButtonSize.small,
                            text: confirmText ?? 'Button',
                            height: 44.h,
                            onTap: () {
                              onConfirm?.call();
                            },
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
      barrierColor: Colors.black.withValues(alpha: 0.5),
      useSafeArea: true,
      transitionCurve: Curves.fastLinearToSlowEaseIn,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
