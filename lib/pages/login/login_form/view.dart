import 'package:bobofood/common/widget/button/app_button.dart';
import 'package:bobofood/common/widget/form/app_input.dart';
import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/form/app_password_input.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/common/widget/unfoucs_box.dart';
import 'package:bobofood/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class LoginFormPage extends GetView<LoginFormController> {
  const LoginFormPage({super.key});

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
                AppText('Log in to you\naccount',
                    style: AppTextStyle.poppinsHeading1(
                        color: AppColors.colors.typography.heading)),
                SizedBox(height: 20.h),
                Column(
                  spacing: 12.h,
                  children: [
                    AppInput(
                      formFieldKey: controller.emailFieldKey,
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
                Container(
                  alignment: Alignment.center,
                  child: TapEffect(
                      onTap: controller.onTapForgotPassword,
                      child: AppText('forgot password',
                          style: AppTextStyle.poppinMedium700(
                            color: AppColors.colors.typography.primary700,
                          ))),
                )
              ],
            ),
            Column(
              children: [
                AppButton(
                  width: double.infinity,
                  isDisabled: controller.isDisabled,
                  text: 'Log in',
                  onTap: controller.onTapLogin,
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 4.w,
                  children: [
                    AppText('Don\'t have an account?',
                        style: AppTextStyle.poppinMedium400(
                            color: AppColors.colors.typography.paragraph)),
                    GestureDetector(
                      onTap: () => controller.onTapSignUp(),
                      child: AppText('Sign up',
                          isUnderline: true,
                          style: AppTextStyle.poppinMedium600(
                            color: AppColors.colors.typography.heading,
                          )),
                    ),
                  ],
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
    return GetBuilder<LoginFormController>(
      init: LoginFormController(),
      id: "login_form",
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
