import 'package:bobofood/common/model/user.dart';
import 'package:bobofood/pages/address/controller.dart';
import 'package:bobofood/pages/card/payment_methods/controller.dart';
import 'package:bobofood/pages/tabbar/cart/controller.dart';
import 'package:bobofood/services/mock_data.dart';
import 'package:bobofood/services/storage_services.dart';
import 'package:bobofood/utils/location.dart';
import 'package:bobofood/utils/logger.dart';
import 'package:get/get.dart';

import '../../router/app_router.dart';

class LoginParamsState {
  final String email;
  final String password;
  final String? code;

  LoginParamsState({required this.email, required this.password, this.code});
}

class AuthController extends GetxController {
  var token = "".obs;
  Rx<UserModel?> userInfo = Rx<UserModel?>(null);

  RxBool get isLogin => token.isNotEmpty.obs;

  String get name => userInfo.value?.name ?? "";
  String get email => userInfo.value?.email ?? "";
  String get avatarUrl => userInfo.value?.avatarUrl ?? "";
  String get phone =>
      '${userInfo.value?.phoneCode ?? ''} ${userInfo.value?.phone ?? ''}';

  @override
  void onInit() {
    super.onInit();
    final raw = AppStorage.userInfo.get(LocalCacheKey.userInfo);
    userInfo.value =
        raw is Map ? UserModel.fromJson(Map<String, dynamic>.from(raw)) : null;
    token.value =
        AppStorage.auth.get(LocalCacheKey.token, defaultValue: "") ?? "";

    if (isLogin.value) {
      refreshInfo();
    }
  }

  void refreshInfo() {
    loginSuccess();
  }

  void login(LoginParamsState data) {
    logger.d('email: ${data.email}, ,password: ${data.password}');
    loginSuccess();
    Get.offAllNamed(AppRoute.home);
  }

  void loginSuccess() {
    isLogin.value = true;
    final info = getUserInfo();
    token.value = info.token ?? "";
    AppStorage.auth.put(LocalCacheKey.token, token.value);
    updateUserInfo(info);
    initController();
  }

  void register(UserModel data) {
    isLogin.value = true;
    token.value = data.token ?? "";
    AppStorage.auth.put(LocalCacheKey.token, token.value);
    updateUserInfo(data);
    initController();
    Get.offAllNamed(AppRoute.home);
  }

  void initController() {
    LocationUtils.instance.init();
    // 地址
    Get.put<AddressController>(AddressController(), permanent: true);
    // 购物车
    Get.put<CartController>(CartController(), permanent: true);
    // 银行卡
    Get.put<PaymentMethodsController>(PaymentMethodsController(),
        permanent: true);
  }

  void disposeController() {
    Get.delete<AddressController>();
    Get.delete<CartController>();
    Get.delete<PaymentMethodsController>();
  }

  void logout() {
    isLogin.value = false;
    token.value = "";
    userInfo.value = null;
    AppStorage.auth.delete(LocalCacheKey.token);
    AppStorage.userInfo.delete(LocalCacheKey.userInfo);
    Get.offAllNamed(AppRoute.login);
    disposeController();
  }

  void deleteAccount() {
    logout();
  }

  UserModel getUserInfo() {
    return UserModel(
      address: MockData.address.first,
      avatarUrl: "assets/avatar.png",
      birthDate: "2025-07-17",
      email: "test@test.com",
      name: "123",
      password: "123",
      phone: "123",
      phoneCode: "+00",
      token: "123",
    );
  }

  void updateUserInfo(UserModel user) {
    userInfo.value = user;
    AppStorage.userInfo.put(LocalCacheKey.userInfo, user.toJson());
  }
}
