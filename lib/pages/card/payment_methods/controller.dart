import 'package:bobofood/common/model/card.dart';
import 'package:bobofood/router/app_router.dart';
import 'package:get/get.dart';

class PaymentMethodsController extends GetxController {
  PaymentMethodsController();
  final List<CardModel> cardList = [
    CardModel(
      id: '1',
      name: 'Daniel Jones',
      number: '1234567890',
      date: '12/2025',
      cvv: '123',
      bank: 'Mastercard',
      isDefault: true,
    ),
    CardModel(
      id: '2',
      name: 'Emily Jones',
      number: '1234567890',
      date: '12/2025',
      cvv: '123',
      bank: 'Mastercard',
      isDefault: false,
    ),
  ];

  CardModel? get defaultCard =>
      cardList.firstWhereOrNull((element) => element.isDefault == true);

  List<CardModel> get otherCard =>
      cardList.where((element) => element.isDefault == false).toList();

  _initData() {
    update(["payment_methods"]);
  }

  void addCard(CardModel card) {
    cardList.add(card);
    if (card.isDefault == true) {
      setDefaultCard(card);
    }
  }

  void updateCard(CardModel card) {
    final index = cardList.indexWhere((element) => element.id == card.id);
    if (index != -1) {
      cardList[index] = card;
      if (card.isDefault == true) {
        setDefaultCard(card);
      }
    } else {
      addCard(card);
    }
  }

  void deleteCard(CardModel card) {
    cardList.remove(card);
  }

  void setDefaultCard(CardModel card) {
    for (var element in cardList) {
      element.isDefault = false;
    }
    card.isDefault = true;
  }

  void onAddCard() async {
    final res = await Get.toNamed(AppRoute.addCard);
    if (res != null) {
      addCard(res as CardModel);
    }
    _initData();
  }

  void onEditDefaultCard() async {
    final res = await Get.toNamed(AppRoute.addCard, arguments: defaultCard);
    if (res != null) {
      updateCard(res as CardModel);
    }
    _initData();
  }

  void onEditCard(CardModel card) async {
    final res = await Get.toNamed(AppRoute.addCard, arguments: card);
    if (res != null) {
      updateCard(res as CardModel);
    }
    _initData();
  }

  void onTap() {}

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
