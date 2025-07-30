import 'dart:async';
import 'dart:io';

import 'package:bobofood/common/controller/auth_controller.dart';
import 'package:bobofood/common/model/address.dart';
import 'package:bobofood/common/model/user.dart';
import 'package:bobofood/pages/address/controller.dart';
import 'package:bobofood/router/app_router.dart';
import 'package:bobofood/utils/app_event_bus.dart';
import 'package:get/get.dart';

class MyAccountController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final AddressController addressController = Get.find<AddressController>();
  late StreamSubscription _themeSub;

  late UserModel? user;
  String get phone => authController.phone;

  bool isEditing = false;

  void onEditTap() {
    isEditing = true;
    _initData();
  }

  void onSaveTap() {
    isEditing = false;
    authController.updateUserInfo(user!);
    _initData();
  }

  void onCancelTap() {
    isEditing = false;
    user = authController.userInfo.value;
    _initData();
  }

  void goToAddAddress() async {
    if (addressController.addressList.isEmpty) {
      var res = await Get.toNamed(AppRoute.addAddress) as AddressModel?;
      if (res != null) {
        addressController.addressList.add(res);
        user = user?.copyWith(address: res);
      }
    } else {
      var res =
          await Get.toNamed(AppRoute.changeAddress, arguments: user?.address)
              as AddressModel?;
      if (res != null) {
        user = user?.copyWith(address: res);
      }
    }
    _initData();
  }

  void onAvatarSelected(File? path) {
    if (path != null) {
      user = user?.copyWith(avatarUrl: path.path);
      _initData();
    }
  }

  void onProfileChanged(Map<String, String> data) {
    user = user?.copyWith(
      name: data['name'],
      phone: data['phone'],
      birthDate: data['birthDate'],
      phoneCode: data['phoneCode'],
    );
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

  // 添加配送路径管理功能
  void onTapDeliveryRoutes() {
    Get.toNamed(AppRoute.deliveryRoutes);
  }

  _initData() {
    update(["my_account"]);
  }

  void onTap() {}

  @override
  void onInit() {
    super.onInit();
    user = authController.userInfo.value;
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
