import 'package:bobofood/common/model/cart.dart';
import 'package:bobofood/common/model/coupon.dart';
import 'package:bobofood/pages/tabbar/cart/controller.dart';
import 'package:bobofood/router/app_router.dart';
import 'package:get/get.dart';

class PlaceOrderController extends GetxController {
  PlaceOrderController();

  final cartController = Get.find<CartController>();

  var expandList = false;

  List<CartModel> get cartItems => expandList
      ? cartController.cartItems
      : cartController.cartItems.take(3).toList();

  CouponModel? coupon;

  _initData() {
    update(["place_order"]);
  }

  void onTapExpand() {
    expandList = !expandList;
    update(["place_order"]);
  }

  void updateCartItemCount(CartModel cartItem, int count) {
    cartController.updateCartItemCount(cartItem, count);
    update(["place_order"]);
  }

  void removeFromCart(CartModel cartItem) {
    cartController.removeFromCart(cartItem);
    update(["place_order"]);
  }

  void onContinue() {
    Get.toNamed(AppRoute.checkout);
  }

  void onCouponTap() async {
    final result = await Get.toNamed(AppRoute.addCoupon, arguments: coupon);
    if (result != null) {
      coupon = result;
      update(["place_order"]);
    }
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
