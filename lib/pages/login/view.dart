import 'package:bobofood/common/widget/app_svg.dart';
import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/button/app_button.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:bobofood/constants/index.dart';
import 'package:bobofood/services/storage_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  // 主视图
  Widget _buildView(BuildContext context) {
    final isDarkMode =
        AppStorage.conifg.get(ConifgBoxKey.themeMode, defaultValue: false);
    var backgroundImage =
        'assets/Illustrations/background ${isDarkMode ? 'dark' : 'light'}.png';
    var obj = {
      'image':
          'assets/Illustrations/Burger - ${isDarkMode ? 'dark' : 'light'} mode.png',
      'title': 'Join to get the delicious quizines!',
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: 12.h),
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Image.asset(backgroundImage,
                        width: 374.w, height: 374.h),
                  ),
                  Image.asset(obj['image']!, width: 285.w, height: 285.h),
                ],
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                ),
                child: Column(
                  children: [
                    AppText(obj['title']!,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.poppinsHeading1(
                            color: AppColors.colors.typography.heading)),
                  ],
                ),
              ),
            ],
          ),
        )),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                AppButton(
                  width: double.infinity,
                  text: 'Continue with Apple',
                  prefixIcon: AppSvg(
                      path: 'assets/icons/Apple.svg',
                      width: 24.w,
                      height: 24.h,
                      color: AppColors.colors.icon.white),
                  onTap: controller.onTapApple,
                ),
                SizedBox(height: 8.h),
                AppText(
                  'or',
                  style: AppTextStyle.poppinMedium600(
                      color: AppColors.colors.typography.lightGrey),
                ),
                SizedBox(height: 8.h),
                Row(
                  spacing: 8.w,
                  children: [
                    Expanded(
                      child: AppButton(
                        type: AppButtonType.secondary,
                        icon: Image.asset('assets/icons/Google.png',
                            width: 24.w, height: 24.h),
                        onTap: controller.onTapGoogle,
                      ),
                    ),
                    Expanded(
                      child: AppButton(
                        type: AppButtonType.secondary,
                        icon: Image.asset(
                          'assets/icons/Facebook.png',
                          width: 24.w,
                          height: 24.h,
                        ),
                        onTap: controller.onTapFacebook,
                      ),
                    ),
                    Expanded(
                      child: AppButton(
                        type: AppButtonType.secondary,
                        icon: AppSvg(
                          path: 'assets/icons/Email filled.svg',
                          width: 24.w,
                          height: 24.h,
                          color: AppColors.colors.icon.defaultColor,
                        ),
                        onTap: controller.onTapEmail,
                      ),
                    )
                  ],
                )
              ],
            )),
        SizedBox(height: 12.h),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      id: "login",
      builder: (_) {
        return Scaffold(
          appBar: AppNavBar.logo(),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
