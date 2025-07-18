import 'dart:async';

import 'package:bobofood/common/model/product.dart';
import 'package:bobofood/common/widget/app_refresh_list_view.dart';
import 'package:bobofood/router/app_router.dart';
import 'package:bobofood/services/mock_data.dart';
import 'package:bobofood/utils/app_event_bus.dart';
import 'package:get/get.dart';

class FavouritesController extends GetxController {
  FavouritesController();
  late StreamSubscription _themeSub;

  late ListController<ProductModel> listController;

  _initData() {
    update(["favourites"]);
  }

  void onTapProduct(ProductModel product) {
    Get.toNamed(AppRoute.productDetail, arguments: product);
  }

  @override
  void onInit() {
    super.onInit();

    _themeSub = ThemeEventListener.listen(() {
      _initData();
    });
    listController = ListController<ProductModel>(
        defaultItems: MockData.products, autoInit: true);
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
