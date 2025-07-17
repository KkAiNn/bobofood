import 'package:bobofood/common/widget/button/app_button.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:bobofood/common/widget/unfoucs_box.dart';
import 'package:bobofood/pages/login/widgets/verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class VerifyCodePage extends GetView<VerifyCodeController> {
  const VerifyCodePage({super.key});

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
            VerificationWidget(
              title: controller.title,
              description: controller.description,
              verificationCodeLength: controller.verificationCodeLength,
              onChanged: controller.onVerificationCodeonChanged,
              countdownController: controller.countdownController,
              onTapResend: controller.onTapResend,
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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifyCodeController>(
      init: VerifyCodeController(),
      id: "verify_code",
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
