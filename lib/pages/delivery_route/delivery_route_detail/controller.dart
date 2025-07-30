import 'dart:math' as math;

import 'package:bobofood/common/model/delivery_route.dart';
import 'package:bobofood/utils/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';

class DeliveryRouteDetailController extends GetxController {
  DeliveryRouteDetailController();

  late MapController mapController = MapController();
  late DeliveryRouteModel? route;
  bool isEditing = false;
  bool isNewRoute = false;

  // 表单数据
  late String name = '';
  late String description = '';
  late List<LatLng> waypoints = [];
  late double distance = 0.0;
  late int estimatedTime = 0;
  late bool isActive = true;

  _initData() {
    update(["delivery_route_detail"]);
  }

  // 初始化数据
  void _initFormData() {
    if (route != null) {
      name = route!.name;
      description = route!.description;
      waypoints = List.from(route!.waypoints);
      distance = route!.distance;
      estimatedTime = route!.estimatedTime;
      isActive = route!.isActive;
    } else {
      // 新建路径，使用当前位置作为起点
      final position = LocationUtils.instance.currentLocation;
      if (position != null &&
          position.latitude != null &&
          position.longitude != null) {
        waypoints = [LatLng(position.latitude!, position.longitude!)];
      } else {
        // 默认位置（上海）
        waypoints = [LatLng(31.2304, 121.4737)];
      }
      name = '新配送路径';
      description = '请添加描述';
      distance = 0.0;
      estimatedTime = 0;
      isActive = true;
      isNewRoute = true;
    }
  }

  // 添加路径点
  void addWaypoint(LatLng point) {
    waypoints.add(point);
    _calculateRouteInfo();
    _initData();
  }

  // 移除路径点
  void removeWaypoint(int index) {
    if (waypoints.length > 1) {
      waypoints.removeAt(index);
      _calculateRouteInfo();
      _initData();
    }
  }

  // 计算路径信息（距离和时间）
  void _calculateRouteInfo() {
    if (waypoints.length < 2) {
      distance = 0.0;
      estimatedTime = 0;
      return;
    }

    // 计算总距离
    double totalDistance = 0.0;
    for (int i = 0; i < waypoints.length - 1; i++) {
      totalDistance += _calculateDistance(waypoints[i], waypoints[i + 1]);
    }

    distance = totalDistance;
    // 假设平均速度为30公里/小时，计算估计时间（分钟）
    estimatedTime = (distance / 30 * 60).round();
  }

  // 计算两点之间的距离（公里）
  double _calculateDistance(LatLng point1, LatLng point2) {
    const double earthRadius = 6371; // 地球半径，单位为公里

    // 将经纬度转换为弧度
    final double lat1 = point1.latitude * (math.pi / 180);
    final double lon1 = point1.longitude * (math.pi / 180);
    final double lat2 = point2.latitude * (math.pi / 180);
    final double lon2 = point2.longitude * (math.pi / 180);

    // Haversine公式
    final double dLat = lat2 - lat1;
    final double dLon = lon2 - lon1;
    final double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1) *
            math.cos(lat2) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    final double c = 2 * math.asin(math.sqrt(a));

    return earthRadius * c;
  }

  // 保存路径
  DeliveryRouteModel saveRoute() {
    final savedRoute = DeliveryRouteModel(
      id: route?.id ?? const Uuid().v4(),
      name: name,
      description: description,
      waypoints: waypoints,
      distance: double.parse(distance.toStringAsFixed(2)),
      estimatedTime: estimatedTime,
      isActive: isActive,
    );

    return savedRoute;
  }

  // 切换路径激活状态
  void toggleActive() {
    isActive = !isActive;
    _initData();
  }

  @override
  void onInit() {
    super.onInit();
    route = Get.arguments as DeliveryRouteModel?;
    _initFormData();
  }

  @override
  void onReady() {
    super.onReady();
    _initData();

    // 如果有路径点，移动地图到第一个点
    if (waypoints.isNotEmpty) {
      mapController.move(waypoints.first, 15);
    }
  }
}
