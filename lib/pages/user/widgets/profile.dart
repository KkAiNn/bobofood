import 'dart:io';

import 'package:bobofood/common/widget/app_action_sheet.dart';
import 'package:bobofood/common/widget/app_avatar.dart';
import 'package:bobofood/common/widget/app_form_manager.dart';
import 'package:bobofood/common/widget/form/app_input.dart';
import 'package:bobofood/common/widget/form/app_select.dart';
import 'package:bobofood/utils/date.dart';
import 'package:bobofood/utils/datetime_picker.dart';
import 'package:bobofood/utils/media/media_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({
    super.key,
    this.name,
    this.phone,
    this.address,
    this.birthDate,
    this.phoneCode,
    this.onAddressTap,
    this.onAvatarTap,
    this.onAvatarSelected,
    this.onChanged,
    this.avatarUrl,
  });

  final String? name;
  final String? phone;
  final String? address;
  final String? birthDate;
  final String? phoneCode;
  final String? avatarUrl;
  final Function()? onAddressTap;
  final Function()? onAvatarTap;
  final Function(File? path)? onAvatarSelected;
  final Function(Map<String, String> data)? onChanged;

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  // 表单管理器
  late final AppFormManager formManager = AppFormManager(
    onAnyControllerChanged: _onFormChanged,
  );

  // 控制器定义
  late final nameController = formManager.register(
    'name',
    initialValue: widget.name,
    onTextChanged: _onFormChanged,
  );

  late final phoneCodeController = formManager.register(
    'phoneCode',
    initialValue: widget.phoneCode ?? '+00',
    onTextChanged: _onFormChanged,
  );

  late final phoneController = formManager.register(
    'phone',
    initialValue: widget.phone,
    onTextChanged: _onFormChanged,
  );

  late final addressController = formManager.register(
    'address',
    initialValue: widget.address,
    onTextChanged: _onFormChanged,
  );

  late final birthDateController = formManager.register(
    'birthDate',
    initialValue: widget.birthDate,
    onTextChanged: _onFormChanged,
  );

  @override
  void didUpdateWidget(ProfileWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 仅在属性变化时更新控制器值
    if (widget.address != oldWidget.address && widget.address != null) {
      addressController.text = widget.address!;
    }
    if (widget.phone != oldWidget.phone && widget.phone != null) {
      phoneController.text = widget.phone!;
    }
    if (widget.birthDate != oldWidget.birthDate && widget.birthDate != null) {
      birthDateController.text = widget.birthDate!;
    }
    if (widget.phoneCode != oldWidget.phoneCode && widget.phoneCode != null) {
      phoneCodeController.text = widget.phoneCode!;
    }
    if (widget.name != oldWidget.name && widget.name != null) {
      nameController.text = widget.name!;
    }
  }

  // 表单内容变化回调
  void _onFormChanged() {
    if (mounted) {
      widget.onChanged?.call(formManager.getAllValues());
    }
  }

  // 显示头像选择ActionSheet
  void _showAvatarOptions() {
    if (widget.onAvatarTap != null) {
      widget.onAvatarTap!();
      return;
    }

    AppActionSheet.show<String>(
      title: '选择头像',
      items: [
        ActionSheetItem(
          title: '拍照',
          value: 'camera',
          onTap: () async {
            var result = await MediaUtils.chooseImageFromCamera();
            widget.onAvatarSelected?.call(result);
          },
        ),
        ActionSheetItem(
          title: '从相册选择',
          value: 'gallery',
          onTap: () async {
            var result = await MediaUtils.chooseImage(maxAssets: 1);
            widget.onAvatarSelected?.call(result?.path.first);
          },
        ),
      ],
    );
  }

  // 显示日期选择器
  void _showDatePicker() async {
    var res = await showAppDateTimePicker(
      mode: AppDateTimePickerMode.date,
      initialTime: DateTime.now(),
      minTime: DateTime(1930, 1, 1),
      maxTime: DateTime.now(),
    );
    if (res != null) {
      setState(() {
        birthDateController.text = JiffyDateUtils.formatDate(res);
      });
    }
  }

  Widget _buildView() {
    return Column(
      children: [
        _buildAvatar(),
        SizedBox(height: 24.h),
        AppInput(
          hintText: 'full name',
          controller: nameController,
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            SizedBox(
              width: 68.w,
              child: AppInput(
                textAlign: TextAlign.right,
                hintText: '+00',
                controller: phoneCodeController,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: AppInput(
                hintText: 'phone number',
                controller: phoneController,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        AppSelectInput(
          showArrowRight: false,
          hintText: 'date of birth',
          controller: birthDateController,
          onTap: _showDatePicker,
        ),
        SizedBox(height: 12.h),
        AppSelectInput(
          hintText: 'Address',
          controller: addressController,
          onTap: widget.onAddressTap,
        ),
      ],
    );
  }

  Widget _buildAvatar() {
    final avatar = AppAvatar(
      avatarUrl: widget.avatarUrl ?? '',
      size: AvatarSize.xl,
      isShowCamera: true,
      onTap: _showAvatarOptions,
    );
    return avatar;
  }

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }

  @override
  void dispose() {
    formManager.dispose();
    super.dispose();
  }
}
