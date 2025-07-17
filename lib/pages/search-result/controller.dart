import 'package:bobofood/common/model/product.dart';
import 'package:bobofood/common/widget/app_refresh_list_view.dart';
import 'package:bobofood/pages/tabbar/cart/index.dart';
import 'package:bobofood/router/app_router.dart';
import 'package:bobofood/services/mock_data.dart';
import 'package:bobofood/utils/logger.dart';
import 'package:bobofood/utils/toast.dart';
import 'package:get/get.dart';

class SearchResultController extends GetxController {
  SearchResultController();

  String? searchValue;
  late ListController<ProductModel> listController;

  CartController cartController = Get.find<CartController>();

  List<String> items = [
    '1234567890',
    '1234567890',
    '1234567890',
    '1234567890',
    '1234567890',
    '1234567890'
  ];

  List<ProductModel> products = MockData.products;

  _initData() {
    update(["search_result"]);
  }

  void onTap() {}

  void onSearch(String value) {
    print(value);
  }

  void onChanged(String value) {
    print(value);
  }

  void onTapProduct(ProductModel product) {
    Get.toNamed(AppRoute.productDetail, arguments: product);
  }

  void onTapAddToCart(ProductModel product) {
    logger.d('onTapAddToCart');
    cartController.addToCart(product);
    AppToast.show('Added to cart');
  }

  @override
  void onInit() {
    super.onInit();
    searchValue = Get.arguments as String?;
    listController = ListController<ProductModel>(
      defaultItems: products,
      autoInit: true,
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
