import 'package:bobofood/common/model/product.dart';

class CartModel {
  String id;
  int count;
  String? productId;
  ProductModel? product;

  CartModel(
      {required this.count, required this.id, this.productId, this.product});
}
