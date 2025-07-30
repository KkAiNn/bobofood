import 'dart:convert';

import 'package:bobofood/common/model/delivery_route.dart';
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
  DeliveryRouteModel? deliveryRoute; // 添加配送路径字段

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
    this.deliveryRoute, // 添加配送路径参数
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
    DeliveryRouteModel? deliveryRoute, // 添加配送路径参数
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
        deliveryRoute: deliveryRoute ?? this.deliveryRoute, // 添加配送路径
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
        deliveryRoute: json["deliveryRoute"] == null
            ? null
            : DeliveryRouteModel.fromMap(json["deliveryRoute"]), // 添加配送路径解析
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
        "deliveryRoute": deliveryRoute?.toMap(), // 添加配送路径序列化
      };
}
