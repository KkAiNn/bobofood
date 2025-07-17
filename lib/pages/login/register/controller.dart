import 'package:bobofood/common/controller/auth_controller.dart';
import 'package:bobofood/common/widget/form/app_input.dart';
import 'package:bobofood/pages/login/verify-code/controller.dart';
import 'package:bobofood/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  RegisterController();
  final formKey = GlobalKey<FormState>();
  late final AppInputController emailController;
  late final AppInputController passwordController;
  bool isAgree = false;

  bool get isDisabled =>
      emailController.text.isEmpty ||
      passwordController.text.isEmpty ||
      !isAgree;

  AuthController authController = Get.find<AuthController>();

  _initData() {
    update(["register"]);
  }

  void onTap() {}

  void onTapAgree(bool value) {
    isAgree = value;
    update(["register"]);
  }

  String? validateEmail(value) {
    final trimmed = value?.trim() ?? "";
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (trimmed.isEmpty) {
      return 'Email is required';
    }
    if (!emailRegex.hasMatch(trimmed)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(value) {
    final trimmed = value?.trim() ?? "";
    if (trimmed.isEmpty) {
      return 'Password is required';
    }
    if (trimmed != '123') {
      return 'You have entered the incorrect password';
    }
    return null;
  }

  /// 点击注册
  void onTapRegister() {
    final isValid = formKey.currentState?.validate() ?? false;
    if (isValid) {
      Get.toNamed(AppRoute.verifyCode, arguments: {
        'email': emailController.text,
        'password': passwordController.text,
        'title': 'Verify your \nemail',
        'description':
            'Enter the verification code sent to your email ${emailController.text}',
        'type': VerifyCodeType.register,
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
    emailController = AppInputController(onTextChanged: _initData);
    passwordController = AppInputController(onTextChanged: _initData);
    emailController.text = 'test@test.com';
  }
  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
