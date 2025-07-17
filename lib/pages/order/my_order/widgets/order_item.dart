import 'package:bobofood/common/model/order.dart';
import 'package:bobofood/common/widget/app_image.dart';
import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/button/app_action_icon.dart';
import 'package:bobofood/common/widget/button/app_button.dart';
import 'package:bobofood/constants/colors.dart';
import 'package:bobofood/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderItem extends StatelessWidget {
  const OrderItem(
      {super.key,
      required this.order,
      required this.onTap,
      required this.onMoreTap});

  final OrderModel order;

  final VoidCallback onTap;

  final VoidCallback onMoreTap;

  Widget _buildImage() {
    final image = order.products?.map((e) => e.image).toList();
    if (image == null || image.isEmpty) {
      return const SizedBox.shrink();
    }

    final secondImage = image.length > 1 ? image[1] : null;
    final lastLength = image.length > 2 ? image.length - 2 : 0;

    return SizedBox(
      width: 68.w,
      child: Column(
        spacing: 4.h,
        children: [
          AppImage(
            imageUrl: image.first!,
            width: 68.w,
            height: secondImage != null ? 68.h : 104.h,
            fit: BoxFit.fill,
            borderRadius: BorderRadius.circular(8.r),
          ),
          if (secondImage != null)
            Row(
              spacing: 4.w,
              children: [
                AppImage(
                  imageUrl: secondImage,
                  width: 32.w,
                  height: 32.h,
                  fit: BoxFit.fill,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                if (lastLength > 0)
                  Container(
                    width: 32.w,
                    height: 32.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.colors.background.layer2Background,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: AppText(
                      '+$lastLength',
                      style: AppTextStyle.poppinSmall600(
                          color: AppColors.colors.typography.paragraph),
                    ),
                  )
              ],
            )
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              order.deliveryStatus ?? "",
              style: AppTextStyle.poppinMedium700(
                  color: AppColors.colors.typography.heading),
            ),
            Column(
              children: [
                Row(
                  spacing: 16.w,
                  children: [
                    AppText(
                      'Est. delivery',
                      style: AppTextStyle.poppinSmall400(
                          color: AppColors.colors.typography.paragraph),
                    ),
                    AppText(
                      order.deliveryTime ?? "",
                      style: AppTextStyle.poppinSmall(
                          color: AppColors.colors.typography.paragraph),
                    ),
                  ],
                ),
                Row(
                  spacing: 16.w,
                  children: [
                    AppText(
                      'Order summary',
                      style: AppTextStyle.poppinSmall400(
                          color: AppColors.colors.typography.paragraph),
                    ),
                    Expanded(
                        child: AppText(
                      order.orderSummary ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: AppTextStyle.poppinSmall(
                          color: AppColors.colors.typography.paragraph),
                    )),
                  ],
                ),
                Row(
                  spacing: 16.w,
                  children: [
                    AppText(
                      'Total price paid',
                      style: AppTextStyle.poppinSmall400(
                          color: AppColors.colors.typography.paragraph),
                    ),
                    AppText(
                      '\$${order.totalPrice}',
                      style: AppTextStyle.robotoSmall(
                          color: AppColors.colors.typography.heading),
                    ),
                  ],
                ),
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16.h,
      children: [
        SizedBox(
            height: 104.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 16.w,
              children: [_buildImage(), Expanded(child: _buildOrderSummary())],
            )),
        Row(
          spacing: 8.w,
          children: [
            Expanded(
                child: AppButton(
              type: AppButtonType.outline,
              size: AppButtonSize.small,
              text: order.status == 'Current' ? 'Track order' : 'Reorder',
              onTap: onTap,
            )),
            AppActionIcon(type: AppActionIconType.normal, onTap: onMoreTap)
          ],
        )
      ],
    );
  }
}
