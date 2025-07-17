import 'package:bobofood/common/model/coupon.dart';
import 'package:bobofood/common/widget/form/app_input.dart';
import 'package:get/get.dart';

class AddCouponController extends GetxController {
  AddCouponController();

  late final couponNameController =
      AppInputController(onTextChanged: _initData);

  bool get isDisabled => couponNameController.text.isEmpty;

  List<CouponModel> coupons = [
    CouponModel(
      id: '1',
      name: 'PIZZA10',
      description: 'Get 10% off on any pizza order.',
      code: 'PIZZA10',
      discount: 0,
      minOrderAmount: 0,
      maxDiscount: 0,
    ),
    CouponModel(
      id: '2',
      name: 'WELCOME50',
      description: '50% off your first order!',
      code: 'WELCOME50',
      discount: 0,
      minOrderAmount: 0,
      maxDiscount: 0,
    ),
    CouponModel(
      id: '3',
      name: 'WEEKEND5',
      description: 'Save \$5 on orders over \$25 this weekend.',
      code: 'WEEKEND5',
      discount: 0,
      minOrderAmount: 0,
      maxDiscount: 0,
    ),
    CouponModel(
      id: '4',
      name: 'EXTRA20',
      description: '20% off on orders above \$30.',
      code: 'EXTRA20',
      discount: 0,
      minOrderAmount: 0,
      maxDiscount: 0,
    ),
  ];

  CouponModel? selectedCoupon;

  _initData() {
    update(["add_coupon"]);
  }

  void onTapCoupon(CouponModel coupon) {
    selectedCoupon = coupon;
    update(["add_coupon"]);
  }

  void onTap() {}

  void onTapSave() {
    Get.back(result: selectedCoupon);
  }

  @override
  void onInit() {
    super.onInit();
    final coupon = Get.arguments;
    if (coupon != null) {
      selectedCoupon = coupon;
    }
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
