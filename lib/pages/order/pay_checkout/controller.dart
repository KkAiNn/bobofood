import 'package:bobofood/common/model/address.dart';
import 'package:bobofood/common/model/card.dart';
import 'package:bobofood/pages/address/controller.dart';
import 'package:bobofood/pages/card/payment_methods/controller.dart';
import 'package:bobofood/pages/tabbar/cart/controller.dart';
import 'package:bobofood/router/app_router.dart';
import 'package:bobofood/services/notification_service.dart';
import 'package:bobofood/utils/date.dart';
import 'package:get/get.dart';

class PayCheckoutController extends GetxController {
  PayCheckoutController();

  CartController cartController = Get.find<CartController>();

  AddressController addressController = Get.find<AddressController>();

  PaymentMethodsController cardController =
      Get.find<PaymentMethodsController>();

  AddressModel? address;

  CardModel? card;

  _initData() {
    update(["pay_checkout"]);
  }

  void onTap() {}

  @override
  void onInit() {
    super.onInit();
    address = addressController.defaultAddress;
    card = cardController.defaultCard;
  }

  void onTapChangeAddress() async {
    AddressModel? result;
    if (address == null) {
      result = await Get.toNamed(AppRoute.addAddress) as AddressModel?;
    } else {
      result = await Get.toNamed(AppRoute.changeAddress, arguments: address)
          as AddressModel?;
    }
    if (result != null) {
      address = result;
      _initData();
    }
  }

  void onTapChangeCard() async {
    CardModel? result;
    if (card == null) {
      result = await Get.toNamed(AppRoute.addCard) as CardModel?;
    } else {
      result =
          await Get.toNamed(AppRoute.changeCard, arguments: card) as CardModel?;
    }
    if (result != null) {
      card = result;
      _initData();
    }
  }

  Future<void> _showSimpleNotification() async {
    NotificationService notificationService = NotificationService();
    await notificationService.showSimpleNotification(
      id: JiffyDateUtils.formatToDateNumber(DateTime.now()),
      title: 'Order Placed',
      body: 'Your order would be delivered in the 30 mins atmost',
      payload: 'simple_notification',
    );
  }

  void onContinue() {
    _showSimpleNotification();
    int popCount = 0;
    Get.offNamedUntil(AppRoute.orderPlaced, (route) {
      return popCount++ >= 2; // 跳过2层
    });
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
