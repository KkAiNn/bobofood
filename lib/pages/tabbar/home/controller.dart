import 'dart:async';

import 'package:bobofood/common/controller/auth_controller.dart';
import 'package:bobofood/common/model/product.dart';
import 'package:bobofood/common/widget/app_refresh_list_view.dart';
import 'package:bobofood/pages/tabbar/cart/controller.dart';
import 'package:bobofood/router/app_router.dart';
import 'package:bobofood/services/mock_data.dart';
import 'package:bobofood/utils/app_event_bus.dart';
import 'package:bobofood/utils/toast.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late StreamSubscription _themeSub;
  // 用户控制器
  final authController = Get.find<AuthController>();

  // 当前选中的 tab
  String currentTab = 'All';

  // 轮播图片
  List<String> images = [
    'assets/home/Slide1.png',
    'assets/home/Slide2.png',
  ];

  // 列表控制器
  late ListController listController;

  final CartController cartController = Get.find<CartController>();

  // 食品列表
  List<ProductModel> foodItems = [];

  // tab 列表
  List<String> tabs = [
    'All',
    'Food',
    'Drinks',
    'Snacks',
    'Sauce',
  ];
  void _initData() {
    update(["home"]);
  }

  @override
  void onInit() {
    super.onInit();
    // 初始化食品列表数据
    _initFoodItems();
    // 初始化列表控制器
    listController = ListController(
      defaultItems: foodItems, // 两个虚拟项：头部和网格
      autoInit: true,
    );
    _themeSub = ThemeEventListener.listen(() {
      _initData();
    });
  }

  // 初始化食品数据
  void _initFoodItems() {
    foodItems = MockData.products;
  }

  void onTapProduct(ProductModel product) {
    Get.toNamed(AppRoute.productDetail, arguments: product);
  }

  void onTapAddToCart(ProductModel product) {
    cartController.addToCart(product, count: 1);
    AppToast.show('Add to cart success');
  }

  // 切换 tab
  void changeTab(String tab) {
    currentTab = tab;
    _initData();
  }

  @override
  void onClose() {
    super.onClose();
    _themeSub.cancel();
  }
}
