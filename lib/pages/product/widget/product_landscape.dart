import 'package:bobofood/common/widget/app_svg.dart';
import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/button/app_action_icon.dart';
import 'package:bobofood/constants/index.dart';
import 'package:bobofood/common/model/product.dart';
import 'package:flutter/material.dart';

class ProductLandscape extends StatelessWidget {
  const ProductLandscape(
      {super.key,
      required this.product,
      this.onTap,
      this.showStar = true,
      this.showAddToCart = true});

  final ProductModel product;
  final Function()? onTap;
  final bool? showStar;
  final bool? showAddToCart;

  Widget _buildProductImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.w),
            bottomLeft: Radius.circular(16.w),
            topRight: Radius.circular(8.w),
            bottomRight: Radius.circular(8.w),
          ),
          child: Image.asset(
            product.image ?? '',
            width: 120.w,
            height: 108.h,
            fit: BoxFit.fill,
          ),
        ),
        if (showStar == true)
          Positioned(
            top: 4.w,
            left: 4.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
              decoration: BoxDecoration(
                color: AppColors.colors.background.transparentNav,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 4.w,
                children: [
                  AppSvg(
                    path: 'assets/icons/Star filled.svg',
                    width: 16.w,
                    height: 16.w,
                    color: AppColors.colors.icon.yellow,
                  ),
                  AppText(
                    '4.5',
                    style: AppTextStyle.poppinSmall(
                      color: AppColors.colors.typography.paragraph,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.r),
      decoration: BoxDecoration(
        color: AppColors.colors.background.elementBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.colors.bordersAndSeparators.defaultColor,
          width: 1.w,
        ),
      ),
      child: Row(
        spacing: 8.w,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductImage(),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              AppText(
                product.name ?? '',
                style: AppTextStyle.poppinMedium(
                  color: AppColors.colors.typography.paragraph,
                ),
              ),
              SizedBox(height: 14.h),
              AppText(
                '\$${product.price}',
                style: AppTextStyle.robotoMedium(
                  color: AppColors.colors.typography.heading,
                ),
              ),
              SizedBox(height: 6.h),
              if (showAddToCart == true)
                Container(
                  padding: EdgeInsets.only(right: 4.w),
                  alignment: Alignment.centerRight,
                  child: AppActionIcon(
                    type: AppActionIconType.light,
                    size: 32.w,
                    rounded: true,
                    onTap: onTap ?? () {},
                  ),
                )
            ],
          ))
        ],
      ),
    );
  }
}
