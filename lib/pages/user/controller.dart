import 'dart:async';

import 'package:bobofood/common/controller/auth_controller.dart';
import 'package:bobofood/common/controller/theme_controller.dart';
import 'package:bobofood/constants/constants.dart';
import 'package:bobofood/router/app_router.dart';
import 'package:bobofood/utils/app_event_bus.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  UserController();
  late StreamSubscription _themeSub;

  ThemeController themeController = Get.find<ThemeController>();

  AuthController authController = Get.find<AuthController>();

  bool get isDarkMode => themeController.isDark;

  String get logo => AppConstants.appLogo;

  _initData() {
    update(["user"]);
  }

  void onTap() {}

  void onToggleDarkMode(bool value) {
    themeController.toggleTheme();
  }

  void onTapMyAccount() {
    Get.toNamed(AppRoute.myAccount);
  }

  void onTapMyOrder() {
    Get.toNamed(AppRoute.myOrder);
  }

  void onTapPaymentMethods() {
    Get.toNamed(AppRoute.paymentMethods);
  }

  void onTapAddress() {
    Get.toNamed(AppRoute.address);
  }

  void onTapSettings() {
    Get.toNamed(AppRoute.settings);
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
