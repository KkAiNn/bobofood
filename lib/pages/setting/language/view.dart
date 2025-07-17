import 'package:bobofood/common/widget/app_option.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class LanguagePage extends GetView<LanguageController> {
  const LanguagePage({super.key});

  // 主视图
  Widget _buildView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: SingleChildScrollView(
        child: Column(
          spacing: 12.h,
          children: [
            ...controller.languages.map((e) => AppOption.radio(
                  text: e,
                  value: e == controller.selectedLanguage,
                  onChanged: (value) {
                    controller.onLanguageChange(e);
                  },
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
      init: LanguageController(),
      id: "language",
      builder: (_) {
        return Scaffold(
          appBar: AppNavBar.editingSaveAndCancel(
              title: "Language", onSave: controller.onSave),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
