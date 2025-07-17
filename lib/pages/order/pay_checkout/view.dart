import 'package:bobofood/common/widget/app_divider.dart';
import 'package:bobofood/common/widget/app_option.dart';
import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/button/app_button.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:bobofood/constants/colors.dart';
import 'package:bobofood/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class PayCheckoutPage extends GetView<PayCheckoutController> {
  const PayCheckoutPage({super.key});
  List<Widget> _buildDeliveryInfo() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText('Subtotal',
              style: AppTextStyle.poppinMedium400(
                  color: AppColors.colors.typography.paragraph)),
          AppText('56.27',
              style: AppTextStyle.poppinMedium(
                  color: AppColors.colors.typography.paragraph)),
        ],
      ),
      SizedBox(
        height: 8.h,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText('Coupon',
              style: AppTextStyle.poppinMedium400(
                  color: AppColors.colors.typography.paragraph)),
          AppText('-17.4',
              style: AppTextStyle.poppinMedium(
                  color: AppColors.colors.typography.paragraph)),
        ],
      ),
      SizedBox(
        height: 8.h,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText('Delivery Charges',
              style: AppTextStyle.poppinMedium400(
                  color: AppColors.colors.typography.paragraph)),
          AppText('+3.99',
              style: AppTextStyle.poppinMedium(
                  color: AppColors.colors.typography.paragraph)),
        ],
      ),
      SizedBox(
        height: 8.h,
      ),
      AppDivider(),
      SizedBox(
        height: 8.h,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText('Total',
              style: AppTextStyle.poppinLarge400(
                  color: AppColors.colors.typography.heading)),
          AppText('32.12',
              style: AppTextStyle.robotoLarge(
                  color: AppColors.colors.typography.heading)),
        ],
      ),
    ];
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 8.w, top: 4.h),
      decoration: BoxDecoration(
        color: AppColors.colors.background.elementBackground,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            '\$${controller.cartController.totalPrice}',
            style: AppTextStyle.robotoHeading(
                color: AppColors.colors.typography.heading),
          ),
          Container(
            width: 224.w,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: AppButton(
              text: 'Continue',
              onTap: controller.onContinue,
            ),
          )
        ],
      ),
    );
  }

  // 主视图
  Widget _buildView() {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Column(
              children: [
                AppOption(
                  svgPath: 'assets/icons/Location.svg',
                  text: controller.address?.addressLabel ?? 'Add Address',
                  header: 'Deliver to',
                  onTap: controller.onTapChangeAddress,
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppOption(
                  svgPath: 'assets/icons/Credit Card.svg',
                  text: '${controller.card?.bank} - ${controller.card?.name}',
                  header: 'Payment from',
                  onTap: controller.onTapChangeCard,
                ),
                SizedBox(
                  height: 20.h,
                ),
                ..._buildDeliveryInfo(),
              ],
            ),
          ),
        ),
        _buildFooter(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PayCheckoutController>(
      init: PayCheckoutController(),
      id: "pay_checkout",
      builder: (_) {
        return Scaffold(
          appBar: AppNavBar(titleText: 'Checkout'),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
