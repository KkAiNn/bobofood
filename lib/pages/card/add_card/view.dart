import 'package:bobofood/common/widget/app_divider.dart';
import 'package:bobofood/common/widget/app_option.dart';
import 'package:bobofood/common/widget/app_svg.dart';
import 'package:bobofood/common/widget/button/app_button.dart';
import 'package:bobofood/common/widget/form/app_input.dart';
import 'package:bobofood/common/widget/form/app_select.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/common/widget/unfoucs_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class AddCardPage extends GetView<AddCardController> {
  const AddCardPage({super.key});

  Widget _buildForm() {
    return Form(
        key: controller.formKey,
        child: Column(
          spacing: 12.h,
          children: [
            AppInput(
              hintText: 'Cardholder name',
              controller: controller.nameController,
              required: true,
            ),
            AppInput(
              hintText: 'Card number',
              controller: controller.numberController,
              required: true,
            ),
            AppSelectInput(
                hintText: 'Expiry date',
                controller: controller.dateController,
                showArrowRight: false,
                required: true,
                onTap: controller.onDatePicker),
            AppInput(
              hintText: 'CVV',
              controller: controller.cvvController,
              required: true,
            ),
          ],
        ));
  }

  // 主视图
  Widget _buildView() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              spacing: 24.h,
              children: [
                AppOption.toggle(
                  text: 'Set as default',
                  value: controller.card?.isDefault ?? false,
                  onChanged: controller.onSetDefault,
                ),
                AppDivider(),
                _buildForm(),
              ],
            ),
            AppButton(
              width: double.infinity,
              text: 'Save',
              onTap: controller.onSave,
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddCardController>(
      init: AddCardController(),
      id: "add_card",
      builder: (_) {
        return UnfoucsBox(
            child: Scaffold(
          appBar: AppNavBar(
            titleText: controller.card?.id == null ? 'Add a card' : 'Edit Card',
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
            child: _buildView(),
          ),
        ));
      },
    );
  }
}
