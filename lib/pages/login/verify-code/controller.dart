import 'package:bobofood/common/hooks/countdown_controller.dart';
import 'package:bobofood/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum VerifyCodeType {
  forgotPassword,
  register,
}

class VerifyCodeController extends GetxController {
  VerifyCodeController();

  _initData() {
    update(["verify_code"]);
  }

  String email = '';
  String password = '';
  String title = '';
  String description = '';
  VerifyCodeType type = VerifyCodeType.forgotPassword;

  var verificationCode = '';
  CountdownController countdownController =
      CountdownController(initialSeconds: 59);
  final formKey = GlobalKey<FormState>();
  int verificationCodeLength = 4;
  bool get isDisabled => verificationCode.length != verificationCodeLength;

  void onVerificationCodeonChanged(String value) {
    verificationCode = value;
    _initData();
  }

  void onTapContinue() {
    // 验证码
    if (verificationCode == '1234') {
      if (type == VerifyCodeType.forgotPassword) {
        Get.offNamed(AppRoute.createNewPassword, arguments: {
          'email': email,
          'code': verificationCode,
        });
      } else {
        Get.offNamed(AppRoute.createProfile, arguments: {
          'email': email,
          'password': password,
          'code': verificationCode,
        });
      }
    }
  }

  void onTapResend() {
    if (countdownController.isRunning) {
      return;
    }
    countdownController.start();
  }

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments != null) {
      email = arguments['email'];
      password = arguments['password'] ?? '';
      title = arguments['title'] ?? '';
      description = arguments['description'] ?? '';
      verificationCodeLength = arguments['verificationCodeLength'] ?? 4;
      type = arguments['type'] ?? VerifyCodeType.forgotPassword;
    }
    countdownController.start();
    countdownController.addListener(() => _initData());
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
