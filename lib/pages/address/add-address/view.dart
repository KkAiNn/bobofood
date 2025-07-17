import 'package:bobofood/common/widget/app_divider.dart';
import 'package:bobofood/common/widget/app_option.dart';
import 'package:bobofood/common/widget/app_svg.dart';
import 'package:bobofood/common/widget/button/app_button.dart';
import 'package:bobofood/common/widget/form/app_input.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/common/widget/unfoucs_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class AddAddressPage extends GetView<AddAddressController> {
  const AddAddressPage({super.key});

  // 主视图
  Widget _buildView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // ⬅️ 让子项尽量拉伸
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, // ⬅️ 让子项尽量拉伸
              children: [
                AppOption.toggle(
                  text: 'Set as default',
                  value: controller.address?.isDefault ?? false,
                  onChanged: controller.onSwitchChange,
                ),
                SizedBox(
                  height: 32.h,
                ),
                AppDivider(),
                SizedBox(
                  height: 32.h,
                ),
                AppInput(
                  hintText: 'address label (e.g. home, work, other)',
                  controller: controller.addressLabelController,
                  autofocus: true,
                ),
                SizedBox(
                  height: 12.h,
                ),
                AppInput(
                  hintText:
                      'delivery instructions (optional for specific directions or requests)',
                  minLines: 2,
                  controller: controller.deliveryInstructionsController,
                ),
                SizedBox(
                  height: 32.h,
                ),
                AppDivider(),
                SizedBox(
                  height: 32.h,
                ),
                AppInput(
                  hintText: 'full name',
                  controller: controller.nameController,
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    SizedBox(
                        width: 68.w,
                        child: AppInput(
                          textAlign: TextAlign.right,
                          hintText: '+00',
                          controller: controller.phoneCodeController,
                        )),
                    SizedBox(width: 12.w),
                    Expanded(
                        child: AppInput(
                      hintText: 'phone number',
                      controller: controller.phoneController,
                    )),
                  ],
                ),
                SizedBox(height: 12.h),
                AppInput(
                  hintText: 'street',
                  controller: controller.streetController,
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                        child: AppInput(
                      hintText: 'city',
                      controller: controller.cityController,
                    )),
                    SizedBox(width: 12.w),
                    Expanded(
                        child: AppInput(
                      hintText: 'state / province / region',
                      controller: controller.stateController,
                    )),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                        child: AppInput(
                      hintText: 'ZIP / postal code',
                      controller: controller.zipCodeController,
                    )),
                    SizedBox(width: 12.w),
                    Expanded(
                        child: AppInput(
                      hintText: 'country',
                      controller: controller.countryController,
                    ))
                  ],
                )
              ],
            ),
          )),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: AppButton(
              text: 'Continue',
              isDisabled: controller.isDisabled,
              onTap: controller.addAddress,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddAddressController>(
      init: AddAddressController(),
      id: "add_address",
      builder: (_) {
        return Scaffold(
          appBar: AppNavBar(
            titleText: controller.address?.id == null
                ? 'Add an address'
                : 'Edit Address',
            trailingWidgets: [
              TapEffect(
                  child: AppSvg(
                path: 'assets/icons/More.svg',
                width: 24.w,
                height: 24.h,
              ))
            ],
          ),
          body: SafeArea(
            child: UnfoucsBox(child: _buildView()),
          ),
        );
      },
    );
  }
}
