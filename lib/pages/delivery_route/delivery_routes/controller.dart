import 'dart:async';

import 'package:bobofood/common/model/delivery_route.dart';
import 'package:bobofood/router/app_router.dart';
import 'package:bobofood/services/mock_data.dart';
import 'package:bobofood/utils/app_event_bus.dart';
import 'package:get/get.dart';

class DeliveryRoutesController extends GetxController {
  DeliveryRoutesController();

  late StreamSubscription _themeSub;

  // 配送路径列表
  List<DeliveryRouteModel> deliveryRoutes = MockData.deliveryRoutes;

  _initData() {
    update(["delivery_routes"]);
  }

  // 添加新的配送路径
  void addDeliveryRoute(DeliveryRouteModel route) {
    deliveryRoutes.add(route);
    _initData();
  }

  // 更新配送路径
  void updateDeliveryRoute(DeliveryRouteModel route) {
    final index =
        deliveryRoutes.indexWhere((element) => element.id == route.id);
    if (index != -1) {
      deliveryRoutes[index] = route;
      _initData();
    }
  }

  // 删除配送路径
  void deleteDeliveryRoute(DeliveryRouteModel route) {
    deliveryRoutes.removeWhere((element) => element.id == route.id);
    _initData();
  }

  // 查看配送路径详情
  void viewDeliveryRouteDetail(DeliveryRouteModel route) {
    Get.toNamed(AppRoute.deliveryRouteDetail, arguments: route);
  }

  // 创建新的配送路径
  void createNewDeliveryRoute() async {
    final result = await Get.toNamed(AppRoute.deliveryRouteDetail);
    if (result != null && result is DeliveryRouteModel) {
      addDeliveryRoute(result);
    }
  }

  // 编辑配送路径
  void editDeliveryRoute(DeliveryRouteModel route) async {
    final result =
        await Get.toNamed(AppRoute.deliveryRouteDetail, arguments: route);
    if (result != null && result is DeliveryRouteModel) {
      updateDeliveryRoute(result);
    }
  }

  @override
  void onInit() {
    super.onInit();
    _themeSub = ThemeEventListener.listen(() {
      _initData();
    });
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  void onClose() {
    super.onClose();
    _themeSub.cancel();
  }
}
