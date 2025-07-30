import 'package:bobofood/common/widget/app_avatar.dart';
import 'package:bobofood/common/widget/app_option.dart';
import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:bobofood/constants/index.dart';
import 'package:bobofood/pages/user/widgets/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class MyAccountPage extends GetView<MyAccountController> {
  const MyAccountPage({super.key});

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppAvatar(
            avatarUrl: controller.user?.avatarUrl ?? '', size: AvatarSize.xl),
        SizedBox(height: 12.h),
        AppText(controller.user?.name ?? '',
            style: AppTextStyle.poppinsHeading2(
                color: AppColors.colors.typography.heading)),
        SizedBox(height: 4.h),
        AppText(controller.user?.email ?? '',
            style: AppTextStyle.poppinSmall400(
                color: AppColors.colors.typography.lightGrey)),
        SizedBox(height: 4.h),
        AppText(controller.phone,
            style: AppTextStyle.robotoMedium(
                color: AppColors.colors.typography.lightGrey)),
      ],
    );
  }

  Widget _buildEditForm() {
    return ProfileWidget(
      avatarUrl: controller.user?.avatarUrl ?? '',
      name: controller.user?.name ?? '',
      phone: controller.user?.phone ?? '',
      birthDate: controller.user?.birthDate ?? '',
      phoneCode: controller.user?.phoneCode ?? '',
      address: controller.user?.address?.addressLabel ?? '',
      onAddressTap: controller.goToAddAddress,
      onAvatarSelected: controller.onAvatarSelected,
      onChanged: controller.onProfileChanged,
    );
  }

  Widget _buildMenu() {
    return Column(
      spacing: 12.h,
      children: [
        AppOption(
          text: 'Address',
          onTap: controller.onTapAddress,
        ),
        AppOption(
          text: 'Payment',
          onTap: controller.onTapPaymentMethods,
        ),
        AppOption(
          text: 'My Order',
          onTap: controller.onTapMyOrder,
        ),
        AppOption(
          text: '配送路径管理',
          onTap: controller.onTapDeliveryRoutes,
        ),
        AppOption(
          text: 'Settings',
          onTap: controller.onTapSettings,
        ),
      ],
    );
  }

  // 主视图
  Widget _buildView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: controller.isEditing
          ? _buildEditForm()
          : Column(
              spacing: 24.h,
              children: [
                Center(
                  child: _buildHeader(),
                ),
                _buildMenu(),
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAccountController>(
      init: MyAccountController(),
      id: "my_account",
      builder: (_) {
        return Scaffold(
          appBar: controller.isEditing
              ? AppNavBar.editingSaveAndCancel(
                  title: "My Account",
                  onSave: controller.onSaveTap,
                  onCancel: controller.onCancelTap,
                )
              : AppNavBar.withEditOption(
                  title: "My Account",
                  onEdit: controller.onEditTap,
                ),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
