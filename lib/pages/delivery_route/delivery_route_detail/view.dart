import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/form/app_input.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/constants/index.dart';
import 'package:bobofood/pages/delivery_route/delivery_route_detail/controller.dart';
import 'package:bobofood/common/widget/app_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'dart:ui' as ui;
import 'package:flutter_map/flutter_map.dart';

class DeliveryRouteDetailPage extends StatefulWidget {
  const DeliveryRouteDetailPage({super.key});

  @override
  State<DeliveryRouteDetailPage> createState() =>
      _DeliveryRouteDetailPageState();
}

class _DeliveryRouteDetailPageState extends State<DeliveryRouteDetailPage> {
  @override
  Widget build(BuildContext context) {
    return const _DeliveryRouteDetailViewGetX();
  }
}

class _DeliveryRouteDetailViewGetX
    extends GetView<DeliveryRouteDetailController> {
  const _DeliveryRouteDetailViewGetX();

  // 构建路径点列表
  Widget _buildWaypointsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                '路径点 (${controller.waypoints.length})',
                style: AppTextStyle.poppinMedium600(
                  color: AppColors.colors.typography.heading,
                ),
              ),
              TapEffect(
                onTap: () {
                  // 添加当前地图中心点作为新的路径点
                  controller
                      .addWaypoint(controller.mapController.camera.center);
                },
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: AppColors.colors.background.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add_location_alt,
                    color: AppColors.colors.typography.white,
                    size: 20.r,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 140.h,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            itemCount: controller.waypoints.length,
            itemBuilder: (context, index) {
              final waypoint = controller.waypoints[index];
              return Container(
                width: 120.w,
                margin: EdgeInsets.only(right: 12.w),
                decoration: BoxDecoration(
                  color: AppColors.colors.background.secondary,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      '点 ${index + 1}',
                      style: AppTextStyle.poppinMedium600(
                        color: AppColors.colors.typography.heading,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    AppText(
                      '${waypoint.latitude.toStringAsFixed(4)}, ${waypoint.longitude.toStringAsFixed(4)}',
                      style: AppTextStyle.poppinMedium400(
                        color: AppColors.colors.typography.paragraph,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TapEffect(
                          onTap: () {
                            controller.mapController.move(waypoint, 15);
                          },
                          child: Container(
                            padding: EdgeInsets.all(6.r),
                            decoration: BoxDecoration(
                              color: AppColors.colors.background.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.center_focus_strong,
                              color: AppColors.colors.typography.white,
                              size: 14.r,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        TapEffect(
                          onTap: () {
                            controller.removeWaypoint(index);
                          },
                          child: Container(
                            padding: EdgeInsets.all(6.r),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.delete,
                              color: AppColors.colors.typography.white,
                              size: 14.r,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // 构建路径信息表单
  Widget _buildRouteForm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            '路径信息',
            style: AppTextStyle.poppinMedium600(
              color: AppColors.colors.typography.heading,
            ),
          ),
          SizedBox(height: 12.h),
          AppInput(
            hintText: '路径名称',
            onChanged: (value) {
              controller.name = value;
            },
          ),
          SizedBox(height: 12.h),
          AppInput(
            hintText: '路径描述',
            maxLines: 3,
            onChanged: (value) {
              controller.description = value;
            },
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      '距离',
                      style: AppTextStyle.poppinMedium600(
                        color: AppColors.colors.typography.heading,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    AppText(
                      '${controller.distance.toStringAsFixed(2)} 公里',
                      style: AppTextStyle.poppinMedium400(
                        color: AppColors.colors.typography.paragraph,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      '预计时间',
                      style: AppTextStyle.poppinMedium600(
                        color: AppColors.colors.typography.heading,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    AppText(
                      '${controller.estimatedTime} 分钟',
                      style: AppTextStyle.poppinMedium400(
                        color: AppColors.colors.typography.paragraph,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              AppText(
                '路径状态',
                style: AppTextStyle.poppinMedium600(
                  color: AppColors.colors.typography.heading,
                ),
              ),
              SizedBox(width: 12.w),
              Switch(
                value: controller.isActive,
                onChanged: (value) {
                  controller.toggleActive();
                },
                activeColor: AppColors.colors.background.primary,
              ),
              SizedBox(width: 8.w),
              AppText(
                controller.isActive ? '活跃' : '停用',
                style: AppTextStyle.poppinMedium400(
                  color: controller.isActive ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 构建地图
  Widget _buildMap() {
    return SizedBox(
      height: 300.h,
      child: Stack(
        children: [
          AppMap(
            center: controller.waypoints.isNotEmpty
                ? controller.waypoints.first
                : LatLng(31.2304, 121.4737),
            mapController: controller.mapController,
            onPositionChanged: (position) {
              // 可以在这里处理地图位置变化
            },
            markers: controller.waypoints.isNotEmpty
                ? [
                    // 起点标记
                    Marker(
                      point: controller.waypoints.first,
                      width: 30,
                      height: 30,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Center(
                          child: Text(
                            '起',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // 如果有多个点，添加终点标记
                    if (controller.waypoints.length > 1)
                      Marker(
                        point: controller.waypoints.last,
                        width: 30,
                        height: 30,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Center(
                            child: Text(
                              '终',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ]
                : null,
            polylines: controller.waypoints.length > 1
                ? [
                    Polyline(
                      points: controller.waypoints,
                      strokeWidth: 4.0,
                      color: Colors.blue,
                    ),
                  ]
                : [],
          ),
          Positioned(
            right: 16.w,
            bottom: 16.h,
            child: TapEffect(
              onTap: () {
                controller.addWaypoint(controller.mapController.camera.center);
              },
              child: Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: AppColors.colors.background.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add_location,
                  color: AppColors.colors.typography.white,
                  size: 24.r,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 主视图
  Widget _buildView() {
    return Column(
      children: [
        // 固定在顶部的地图
        _buildMap(),
        // 可滚动的内容
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                _buildWaypointsList(),
                SizedBox(height: 16.h),
                _buildRouteForm(),
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                AppColors.colors.background.secondary,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                          child: AppText(
                            '取消',
                            style: AppTextStyle.poppinMedium600(
                              color: AppColors.colors.typography.heading,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            final route = controller.saveRoute();
                            Get.back(result: route);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                AppColors.colors.background.primary,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                          child: AppText(
                            '保存',
                            style: AppTextStyle.poppinMedium600(
                              color: AppColors.colors.typography.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveryRouteDetailController>(
      init: DeliveryRouteDetailController(),
      id: "delivery_route_detail",
      builder: (_) {
        return Scaffold(
          appBar: AppNavBar(
            titleText: controller.isNewRoute ? '创建配送路径' : '编辑配送路径',
          ),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
