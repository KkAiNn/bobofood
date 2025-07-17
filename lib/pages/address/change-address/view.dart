import 'package:bobofood/common/widget/app_option.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class ChangeAddressPage extends GetView<ChangeAddressController> {
  const ChangeAddressPage({super.key});

  // 主视图
  Widget _buildView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: ListView.builder(
        itemCount: controller.addressController.addressList.length,
        itemBuilder: (context, index) {
          var address = controller.addressController.addressList[index];
          return Container(
            margin: EdgeInsets.only(bottom: 16.h),
            child: AppOption.radio(
              text: address.addressLabel,
              value: controller.selectedAddress?.id == address.id,
              onChanged: (value) {
                controller.onTapAddress(address);
              },
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangeAddressController>(
      init: ChangeAddressController(),
      id: "change_address",
      builder: (_) {
        return Scaffold(
          appBar: AppNavBar.editingSaveAndCancel(
            title: "Change Address",
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
