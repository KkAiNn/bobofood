import 'package:bobofood/common/widget/app_svg.dart';
import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/button/app_button.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/constants/colors.dart';
import 'package:bobofood/constants/text_style.dart';
import 'package:bobofood/router/app_router.dart';
import 'package:bobofood/services/notification_service.dart';
import 'package:bobofood/utils/date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderPlacedPage extends StatefulWidget {
  const OrderPlacedPage({super.key});

  @override
  State<OrderPlacedPage> createState() => _OrderPlacedPageState();
}

class _OrderPlacedPageState extends State<OrderPlacedPage> {
  List<Widget> _buildOrderList() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 8.w,
            children: [
              AppSvg(
                path: 'assets/icons/Clock.svg',
                width: 20.w,
                height: 20.h,
              ),
              AppText(
                'Estimated time',
                style: AppTextStyle.poppinMedium(
                    color: AppColors.colors.typography.lightGrey),
              )
            ],
          ),
          AppText(
            '30mins',
            style: AppTextStyle.poppinMedium(
                color: AppColors.colors.typography.heading),
          )
        ],
      ),
      SizedBox(height: 16.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 8.w,
            children: [
              AppSvg(
                path: 'assets/icons/Location.svg',
                width: 20.w,
                height: 20.h,
              ),
              AppText(
                'Deliver to',
                style: AppTextStyle.poppinMedium(
                    color: AppColors.colors.typography.lightGrey),
              )
            ],
          ),
          AppText(
            'Home',
            style: AppTextStyle.poppinMedium(
                color: AppColors.colors.typography.heading),
          )
        ],
      ),
      SizedBox(height: 16.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 8.w,
            children: [
              AppSvg(
                path: 'assets/icons/Credit Card.svg',
                width: 20.w,
                height: 20.h,
              ),
              AppText(
                'Amount Paid',
                style: AppTextStyle.poppinMedium(
                    color: AppColors.colors.typography.lightGrey),
              )
            ],
          ),
          AppText(
            '\$32.12',
            style: AppTextStyle.poppinMedium(
                color: AppColors.colors.typography.heading),
          )
        ],
      )
    ];
  }

  Widget _buildView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Column(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 72.w,
                height: 72.w,
                decoration: BoxDecoration(
                  color: AppColors.colors.icon.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: AppSvg(
                    path: 'assets/icons/Vector.svg',
                    width: 32.w,
                    height: 32.h,
                    color: AppColors.colors.typography.white,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              AppText(
                'Yay! Your order\nhas been placed.',
                textAlign: TextAlign.center,
                style: AppTextStyle.poppinsHeading1(
                  color: AppColors.colors.typography.heading,
                ),
              ),
              SizedBox(height: 12.h),
              AppText(
                'Your order would be delivered in the 30 mins atmost',
                textAlign: TextAlign.center,
                style: AppTextStyle.poppinMedium400(
                  color: AppColors.colors.typography.paragraph,
                ),
              ),
              SizedBox(height: 40.h),
              ..._buildOrderList()
            ],
          )),
          AppButton(
            width: double.infinity,
            text: 'Track my order',
            onTap: () {
              _showSimpleNotification();
              Get.offNamed(AppRoute.myOrder);
            },
          )
        ],
      ),
    );
  }

  Future<void> _showSimpleNotification() async {
    NotificationService notificationService = NotificationService();
    await notificationService.showSimpleNotification(
      id: JiffyDateUtils.formatToDateNumber(DateTime.now()),
      title: 'Order Placed',
      body: 'Your order would be delivered in the 30 mins atmost',
      payload: 'simple_notification',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppNavBar(
        leadingWidgets: [
          TapEffect(
            onTap: () {
              Get.back();
            },
            child: AppSvg(
              path: 'assets/icons/Close.svg',
              width: 32.w,
              height: 32.w,
            ),
          )
        ],
      ),
      body: SafeArea(top: true, bottom: true, child: _buildView()),
    );
  }
}
