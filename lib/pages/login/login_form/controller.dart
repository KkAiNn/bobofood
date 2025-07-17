import 'package:bobofood/common/controller/auth_controller.dart';
import 'package:bobofood/common/widget/form/app_input.dart';
import 'package:bobofood/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginFormController extends GetxController {
  LoginFormController();
  final formKey = GlobalKey<FormState>();
  final emailFieldKey = GlobalKey<FormFieldState>();
  late final AppInputController emailController;
  late final AppInputController passwordController;

  bool get isDisabled => emailController.text.isEmpty;

  AuthController authController = Get.find<AuthController>();

  _initData() {
    update(["login_form"]);
  }

  void onTap() {}

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

  /// 点击登录
  void onTapLogin() {
    final isValid = formKey.currentState?.validate() ?? false;
    if (isValid) {
      authController.login(LoginParamsState(
        email: emailController.text,
        password: passwordController.text,
      ));
    }
  }

  void onTapSignUp() {
    Get.toNamed(AppRoute.register);
  }

  void onTapForgotPassword() {
    final isValid = emailFieldKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    Get.toNamed(AppRoute.verifyCode, arguments: {
      'email': emailController.text,
      'title': 'Forgot your \npassword',
      'description':
          'Enter the verification code sent to your email ${emailController.text}',
    });
  }

  @override
  void onInit() {
    super.onInit();
    emailController = AppInputController(onTextChanged: _initData);
    passwordController = AppInputController(onTextChanged: _initData);
    emailController.text = 'test@test.com';
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
