import 'package:bobofood/common/model/cart.dart';
import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/button/app_counter_button.dart';
import 'package:bobofood/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CartItem extends StatelessWidget {
  final CartModel cartItem;
  final Function()? onTapAdd;
  final Function()? onTapRemove;
  final Function()? onTapDelete;

  const CartItem(
      {super.key,
      required this.cartItem,
      this.onTapAdd,
      this.onTapRemove,
      this.onTapDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      height: 90.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.w),
        color: AppColors.colors.background.elementBackground,
        border: Border.all(
          color: AppColors.colors.bordersAndSeparators.defaultColor,
          width: 1.w,
        ),
      ),
      child: Row(
        spacing: 8.w,
        children: [
          SizedBox(
            width: 100.w,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.w),
                bottomLeft: Radius.circular(16.w),
                topRight: Radius.circular(8.w),
                bottomRight: Radius.circular(8.w),
              ),
              child: Image.asset(
                cartItem.product?.image ?? '',
                width: 100.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.fromLTRB(0, 8.w, 8.w, 0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  cartItem.product?.name ?? '',
                  style: AppTextStyle.poppinMedium(
                    color: AppColors.colors.typography.paragraph,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      '\$${cartItem.product?.price}',
                      style: AppTextStyle.robotoMedium(
                        color: AppColors.colors.typography.heading,
                      ),
                    ),
                    AppCounterButton(
                      count: cartItem.count,
                      type: cartItem.count == 1
                          ? CounterButtonType.remove
                          : CounterButtonType.small,
                      onTapAdd: () {
                        onTapAdd?.call();
                      },
                      onTapRemove: () {
                        onTapRemove?.call();
                      },
                      onTapDelete: () {
                        onTapDelete?.call();
                      },
                    )
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
