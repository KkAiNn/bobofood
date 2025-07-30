import 'package:bobofood/common/model/delivery_route.dart';
import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/button/app_button.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/constants/index.dart';
import 'package:bobofood/pages/delivery_route/delivery_routes/controller.dart';
import 'package:bobofood/pages/tabbar/widget/empty.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryRoutesPage extends StatefulWidget {
  const DeliveryRoutesPage({super.key});

  @override
  State<DeliveryRoutesPage> createState() => _DeliveryRoutesPageState();
}

class _DeliveryRoutesPageState extends State<DeliveryRoutesPage> {
  @override
  Widget build(BuildContext context) {
    return const _DeliveryRoutesViewGetX();
  }
}

class _DeliveryRoutesViewGetX extends GetView<DeliveryRoutesController> {
  const _DeliveryRoutesViewGetX();

  // 配送路径项
  Widget _buildRouteItem(DeliveryRouteModel route) {
    return TapEffect(
      onTap: () => controller.viewDeliveryRouteDetail(route),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: AppColors.colors.background.secondary,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: AppText(
                    route.name,
                    style: AppTextStyle.poppinMedium600(
                      color: AppColors.colors.typography.heading,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: route.isActive
                        ? AppColors.colors.background.primary
                        : AppColors.colors.background.secondary,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: AppText(
                    route.isActive ? '活跃' : '停用',
                    style: AppTextStyle.poppinMedium400(
                      color: AppColors.colors.typography.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            AppText(
              route.description,
              style: AppTextStyle.poppinMedium400(
                color: AppColors.colors.typography.paragraph,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16.r,
                  color: AppColors.colors.typography.paragraph,
                ),
                SizedBox(width: 4.w),
                AppText(
                  '${route.estimatedTime} 分钟',
                  style: AppTextStyle.poppinMedium400(
                    color: AppColors.colors.typography.paragraph,
                  ),
                ),
                SizedBox(width: 16.w),
                Icon(
                  Icons.route,
                  size: 16.r,
                  color: AppColors.colors.typography.paragraph,
                ),
                SizedBox(width: 4.w),
                AppText(
                  '${route.distance} 公里',
                  style: AppTextStyle.poppinMedium400(
                    color: AppColors.colors.typography.paragraph,
                  ),
                ),
                Spacer(),
                TapEffect(
                  onTap: () => controller.editDeliveryRoute(route),
                  child: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: AppColors.colors.background.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.edit,
                      size: 16.r,
                      color: AppColors.colors.typography.paragraph,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                TapEffect(
                  onTap: () => controller.deleteDeliveryRoute(route),
                  child: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: AppColors.colors.background.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.delete,
                      size: 16.r,
                      color: AppColors.colors.background.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 主视图
  Widget _buildView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Column(
        children: [
          AppButton(
            text: '添加新配送路径',
            onTap: controller.createNewDeliveryRoute,
            width: double.infinity,
            icon: Icon(Icons.add),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: controller.deliveryRoutes.isEmpty
                ? EmptyWidget(
                    title: '没有配送路径',
                    description: '点击上方按钮添加新的配送路径',
                    buttonText: '添加配送路径',
                    onButtonTap: controller.createNewDeliveryRoute,
                  )
                : ListView.separated(
                    itemCount: controller.deliveryRoutes.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.h),
                    itemBuilder: (context, index) {
                      final route = controller.deliveryRoutes[index];
                      return _buildRouteItem(route);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveryRoutesController>(
      init: DeliveryRoutesController(),
      id: "delivery_routes",
      builder: (_) {
        return Scaffold(
          appBar: AppNavBar(
            titleText: '配送路径管理',
          ),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
