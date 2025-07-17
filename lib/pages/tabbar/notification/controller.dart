import 'dart:async';

import 'package:bobofood/common/model/notification.dart';
import 'package:bobofood/common/widget/app_refresh_list_view.dart';
import 'package:bobofood/common/widget/app_segmented.dart';
import 'package:bobofood/services/mock_data.dart';
import 'package:bobofood/utils/app_event_bus.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  NotificationController();

  late StreamSubscription _themeSub;
  List<AppSegmentedItem> items = [
    AppSegmentedItem(value: 'new', label: 'New', showDot: true),
    AppSegmentedItem(value: 'old', label: 'Old'),
  ];
  late AppSegmentedItem selectedValue = items.first;

  PageController pageController = PageController();

  late ListController<NotificationModel> listController;
  late ListController<NotificationModel> oldListController;

  void onValueChanged(AppSegmentedItem value) {
    selectedValue = value;
    pageController.animateToPage(items.indexOf(value),
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    update(["notification"]);
  }

  _initData() {
    update(["notification"]);
  }

  void onTap() {}

  void onPageChanged(int index) {
    selectedValue = items[index];
    update(["notification"]);
  }

  @override
  void onInit() {
    super.onInit();
    _themeSub = ThemeEventListener.listen(() {
      _initData();
    });
    listController = ListController<NotificationModel>(
      defaultItems: MockData.notifications,
      autoInit: true,
    );
    oldListController = ListController<NotificationModel>(
      defaultItems: MockData.notifications,
      autoInit: true,
    );
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
