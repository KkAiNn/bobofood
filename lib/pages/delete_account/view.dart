import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/button/app_button.dart';
import 'package:bobofood/common/widget/form/app_input.dart';
import 'package:bobofood/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class DeleteAccountPage extends GetView<DeleteAccountController> {
  const DeleteAccountPage({super.key});

  // 主视图
  Widget _buildView() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              AppText('You are going to delete your account.',
                  style: AppTextStyle.poppinsHeading1(
                      color: AppColors.colors.typography.heading)),
              SizedBox(height: 16.h),
              AppText(
                  'We are very sorry to see you leaving. Deleting your account will permanently delete all of the data plus any active subscriptions and this action can’t be undone!',
                  style: AppTextStyle.poppinMedium400(
                      color: AppColors.colors.typography.paragraph)),
              SizedBox(height: 12.h),
              AppText(
                  'If you still want to delete your account, enter “CONFIRM” to proceed.',
                  style: AppTextStyle.poppinMedium400(
                      color: AppColors.colors.typography.paragraph)),
              SizedBox(height: 20.h),
              AppInput(
                controller: controller.inputController,
                hintText: 'Enter "CONFIRM"',
                obscureText: true,
              )
            ],
          )),
          AppButton(
            width: double.infinity,
            text: 'Delete account',
            isDisabled: !controller.isConfirm,
            type: AppButtonType.danger,
            onTap: controller.deleteAccount,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeleteAccountController>(
      init: DeleteAccountController(),
      id: "delete_account",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("delete_account")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
