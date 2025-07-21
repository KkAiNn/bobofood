import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/button/app_button.dart';
import 'package:bobofood/common/widget/form/app_checkbox.dart';
import 'package:bobofood/common/widget/form/app_input.dart';
import 'package:bobofood/common/widget/form/app_password_input.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:bobofood/common/widget/unfoucs_box.dart';
import 'package:bobofood/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

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
              children: [
                SizedBox(height: 12.h),
                AppText('Create a new \naccount',
                    style: AppTextStyle.poppinsHeading1(
                        color: AppColors.colors.typography.heading)),
                SizedBox(height: 20.h),
                Column(
                  spacing: 12.h,
                  children: [
                    AppInput(
                      hintText: 'email address',
                      controller: controller.emailController,
                      validator: controller.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: true,
                    ),
                    AppPasswordInput(
                      hintText: 'password',
                      controller: controller.passwordController,
                      validator: controller.validatePassword,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                AppCheckbox(
                  value: controller.isAgree,
                  isDisabled: false,
                  label: 'I agree to terms & conditions',
                  onChanged: controller.onTapAgree,
                )
              ],
            ),
            Column(
              children: [
                AppButton(
                  width: double.infinity,
                  isDisabled: controller.isDisabled,
                  text: 'Create account',
                  onTap: controller.onTapRegister,
                ),
                SizedBox(height: 12.h),
              ],
            )
          ],
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      init: RegisterController(),
      id: "register",
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
