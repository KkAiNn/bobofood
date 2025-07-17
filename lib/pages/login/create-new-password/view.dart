import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/button/app_button.dart';
import 'package:bobofood/common/widget/form/app_password_input.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:bobofood/common/widget/unfoucs_box.dart';
import 'package:bobofood/constants/colors.dart';
import 'package:bobofood/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class CreateNewPasswordPage extends GetView<CreateNewPasswordController> {
  const CreateNewPasswordPage({super.key});

  // 主视图
  Widget _buildView() {
    return UnfoucsBox(
        child: Form(
      key: controller.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: _buildCreateNewPassword(),
            ),
            Column(
              children: [
                AppButton(
                  width: double.infinity,
                  isDisabled: controller.isDisabled,
                  text: 'Continue',
                  onTap: controller.onTapContinue,
                ),
                SizedBox(height: 12.h),
              ],
            )
          ],
        ),
      ),
    ));
  }

  List<Widget> _buildCreateNewPassword() {
    return [
      Container(
        alignment: Alignment.centerLeft,
        child: AppText('Create a new \npassword',
            style: AppTextStyle.poppinsHeading1(
                color: AppColors.colors.typography.heading)),
      ),
      SizedBox(height: 12.h),
      Container(
        alignment: Alignment.centerLeft,
        child: AppText('Enter a new password and try not to forget it.',
            style: AppTextStyle.poppinMedium400(
                color: AppColors.colors.typography.paragraph)),
      ),
      SizedBox(height: 20.h),
      AppPasswordInput(
        hintText: 'new password',
        controller: controller.passwordController,
        validator: controller.validatePassword,
        autofocus: true,
      ),
      SizedBox(height: 20.h),
      AppPasswordInput(
        hintText: 're-enter the new password',
        controller: controller.confirmPasswordController,
        validator: controller.validateConfirmPassword,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateNewPasswordController>(
      init: CreateNewPasswordController(),
      id: "create_new_password",
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
