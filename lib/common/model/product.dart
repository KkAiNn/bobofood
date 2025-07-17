import 'dart:convert';

class ProductModel {
  String? id;
  String? name;
  double? price;
  String? image;
  List<String>? banner;
  String? description;
  double? star;
  int? kcal;
  int? cookTime;

  ProductModel({
    this.id,
    this.name,
    this.price,
    this.image,
    this.banner,
    this.description,
    this.star,
    this.kcal,
    this.cookTime,
  });

  ProductModel copyWith({
    String? id,
    String? name,
    double? price,
    String? image,
    List<String>? banner,
    String? description,
    double? star,
    int? kcal,
    int? cookTime,
  }) =>
      ProductModel(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        image: image ?? this.image,
        banner: banner ?? this.banner,
        description: description ?? this.description,
        star: star ?? this.star,
        kcal: kcal ?? this.kcal,
        cookTime: cookTime ?? this.cookTime,
      );

  factory ProductModel.fromJson(String str) =>
      ProductModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        price: json["price"]?.toDouble(),
        image: json["image"],
        banner: json["banner"] == null
            ? []
            : List<String>.from(json["banner"]!.map((x) => x)),
        description: json["description"],
        star: json["star"]?.toDouble(),
        kcal: json["kcal"],
        cookTime: json["cookTime"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "price": price,
        "image": image,
        "banner":
            banner == null ? [] : List<dynamic>.from(banner!.map((x) => x)),
        "description": description,
        "star": star,
        "kcal": kcal,
        "cookTime": cookTime,
      };
}
