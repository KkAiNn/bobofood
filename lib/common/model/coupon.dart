class CouponModel {
  final String id;
  final String name;
  final String code;
  final double discount;
  final double minOrderAmount;
  final double maxDiscount;
  final String description;

  CouponModel({
    required this.id,
    required this.name,
    required this.code,
    required this.discount,
    required this.minOrderAmount,
    required this.maxDiscount,
    required this.description,
  });
}
