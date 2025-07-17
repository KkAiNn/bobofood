import 'package:bobofood/common/widget/app_option.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class ChangeCardPage extends GetView<ChangeCardController> {
  const ChangeCardPage({super.key});

  // 主视图
  Widget _buildView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: ListView.builder(
        itemCount: controller.cardController.cardList.length,
        itemBuilder: (context, index) {
          var card = controller.cardController.cardList[index];
          return Container(
            margin: EdgeInsets.only(bottom: 16.h),
            child: AppOption.radio(
              text: '${card.bank} - ${card.name}',
              value: controller.selectedCard?.id == card.id,
              onChanged: (value) {
                controller.onTapCard(card);
              },
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangeCardController>(
      init: ChangeCardController(),
      id: "change_card",
      builder: (_) {
        return Scaffold(
          appBar: AppNavBar.editingSaveAndCancel(
            title: "Change Card",
            onSave: controller.onSave,
          ),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
