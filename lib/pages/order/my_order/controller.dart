import 'package:bobofood/common/model/order.dart';
import 'package:bobofood/common/widget/app_refresh_list_view.dart';
import 'package:bobofood/common/widget/app_segmented.dart';
import 'package:bobofood/common/widget/app_stars.dart';
import 'package:bobofood/services/mock_data.dart';
import 'package:bobofood/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrderController extends GetxController {
  MyOrderController();

  final List<AppSegmentedItem> orderStatus = [
    AppSegmentedItem(value: 'Current', label: 'Current', showDot: true),
    AppSegmentedItem(value: 'Previous', label: 'Previous'),
  ];
  late AppSegmentedItem selectedOrderStatus = orderStatus.first;
  late PageController pageController = PageController(initialPage: 0);

  late final ListController<OrderModel> orderListController =
      ListController(defaultItems: [
    OrderModel(
      id: 1,
      status: "Current",
      orderSummary: "Pepperoni Cheese Pizza",
      totalPrice: "24.02",
      deliveryTime: "30mins",
      deliveryStatus: "Out for delivery",
      deliveryAddress: "123 Main St, Anytown, USA",
      deliveryPhone: "123-456-7890",
      deliveryEmail: "john.doe@example.com",
      deliveryDate: "2021-01-01",
      products: MockData.products,
    ),
    OrderModel(
      id: 2,
      status: "Current",
      orderSummary: "Pepperoni Cheese Pizza",
      totalPrice: "24.02",
      deliveryTime: "30mins",
      deliveryStatus: "Out for delivery",
      deliveryAddress: "123 Main St, Anytown, USA",
      deliveryPhone: "123-456-7890",
      deliveryEmail: "john.doe@example.com",
      deliveryDate: "2021-01-01",
      products: MockData.products,
    )
  ], onUpdate: _initData, autoInit: true);

  late final ListController<OrderModel> previousListController =
      ListController(defaultItems: [
    OrderModel(
      id: 1,
      status: "Previous",
      orderSummary: "Pepperoni Cheese Pizza",
      totalPrice: "24.02",
      deliveryTime: "30mins",
      deliveryStatus: "Order delivered",
      deliveryAddress: "123 Main St, Anytown, USA",
      deliveryPhone: "123-456-7890",
      deliveryEmail: "john.doe@example.com",
      deliveryDate: "2021-01-01",
      products: MockData.products,
    ),
    OrderModel(
      id: 2,
      status: "Previous",
      orderSummary: "Pepperoni Cheese Pizza",
      totalPrice: "24.02",
      deliveryTime: "30mins",
      deliveryStatus: "Order delivered",
      deliveryAddress: "123 Main St, Anytown, USA",
      deliveryPhone: "123-456-7890",
      deliveryEmail: "john.doe@example.com",
      deliveryDate: "2021-01-01",
      products: [MockData.products.first],
    )
  ], onUpdate: _initData, autoInit: true);

  _initData() {
    update(["my_order"]);
  }

  void onTap() {}

  void onOrderStatusChanged(AppSegmentedItem value) {
    selectedOrderStatus = value;
    final index = orderStatus.indexOf(value);
    if (value.showDot) {
      orderStatus[index] = orderStatus[index].copyWith(showDot: false);
    }
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _initData();
  }

  void onPageChanged(int index) {
    selectedOrderStatus = orderStatus[index];
    _initData();
  }

  void onMoreTap(OrderModel order) {
    int rating = 0;
    AppToast.showDialog(
      title: 'Did you like this food!',
      description: 'Please rate this food so, that we can improve it!',
      showCancel: false,
      confirmText: 'Rate',
      onConfirm: () {
        Get.back();
      },
      child: AppStars(
        rating: rating,
        size: 48,
        onRatingChanged: (value) {
          rating = value;
        },
      ),
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
