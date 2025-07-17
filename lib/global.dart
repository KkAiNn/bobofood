import 'package:bobofood/pages/main/splash.dart';
import 'package:bobofood/pages/main/view.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bobofood/common/controller/theme_controller.dart';
import 'package:bobofood/utils/platformutils.dart';
import 'common/controller/auth_controller.dart';
import 'network/dio_service.dart';
import 'router/app_router.dart';
import 'services/storage_services.dart';
import 'package:get/get.dart';

class Global {
  /// 初始化
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    await AppStorage.init();
    DioService();
    PlatformUtils.init();
    setSystemUi();
    initController();
  }

  /// 初始化控制器
  static void initController() {
    Get.put<AuthController>(AuthController());
    Get.put<ThemeController>(ThemeController());
  }

  /// 获取初始化页面
  static Widget getInitPage() {
    final splash = AppStorage.conifg.get(ConifgBoxKey.splash);
    if (splash == false) {
      return const SplashPage();
    }
    if (!Get.find<AuthController>().isLogin.value) {
      // return const LoginPage();
    }
    return const MainApp();
  }

  static String getInitRoute() {
    final splash =
        AppStorage.conifg.get(ConifgBoxKey.splash, defaultValue: false);
    if (splash == false) {
      return AppRoute.splash;
    }
    if (!Get.find<AuthController>().isLogin.value) {
      return AppRoute.login;
    }
    return AppRoute.home;
  }

  /// 设置系统UI
  static void setSystemUi() async {
    if (GetPlatform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 29) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      }
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child; // 禁用 Android 的拉伸 + iOS 的水波纹
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics(); // 禁用弹性
  }
}
