import 'package:bobofood/common/widget/app_carousel_slider.dart';
import 'package:bobofood/common/widget/app_indicator.dart';
import 'package:bobofood/common/widget/app_link.dart';
import 'package:bobofood/common/widget/app_svg.dart';
import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/button/app_button.dart';
import 'package:bobofood/common/widget/button/app_counter_button.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:bobofood/constants/colors.dart';
import 'package:bobofood/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class ProductDetailPage extends GetView<ProductDetailController> {
  const ProductDetailPage({super.key});

  Widget _buildCarouselSlider() {
    return Container(
      padding: EdgeInsets.only(
        left: 20.w,
        top: 12.h,
      ),
      child: AppCarouselSlider<String>(
        items: controller.product.banner ?? [],
        itemBuilder: (context, url, index) {
          return Image.asset(
            url,
            height: 367.h,
            fit: BoxFit.cover,
          );
        },
        height: 367.h,
        viewportFraction: 0.95,
        itemSpacing: 8,
        enableInfiniteScroll: true,
        autoPlay: false,
        onPageChanged: controller.onPageChanged,
      ),
    );
  }

  Widget _buildProductInfo1() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.colors.background.elementBackground,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: AppColors.colors.bordersAndSeparators.defaultColor,
              width: 1.w,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppSvg(
                      path: 'assets/icons/Star filled.svg',
                      width: 16.w,
                      height: 16.h,
                      color: AppColors.colors.icon.yellow,
                    ),
                    SizedBox(width: 4.w),
                    AppText(
                      '${controller.product.star}',
                      style: AppTextStyle.poppinMedium(
                          color: AppColors.colors.typography.paragraph),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                width: 1.w,
                height: 16.h,
                color: AppColors.colors.bordersAndSeparators.defaultColor,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppSvg(
                      path: 'assets/icons/Fire filled.svg',
                      width: 16.w,
                      height: 16.h,
                      color: AppColors.colors.icon.orange,
                    ),
                    SizedBox(width: 4.w),
                    AppText(
                      '${controller.product.kcal}kcal',
                      style: AppTextStyle.poppinMedium(
                          color: AppColors.colors.typography.paragraph),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                width: 1.w,
                height: 16.h,
                color: AppColors.colors.bordersAndSeparators.defaultColor,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppSvg(
                      path: 'assets/icons/Clock filled.svg',
                      width: 16.w,
                      height: 16.h,
                      color: AppColors.colors.icon.blue,
                    ),
                    SizedBox(width: 4.w),
                    AppText(
                      '${controller.product.cookTime}mins',
                      style: AppTextStyle.poppinMedium(
                          color: AppColors.colors.typography.paragraph),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildProductInfo2() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Row(
              spacing: 12.w,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 180.w,
                  child: AppText(
                    controller.product.name ?? '',
                    style: AppTextStyle.poppinLarge(
                        color: AppColors.colors.typography.heading),
                  ),
                ),
                AppCounterButton(
                  count: controller.count,
                  onTapRemove: () {
                    controller.onTapRemove();
                  },
                  onTapAdd: () {
                    controller.onTapAdd();
                  },
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.only(top: 12.h, right: 40.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.h,
                  children: [
                    AppText(
                      controller.product.description ?? '',
                      maxLines: controller.readMore ? 999 : 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.poppinSmall400(
                          color: AppColors.colors.typography.paragraph),
                    ),
                    AppLink(
                        title: controller.readMore
                            ? 'Read less...'
                            : 'Read more...',
                        onTap: controller.onTapReadMore)
                  ],
                ))
          ],
        ));
  }

  Widget _buildFooter() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 38.w,
        children: [
          AppText(
            '\$${controller.totalPrice}',
            style: AppTextStyle.robotoHeading(
                color: AppColors.colors.typography.heading),
          ),
          Expanded(
            child: AppButton(
              text: 'Add to cart',
              onTap: controller.onTapAddToCart,
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
            child: SingleChildScrollView(
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCarouselSlider(),
            Padding(
              padding: EdgeInsets.only(
                  left: 20.w, top: 8.h, right: 20.w, bottom: 8.h),
              child: AppIndicator(
                  count: controller.product.banner?.length ?? 0,
                  currentIndex: controller.currentIndex),
            ),
            SizedBox(height: 8.h),
            _buildProductInfo1(),
            SizedBox(height: 20.h),
            _buildProductInfo2(),
          ],
        ))),
        _buildFooter()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailController>(
      init: ProductDetailController(),
      id: "product_detail",
      builder: (_) {
        return Scaffold(
          appBar: AppNavBar.productDetail(
            onLike: controller.onTapLike,
            onShare: controller.onTapShare,
            like: controller.isLike,
          ),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
