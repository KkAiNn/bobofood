import 'package:bobofood/common/controller/auth_controller.dart';
import 'package:bobofood/common/controller/theme_controller.dart';
import 'package:bobofood/common/widget/button/app_button.dart';
import 'package:bobofood/router/app_router.dart';
import 'package:bobofood/utils/toast.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  SettingController();

  ThemeController themeController = Get.find<ThemeController>();

  AuthController authController = Get.find<AuthController>();

  String selectedLanguage = 'English';

  bool get isDarkMode => themeController.isDark;
  _initData() {
    update(["setting"]);
  }

  void onToggleDarkMode(bool value) {
    themeController.toggleTheme();
    _initData();
  }

  void onTapSwitchAccount() {}

  void onTapLanguage() async {
    var result = await Get.toNamed(AppRoute.language) as String?;
    if (result != null) {
      selectedLanguage = result;
      _initData();
    }
  }

  void onTapPrivacyPolicy() {
    // Get.toNamed(AppRoute.privacyPolicy);
  }

  void onTapCustomerSupport() {
    // Get.toNamed(AppRoute.customerSupport);
  }

  void onTapTermsAndConditions() {
    // Get.toNamed(AppRoute.termsAndConditions);
  }

  void onTapDeleteAccount() {
    Get.toNamed(AppRoute.deleteAccount);
  }

  void onTapLogout() {
    AppToast.showDialog(
      title: 'Are you sure?',
      description: 'Are you sure, you want to log out from this account?',
      confirmType: AppButtonType.danger,
      confirmText: 'Log out',
      onConfirm: () {
        authController.logout();
      },
    );
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
