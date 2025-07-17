import 'package:bobofood/common/widget/app_avatar.dart';
import 'package:bobofood/common/widget/app_image.dart';
import 'package:bobofood/common/widget/app_option.dart';
import 'package:bobofood/common/widget/app_option_group.dart';
import 'package:bobofood/common/widget/app_svg.dart';
import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/constants/colors.dart';
import 'package:bobofood/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class UserPage extends GetView<UserController> {
  const UserPage({super.key, this.onThemeChange});
  final Function()? onThemeChange;

  Widget _buildHeader() {
    return Row(
      spacing: 16.w,
      children: [
        Obx(
          () => AppAvatar(
            size: AvatarSize.lg,
            avatarUrl: controller.authController.avatarUrl,
          ),
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => AppText(
                    controller.authController.name,
                    style: AppTextStyle.poppinLarge(
                        color: AppColors.colors.typography.heading),
                  )),
              SizedBox(height: 4.h),
              AppText(
                controller.authController.email,
                style: AppTextStyle.poppinSmall(
                    color: AppColors.colors.typography.lightGrey),
              ),
              SizedBox(height: 8.h),
              Container(
                width: 98.w,
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.colors.background.elementBackground,
                  border: Border.all(
                      color: AppColors.colors.bordersAndSeparators.defaultColor,
                      width: 1.w),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  children: [
                    AppSvg(
                      path: 'assets/icons/Star filled.svg',
                      width: 16.w,
                      height: 16.h,
                      color: AppColors.colors.icon.yellow,
                    ),
                    SizedBox(width: 4.w),
                    AppText(
                      'Premium',
                      style: AppTextStyle.poppinSmall(
                          color: AppColors.colors.typography.lightGrey),
                    )
                  ],
                ),
              )
            ],
          ),
        ))
      ],
    );
  }

  Widget _buildGeneral() {
    return AppOptionGroup(title: 'General', options: [
      AppOption(
        svgPath: 'assets/icons/Profile.svg',
        text: 'My Account',
        onTap: controller.onTapMyAccount,
      ),
      AppOption(
        svgPath: 'assets/icons/Orders.svg',
        text: 'My Order',
        onTap: controller.onTapMyOrder,
      ),
      AppOption(
        svgPath: 'assets/icons/Credit Card.svg',
        text: 'Payment',
        onTap: controller.onTapPaymentMethods,
      ),
      AppOption(
        svgPath: 'assets/icons/Location.svg',
        text: 'Address',
        onTap: controller.onTapAddress,
      ),
      AppOption(
        svgPath: 'assets/icons/Subscription.svg',
        text: 'Subscription',
        onTap: () {},
      ),
      AppOption(
        svgPath: 'assets/icons/Settings.svg',
        text: 'Settings',
        onTap: controller.onTapSettings,
      ),
    ]);
  }

  Widget _buildTheme() {
    return AppOptionGroup(
      title: 'Theme',
      options: [
        AppOption.toggle(
            svgPath: 'assets/icons/Dark mode.svg',
            text: 'Dark mode',
            value: controller.isDarkMode,
            onChanged: (value) {
              controller.onToggleDarkMode(value);
              onThemeChange?.call();
            }),
      ],
    );
  }

  // 主视图
  Widget _buildView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 24.h),
            _buildGeneral(),
            SizedBox(height: 24.h),
            _buildTheme()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      init: UserController(),
      id: "user",
      builder: (_) {
        return Scaffold(
          appBar: AppNavBar(
            sideMaxWidth: 130.w,
            leadingWidgets: [
              TapEffect(
                onTap: () {
                  Get.back();
                },
                child: AppSvg(
                  path: 'assets/icons/Close.svg',
                  width: 32.w,
                  height: 32.h,
                ),
              ),
              AppImage(
                imageUrl: controller.logo,
                width: 90.w,
                height: 24.h,
              )
            ],
          ),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
