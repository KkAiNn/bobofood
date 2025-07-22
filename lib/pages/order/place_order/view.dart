import 'package:bobofood/common/widget/app_divider.dart';
import 'package:bobofood/common/widget/app_option.dart';
import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/button/app_button.dart' show AppButton;
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/constants/index.dart';
import 'package:bobofood/pages/tabbar/cart/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class PlaceOrderPage extends GetView<PlaceOrderController> {
  const PlaceOrderPage({super.key});

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

  Widget _buildCoupon() {
    return AppOption(
      svgPath: 'assets/icons/Offer.svg',
      text:
          controller.coupon != null ? controller.coupon!.name : 'Add a coupon',
      header: controller.coupon != null ? 'COUPON' : null,
      inActive: controller.coupon == null,
      onTap: controller.onCouponTap,
    );
  }

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

  // 主视图
  Widget _buildView() {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...controller.cartItems.map(
                    (e) => Padding(
                      padding: EdgeInsets.only(top: 16.w),
                      child: CartItem(
                        cartItem: e,
                        onTapAdd: () {
                          controller.updateCartItemCount(e, e.count + 1);
                        },
                        onTapRemove: () {
                          controller.updateCartItemCount(e, e.count - 1);
                        },
                        onTapDelete: () {
                          controller.removeFromCart(e);
                        },
                      ),
                    ),
                  ),
                  if (controller.cartItems.length <
                      controller.cartController.cartItems.length)
                    TapEffect(
                        onTap: controller.onTapExpand,
                        child: Padding(
                          padding: EdgeInsets.only(top: 12.w),
                          child: AppText('+1 more',
                              style: AppTextStyle.poppinMedium700(
                                  color: AppColors.colors.typography.primary)),
                        )),
                  SizedBox(
                    height: 20.h,
                  ),
                  _buildCoupon(),
                  SizedBox(
                    height: 20.h,
                  ),
                  ..._buildDeliveryInfo(),
                  SizedBox(
                    height: 12.h,
                  ),
                ],
              ),
            ),
          ),
        ),
        _buildFooter()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlaceOrderController>(
      init: PlaceOrderController(),
      id: "place_order",
      builder: (_) {
        return Scaffold(
            appBar: AppNavBar(
              titleText: 'Place order',
            ),
            body: SafeArea(
              child: _buildView(),
            ));
      },
    );
  }
}
