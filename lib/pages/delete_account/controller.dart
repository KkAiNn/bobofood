import 'package:bobofood/common/controller/auth_controller.dart';
import 'package:bobofood/common/widget/form/app_input.dart';
import 'package:get/get.dart';

class DeleteAccountController extends GetxController {
  DeleteAccountController();

  final authController = Get.find<AuthController>();

  late final inputController = AppInputController(onTextChanged: _initData);

  bool get isConfirm => inputController.text == "CONFIRM";

  _initData() {
    update(["delete_account"]);
  }

  void onTap() {}

  void deleteAccount() {
    authController.deleteAccount();
  }

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
