import 'package:bobofood/common/widget/app_divider.dart';
import 'package:bobofood/common/widget/app_option.dart';
import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/button/app_button.dart';
import 'package:bobofood/common/widget/form/app_input.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:bobofood/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class AddCouponPage extends GetView<AddCouponController> {
  const AddCouponPage({super.key});

  Widget _buildAdd() {
    return Row(
      spacing: 8.w,
      children: [
        Expanded(
            child: AppInput(
          hintText: 'type coupon name',
          controller: controller.couponNameController,
        )),
        AppButton(
          width: 64.w,
          isDisabled: controller.isDisabled,
          text: 'Add',
          onTap: () {},
        )
      ],
    );
  }

  // 主视图
  Widget _buildView() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        spacing: 24.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAdd(),
          AppDivider(),
          AppText(
            'Select from these',
            style: AppTextStyle.poppinSmall600(
                color: AppColors.colors.typography.lightGrey),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.coupons.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: AppOption.radio(
                    text: controller.coupons[index].description,
                    header: controller.coupons[index].name,
                    value: controller.selectedCoupon?.id ==
                        controller.coupons[index].id,
                    onChanged: (value) {
                      controller.onTapCoupon(controller.coupons[index]);
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddCouponController>(
      init: AddCouponController(),
      id: "add_coupon",
      builder: (_) {
        return Scaffold(
          appBar: AppNavBar.editingSaveAndCancel(
              title: "Add Coupon", onSave: controller.onTapSave),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
