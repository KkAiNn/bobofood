import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/button/app_button.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:bobofood/constants/index.dart';
import 'package:bobofood/pages/user/widgets/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class CreateProfilePage extends GetView<CreateProfileController> {
  const CreateProfilePage({super.key});

  // 主视图
  Widget _buildView() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText('Create your new \nprofile',
                  style: AppTextStyle.poppinsHeading1(
                    color: AppColors.colors.typography.heading,
                  )),
              SizedBox(height: 20.h),
              ProfileWidget(
                address: controller.address?.addressLabel ?? '',
                onAddressTap: controller.goToAddAddress,
                onAvatarTap: controller.onAvatarTap,
                avatarUrl: controller.avatarUrl,
                onChanged: controller.onProfileChanged,
              ),
            ],
          ),
          AppButton(
            text: 'Continue',
            isDisabled: controller.isDisabled,
            onTap: controller.onContinueTap,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateProfileController>(
      init: CreateProfileController(),
      id: "create_profile",
      builder: (_) {
        return Scaffold(
          appBar: AppNavBar.logo(),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
