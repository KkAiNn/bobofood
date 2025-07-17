import 'package:bobofood/common/model/card.dart';
import 'package:bobofood/pages/card/payment_methods/controller.dart';
import 'package:get/get.dart';

class ChangeCardController extends GetxController {
  ChangeCardController();

  PaymentMethodsController cardController =
      Get.find<PaymentMethodsController>();

  CardModel? selectedCard;

  _initData() {
    update(["change_card"]);
  }

  void onTap() {}

  void onTapCard(CardModel card) {
    selectedCard = card;
    _initData();
  }

  void onSave() {
    Get.back(result: selectedCard);
  }

  @override
  void onInit() {
    super.onInit();
    var card = Get.arguments as CardModel?;
    if (card != null) {
      selectedCard = card;
      _initData();
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
