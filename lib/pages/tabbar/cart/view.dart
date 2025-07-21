import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/button/app_button.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:bobofood/constants/index.dart';
import 'package:bobofood/pages/tabbar/cart/widgets/cart_item.dart';
import 'package:bobofood/pages/tabbar/widget/empty.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, this.onOpenUser});

  final Function()? onOpenUser;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _CartViewGetX(onOpenUser: widget.onOpenUser);
  }
}

class _CartViewGetX extends GetView<CartController> {
  const _CartViewGetX({this.onOpenUser});

  final Function()? onOpenUser;

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 8.w, top: 4.h),
      decoration: BoxDecoration(
        color: AppColors.colors.background.elementBackground,
        border: Border(
          bottom: BorderSide(
            color: AppColors.colors.bordersAndSeparators.defaultColor,
            width: 1.w,
          ),
        ),
      ),
      child: Row(
        spacing: 38.w,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            '\$${controller.totalPrice}',
            style: AppTextStyle.robotoHeading(
                color: AppColors.colors.typography.heading),
          ),
          Expanded(
            child: AppButton(
              text: 'Proceed to pay',
              onTap: controller.onTapProceedToPay,
            ),
          )
        ],
      ),
    );
  }

  // 主视图
  Widget _buildView() {
    if (controller.cartItems.isEmpty) {
      return EmptyWidget(
        title: "Your cart is empty",
        description: "Explore and add items to the cart to show here...",
        buttonText: "Explore",
        onButtonTap: EmptyWidget.toHome,
      );
    }
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.w, 20.w, 0),
            child: ListView.builder(
              itemCount: controller.cartItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: index == 0 ? 0 : 16.w),
                  child: CartItem(
                    cartItem: controller.cartItems[index],
                    onTapAdd: () {
                      controller.updateCartItemCount(
                          controller.cartItems[index],
                          controller.cartItems[index].count + 1);
                    },
                    onTapRemove: () {
                      controller.updateCartItemCount(
                          controller.cartItems[index],
                          controller.cartItems[index].count - 1);
                    },
                    onTapDelete: () {
                      controller.removeFromCart(controller.cartItems[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ),
        _buildFooter()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: CartController(),
      id: "cart",
      builder: (_) {
        return Scaffold(
          appBar: AppNavBar.navigationTab(title: 'Cart'),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
