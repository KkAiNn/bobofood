import 'package:bobofood/common/model/product.dart';
import 'package:bobofood/pages/tabbar/cart/controller.dart';
import 'package:bobofood/utils/toast.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  ProductDetailController();
  final CartController cartController = Get.find<CartController>();

  _initData() {
    update(["product_detail"]);
  }

  int currentIndex = 0;

  bool isLike = false;
  bool readMore = false;
  int count = 1;
  late ProductModel product;

  double get totalPrice => (product.price ?? 0) * count;

  void onTapRemove() {
    count--;
    update(["product_detail"]);
  }

  void onTapAdd() {
    count++;
    update(["product_detail"]);
  }

  void onPageChanged(int index) {
    currentIndex = index;
    update(["product_detail"]);
  }

  void onTapReadMore() {
    readMore = !readMore;
    update(["product_detail"]);
  }

  void onTapLike() {
    isLike = !isLike;
    update(["product_detail"]);
  }

  void onTapShare() {}

  void onTapAddToCart() {
    cartController.addToCart(product, count: count);
    AppToast.show('Add to cart success');
  }

  @override
  void onInit() {
    super.onInit();
    product = Get.arguments;
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
