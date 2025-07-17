import 'package:bobofood/common/widget/app_option.dart';
import 'package:bobofood/common/widget/app_option_group.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({super.key});

  Widget _buildGeneral() {
    return AppOptionGroup(title: 'General', options: [
      AppOption(
        svgPath: 'assets/icons/Change.svg',
        text: 'Switch Account',
        onTap: () {
          controller.onTapSwitchAccount();
        },
      ),
      AppOption(
        svgPath: 'assets/icons/Language.svg',
        text: 'Language',
        subText: controller.selectedLanguage,
        onTap: () {
          controller.onTapLanguage();
        },
      ),
      AppOption.toggle(
        svgPath: 'assets/icons/Dark mode.svg',
        text: 'Dark mode',
        value: controller.isDarkMode,
        onChanged: (value) {
          controller.onToggleDarkMode(value);
        },
      ),
    ]);
  }

  Widget _buildOthers() {
    return AppOptionGroup(title: 'Others', options: [
      AppOption(
        svgPath: 'assets/icons/Privacy.svg',
        text: 'Privacy Policy',
        onTap: () {
          controller.onTapPrivacyPolicy();
        },
      ),
      AppOption(
        svgPath: 'assets/icons/Message.svg',
        text: 'Customer Support',
        onTap: () {
          controller.onTapCustomerSupport();
        },
      ),
      AppOption(
        svgPath: 'assets/icons/Document.svg',
        text: 'Terms & Conditions',
        onTap: () {
          controller.onTapTermsAndConditions();
        },
      ),
    ]);
  }

  Widget _buildDanger() {
    return AppOptionGroup(title: 'Danger Actions', options: [
      AppOption(
        svgPath: 'assets/icons/Delete.svg',
        text: 'Delete Account',
        onTap: () {
          controller.onTapDeleteAccount();
        },
      ),
      AppOption(
        svgPath: 'assets/icons/Log out.svg',
        text: 'Logout',
        onTap: () {
          controller.onTapLogout();
        },
      ),
    ]);
  }

  // 主视图
  Widget _buildView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Column(
        spacing: 16.h,
        children: [
          _buildGeneral(),
          _buildOthers(),
          _buildDanger(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
      init: SettingController(),
      id: "setting",
      builder: (_) {
        return Scaffold(
          appBar: AppNavBar(titleText: "Settings"),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
