import 'package:bobofood/common/controller/auth_controller.dart';
import 'package:bobofood/common/widget/form/app_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewPasswordController extends GetxController {
  CreateNewPasswordController();

  late AppInputController passwordController;
  late AppInputController confirmPasswordController;
  bool get isDisabled =>
      passwordController.text.isEmpty || confirmPasswordController.text.isEmpty;

  final formKey = GlobalKey<FormState>();
  AuthController authController = Get.find<AuthController>();

  String? email;
  String? code;

  _initData() {
    update(["create_new_password"]);
  }

  void onTap() {}
  void onTapContinue() {
    // 创建新密码
    final isValid = formKey.currentState?.validate() ?? false;
    if (isValid) {
      // 创建新密码
      authController.login(LoginParamsState(
          email: email!, password: passwordController.text, code: code));
    }
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();

    final arguments = Get.arguments;
    if (arguments != null) {
      email = arguments['email'];
      code = arguments['code'];
    }
    passwordController = AppInputController(onTextChanged: _initData);
    confirmPasswordController = AppInputController(onTextChanged: _initData);
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
