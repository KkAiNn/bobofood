import 'dart:convert';

import 'package:bobofood/common/model/product.dart';

class OrderModel {
  int? id;
  String? status;
  String? orderSummary;
  String? totalPrice;
  String? deliveryTime;
  String? deliveryStatus;
  String? deliveryAddress;
  String? deliveryPhone;
  String? deliveryEmail;
  String? deliveryDate;
  List<ProductModel>? products;

  OrderModel({
    this.id,
    this.status,
    this.orderSummary,
    this.totalPrice,
    this.deliveryTime,
    this.deliveryStatus,
    this.deliveryAddress,
    this.deliveryPhone,
    this.deliveryEmail,
    this.deliveryDate,
    this.products,
  });

  OrderModel copyWith({
    int? id,
    String? status,
    String? orderSummary,
    String? totalPrice,
    String? deliveryTime,
    String? deliveryStatus,
    String? deliveryAddress,
    String? deliveryPhone,
    String? deliveryEmail,
    String? deliveryDate,
    List<ProductModel>? products,
  }) =>
      OrderModel(
        id: id ?? this.id,
        status: status ?? this.status,
        orderSummary: orderSummary ?? this.orderSummary,
        totalPrice: totalPrice ?? this.totalPrice,
        deliveryTime: deliveryTime ?? this.deliveryTime,
        deliveryStatus: deliveryStatus ?? this.deliveryStatus,
        deliveryAddress: deliveryAddress ?? this.deliveryAddress,
        deliveryPhone: deliveryPhone ?? this.deliveryPhone,
        deliveryEmail: deliveryEmail ?? this.deliveryEmail,
        deliveryDate: deliveryDate ?? this.deliveryDate,
        products: products ?? this.products,
      );

  factory OrderModel.fromJson(String str) =>
      OrderModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderModel.fromMap(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        status: json["status"],
        orderSummary: json["orderSummary"],
        totalPrice: json["totalPrice"],
        deliveryTime: json["deliveryTime"],
        deliveryStatus: json["deliveryStatus"],
        deliveryAddress: json["deliveryAddress"],
        deliveryPhone: json["deliveryPhone"],
        deliveryEmail: json["deliveryEmail"],
        deliveryDate: json["deliveryDate"],
        products: json["products"] == null
            ? []
            : List<ProductModel>.from(
                json["products"].map((x) => ProductModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "status": status,
        "orderSummary": orderSummary,
        "totalPrice": totalPrice,
        "deliveryTime": deliveryTime,
        "deliveryStatus": deliveryStatus,
        "deliveryAddress": deliveryAddress,
        "deliveryPhone": deliveryPhone,
        "deliveryEmail": deliveryEmail,
        "deliveryDate": deliveryDate,
        "products": products?.map((x) => x.toMap()).toList(),
      };
}
