import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  SubscriptionController();

  _initData() {
    update(["subscription"]);
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
