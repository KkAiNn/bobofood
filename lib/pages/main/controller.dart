import 'dart:async';

import 'package:bobofood/pages/main/widgets/custom_nav_bottom.dart';
import 'package:bobofood/pages/tabbar/cart/index.dart';
import 'package:bobofood/pages/tabbar/favourites/view.dart';
import 'package:bobofood/pages/tabbar/home/view.dart';
import 'package:bobofood/pages/tabbar/notification/index.dart';
import 'package:bobofood/pages/tabbar/track_order/index.dart';
import 'package:bobofood/utils/feed_back.dart';
import 'package:flutter/material.dart';
import 'package:bobofood/services/storage_services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MainController extends GetxController {
  MainController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Box conifg = AppStorage.conifg;
  final StreamController<bool> bottomBarStream =
      StreamController<bool>.broadcast();
  late PageController pageController;
  late bool hideTabBar;
  int selectedIndex = 0;
  late final List<NavBottomItem> items = [
    NavBottomItem(
      svgPath: 'assets/tabbar/home.svg',
      label: '首页',
      page: HomePage(onOpenUser: () {
        scaffoldKey.currentState?.openDrawer();
      }),
    ),
    NavBottomItem(
      svgPath: 'assets/tabbar/track.svg',
      label: 'Track Order',
      page: const TrackOrderPage(),
    ),
    NavBottomItem(
      svgPath: 'assets/tabbar/cart.svg',
      label: 'Cart',
      page: const CartPage(),
    ),
    NavBottomItem(
      svgPath: 'assets/tabbar/favorite.svg',
      label: 'Favourites',
      page: const FavouritesPage(),
    ),
    NavBottomItem(
      svgPath: 'assets/tabbar/notification.svg',
      label: 'Notification',
      page: const NotificationPage(),
    ),
  ];
  _initData() {
    update(["MainApp"]);
  }

  void onTap() {}

  void jumpToPageWithIndex(int index) {
    // Get.offAllNamed(AppRoute.home, arguments: {'index': index});
    if (scaffoldKey.currentState?.isDrawerOpen ?? false) {
      scaffoldKey.currentState?.closeDrawer();
    }
    Get.until((route) => route.isFirst);
    jumpToPage(index);
  }

  void jumpToPage(int index) {
    feedBack();
    pageController.jumpToPage(index);
    _initData();
  }

  void onPageChanged(int index) {
    selectedIndex = index;
    _initData();
  }

  void onThemeChange() {
    _initData();
  }

  @override
  void onInit() {
    super.onInit();
    var args = Get.arguments;
    if (args != null) {
      selectedIndex = args['index'];
    }
    hideTabBar = conifg.get(ConifgBoxKey.hideTabBar, defaultValue: false);
    pageController = PageController(
      initialPage: selectedIndex,
    );
  }

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
