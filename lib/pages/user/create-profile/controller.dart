import 'dart:io';

import 'package:bobofood/common/model/user.dart';
import 'package:bobofood/common/controller/auth_controller.dart';
import 'package:bobofood/common/model/address.dart';
import 'package:bobofood/common/widget/app_action_sheet.dart';
import 'package:bobofood/pages/login/register/controller.dart';
import 'package:bobofood/router/app_router.dart';
import 'package:bobofood/utils/media/media_utils.dart';
import 'package:get/get.dart';

class CreateProfileController extends GetxController {
  CreateProfileController();

  AuthController authController = Get.find<AuthController>();
  RegisterController registerController = Get.find<RegisterController>();

  AddressModel? address;
  String? avatarUrl;
  bool isDisabled = true;

  Map<String, String> profile = {};

  _initData() {
    update(["create_profile"]);
  }

  String? password;
  String? code;
  String? email;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments != null) {
      password = arguments['password'];
      code = arguments['code'];
      email = arguments['email'];
    }
  }

  void onAvatarTap() async {
    AppActionSheet.show(
      title: '选择头像方式',
      items: [
        ActionSheetItem(
          title: '相机',
          onTap: () async {
            var result = await MediaUtils.chooseImageFromCamera();
            setAvatarUrl(result);
          },
        ),
        ActionSheetItem(
          title: '相册',
          onTap: () async {
            var result = await MediaUtils.chooseImage(maxAssets: 1);
            setAvatarUrl(result?.path.first);
          },
        )
      ],
    );
  }

  void setAvatarUrl(File? res) {
    print("url: $res");
    if (res != null) {
      avatarUrl = res.path;
      _initData();
      validateProfile();
    }
  }

  void onProfileChanged(Map<String, String> data) {
    profile = data;
    validateProfile();
  }

  void validateProfile() {
    bool _isDisabled = false;
    for (var key in profile.keys) {
      if (profile[key] == null || profile[key]!.isEmpty) {
        _isDisabled = true;
        break;
      }
    }
    if (avatarUrl == null) {
      _isDisabled = true;
    }
    if (_isDisabled != isDisabled) {
      isDisabled = _isDisabled;
      _initData();
    }
  }

  void onContinueTap() {
    UserModel userInfo = UserModel(
      name: profile['name'] ?? '',
      email: registerController.emailController.text,
      avatarUrl: avatarUrl ?? '',
      phoneCode: profile['phoneCode'] ?? '',
      phone: profile['phone'] ?? '',
      birthDate: profile['birthDate'] ?? '',
      token: '123',
      password: password!,
      address: address,
    );
    authController.register(userInfo);
  }

  // 在上一个页面中
  void goToAddAddress() async {
    final result = await Get.toNamed(AppRoute.addAddress, arguments: address);
    if (result != null) {
      address = result;
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
