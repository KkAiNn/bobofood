import 'dart:async';

import 'package:bobofood/router/app_router.dart';
import 'package:bobofood/utils/app_event_bus.dart';
import 'package:bobofood/utils/logger.dart';
import 'package:get/get.dart';

class TrackOrderController extends GetxController {
  TrackOrderController();

  late StreamSubscription _themeSub;

  List<String> items = [
    '1234567890',
    '1234567890',
    '1234567890',
    '1234567890',
    '1234567890',
    '1234567890'
  ];

  List options = [
    {
      'title': 'Indian',
      'pic': 'assets/home/Indian.png',
    },
    {
      'title': 'Dessert',
      'pic': 'assets/home/Dessert.png',
    },
    {
      'title': 'Fast food',
      'pic': 'assets/home/Fast food.png',
    },
    {
      'title': 'Sea food',
      'pic': 'assets/home/Sea food.png',
    },
    {
      'title': 'Veg',
      'pic': 'assets/home/Veg.png',
    },
    {
      'title': 'Non-Veg',
      'pic': 'assets/home/Non-Veg.png',
    },
    {
      'title': 'Snacks',
      'pic': 'assets/home/Snacks.png',
    },
    {
      'title': 'Beverages',
      'pic': 'assets/home/Beverages.png',
    },
  ];

  _initData() {
    update(["track_order"]);
  }

  void onSearch(String value) {
    logger.d('onSearch: $value');
    Get.toNamed(AppRoute.searchResult, arguments: value);
  }

  void onTap() {}

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
