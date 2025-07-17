import 'package:bobofood/common/widget/app_divider.dart';
import 'package:bobofood/common/widget/app_option.dart';
import 'package:bobofood/common/widget/app_option_group.dart';
import 'package:bobofood/common/widget/app_svg.dart';
import 'package:bobofood/common/widget/navigate/app_navbar.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class AddressPage extends GetView<AddressController> {
  const AddressPage({super.key});
  Widget _buildDefaultAddress() {
    return AppOptionGroup(
      title: 'Default',
      options: [
        AppOption(
          text: controller.defaultAddress != null
              ? '${controller.defaultAddress?.addressLabel}'
              : 'Add Default Address',
          onTap: controller.onEditDefaultAddress,
          isDisabled: controller.defaultAddress == null,
        ),
      ],
    );
  }

  Widget _buildOtherAddress() {
    return AppOptionGroup(
      title: 'Others',
      options: [
        Expanded(
            child: ListView.builder(
          itemCount: controller.otherAddress.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: AppOption(
                text: controller.otherAddress[index].addressLabel,
                onTap: () {
                  controller.onEditAddress(controller.otherAddress[index]);
                },
              ),
            );
          },
        )),
      ],
    );
  }

  // 主视图
  Widget _buildView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Column(
        spacing: 24.h,
        children: [
          _buildDefaultAddress(),
          AppDivider(),
          Expanded(child: _buildOtherAddress())
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(
      init: AddressController(),
      id: "address",
      builder: (_) {
        return Scaffold(
          appBar: AppNavBar(
            titleText: 'Addresses',
            trailingWidgets: [
              TapEffect(
                  onTap: controller.onAddAddress,
                  child: AppSvg(
                    path: 'assets/icons/Add.svg',
                    width: 24.w,
                    height: 24.w,
                  )),
            ],
          ),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
