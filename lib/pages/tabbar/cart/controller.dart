import 'dart:async';

import 'package:bobofood/common/model/cart.dart';
import 'package:bobofood/common/model/product.dart';
import 'package:bobofood/router/app_router.dart';
import 'package:bobofood/utils/app_event_bus.dart';
import 'package:bobofood/utils/id_utils.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  late StreamSubscription _themeSub;
  List<CartModel> cartItems = [];

  String get totalPrice {
    return cartItems
        .fold(0.0, (sum, item) => sum + item.count * (item.product?.price ?? 0))
        .toStringAsFixed(2);
  }

  double get totalCount {
    return cartItems.fold(0, (sum, item) => sum + item.count);
  }

  void _initData() {
    update(["cart"]);
  }

  void addToCart(ProductModel product, {int count = 1}) {
    var cartItem = cartItems.firstWhere((item) => item.productId == product.id,
        orElse: () => CartModel(
            count: count,
            productId: product.id,
            id: IdUtils.uuid(),
            product: product));
    if (cartItems.contains(cartItem)) {
      cartItem.count += count;
    } else {
      cartItems.add(cartItem);
    }
    _initData();
  }

  void removeFromCart(CartModel cartItem) {
    cartItems.remove(cartItem);
    _initData();
  }

  void clearCart() {
    cartItems.clear();
    _initData();
  }

  void updateCartItemCount(CartModel cartItem, int count) {
    cartItems.firstWhere((item) => item.id == cartItem.id).count = count;
    _initData();
  }

  void onTapProceedToPay() {
    Get.toNamed(AppRoute.placeOrder);
  }

  @override
  void onInit() {
    super.onInit();
    cartItems = cartItems;
    _themeSub = ThemeEventListener.listen(() {
      _initData();
    });
  }

  @override
  void onClose() {
    super.onClose();
    _themeSub.cancel();
  }
}
