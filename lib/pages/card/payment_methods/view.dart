import 'package:bobofood/common/widget/app_divider.dart';
import 'package:bobofood/common/widget/app_option.dart';
import 'package:bobofood/common/widget/app_option_group.dart';
import 'package:bobofood/common/widget/app_svg.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class PaymentMethodsPage extends GetView<PaymentMethodsController> {
  const PaymentMethodsPage({super.key});

  Widget _buildDefaultCard() {
    return AppOptionGroup(
      title: 'Default',
      options: [
        AppOption(
          text: controller.defaultCard != null
              ? '${controller.defaultCard?.bank} - ${controller.defaultCard?.name}'
              : 'Add Default Card',
          onTap: controller.onEditDefaultCard,
          isDisabled: controller.defaultCard == null,
        ),
      ],
    );
  }

  Widget _buildOtherCard() {
    return AppOptionGroup(
      title: 'Others',
      options: [
        Expanded(
            child: ListView.builder(
          itemCount: controller.otherCard.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: AppOption(
                text:
                    '${controller.otherCard[index].bank} - ${controller.otherCard[index].name}',
                onTap: () {
                  controller.onEditCard(controller.otherCard[index]);
                },
              ),
            );
          },
        )),
      ],
    );
  }

  // 主视图
  Widget _buildView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Column(
        spacing: 24.h,
        children: [
          _buildDefaultCard(),
          AppDivider(),
          Expanded(child: _buildOtherCard())
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentMethodsController>(
      init: PaymentMethodsController(),
      id: "payment_methods",
      builder: (_) {
        return Scaffold(
          appBar: AppNavBar(
            titleText: 'Payment Methods',
            trailingWidgets: [
              TapEffect(
                  onTap: controller.onAddCard,
                  child: AppSvg(
                    path: 'assets/icons/Add.svg',
                    width: 24.w,
                    height: 24.w,
                  )),
            ],
          ),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
