import 'package:bobofood/router/app_router.dart';
import 'package:bobofood/services/storage_services.dart';
import 'package:bobofood/utils/toast.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  LoginController();

  _initData() {
    update(["login"]);
  }

  void onTap() {}

  void onTapApple() {
    AppStorage.conifg.put(ConifgBoxKey.splash, false);
    AppToast.show('Coming soon');
  }

  void onTapGoogle() {
    AppToast.show('Coming soon');
  }

  void onTapFacebook() {
    AppToast.show('Coming soon');
  }

  void onTapEmail() {
    // AppToast.show('Coming soon');
    Get.toNamed(AppRoute.loginForm);
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
