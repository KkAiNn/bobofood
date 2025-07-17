import 'package:bobofood/constants/colors.dart';
import 'package:bobofood/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// 底部弹出框组件
/// // 基本用法
/// ```
/// AppBottomPopup.show(
///   title: '选择日期',
///   content: Column(
///     children: [
///       // 您的内容，例如日期选择器
///       Text('这里放日期选择器'),
///     ],
///   ),
///   confirmText: '确认',
///   cancelText: '取消',
///   onConfirm: () {
///     // 确认按钮点击回调
///     print('用户确认了选择');
///     Get.back(result: '选择的结果'); // 可以返回数据给调用方
///   },
///   onCancel: () {
///     // 取消按钮点击回调
///     print('用户取消了选择');
///     Get.back();
///   },
/// );
/// // 获取返回结果
/// final result = await AppBottomPopup.show(
///   title: '选择日期',
///   content: CustomDatePicker(), // 您的自定义日期选择器组件
///   confirmText: '确认',
///   cancelText: '取消',
/// );
/// if (result != null) {
///   print('用户选择了: $result');
/// }
/// // 自定义底部按钮
/// AppBottomPopup.show(
///   title: '自定义底部按钮',
///   content: Text('内容区域'),
///   showBottomButtons: false, // 不显示默认的底部按钮
///   customBottomButtons: Row(
///     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
///     children: [
///       ElevatedButton(
///         onPressed: () => Get.back(),
///         child: Text('按钮1'),
///       ),
///       ElevatedButton(
///         onPressed: () => Get.back(),
///         child: Text('按钮2'),
///       ),
///       ElevatedButton(
///         onPressed: () => Get.back(),
///         child: Text('按钮3'),
///       ),
///     ],
///   ),
/// );
/// ```
class AppBottomPopup extends StatelessWidget {
  /// 弹出框标题
  final String? title;

  /// 弹出框内容
  final Widget content;

  /// 确认按钮文本
  final String? confirmText;

  /// 取消按钮文本
  final String? cancelText;

  /// 确认按钮回调
  final VoidCallback? onConfirm;

  /// 取消按钮回调
  final VoidCallback? onCancel;

  /// 弹出框高度
  final double? height;

  /// 是否显示关闭按钮
  final bool showCloseButton;

  /// 是否显示底部按钮
  final bool showBottomButtons;

  /// 弹出框圆角大小
  final double borderRadius;

  /// 底部确认按钮是否禁用
  final bool confirmDisabled;

  /// 自定义底部按钮
  final Widget? customBottomButtons;

  /// 是否可以通过点击背景关闭
  final bool barrierDismissible;

  /// 顶部内边距
  final EdgeInsetsGeometry? contentPadding;

  const AppBottomPopup({
    Key? key,
    this.title,
    required this.content,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.height,
    this.showCloseButton = true,
    this.showBottomButtons = true,
    this.borderRadius = 24.0,
    this.confirmDisabled = false,
    this.customBottomButtons,
    this.barrierDismissible = true,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: AppColors.colors.background.layer1Background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: height ?? MediaQuery.of(context).size.height * 0.85,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 头部
          _buildHeader(),

          // 内容区域
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: contentPadding ??
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: content,
              ),
            ),
          ),

          // 底部按钮
          if (showBottomButtons) _buildBottomButtons(),
        ],
      ),
    );
  }

  // 构建头部
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.colors.background.layer1Background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 标题
          Expanded(
            child: Text(
              title ?? '',
              style: AppTextStyle.poppinMedium700(
                color: AppColors.colors.typography.heading,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // 关闭按钮
          if (showCloseButton)
            InkWell(
              onTap: () {
                if (onCancel != null) {
                  onCancel!();
                } else {
                  Get.back();
                }
              },
              child: Container(
                padding: EdgeInsets.all(4.w),
                child: Icon(
                  Icons.close,
                  color: AppColors.colors.icon.defaultColor,
                  size: 24.w,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // 构建底部按钮
  Widget _buildBottomButtons() {
    if (customBottomButtons != null) {
      return customBottomButtons!;
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          // 取消按钮
          if (cancelText != null)
            Expanded(
              child: InkWell(
                onTap: () {
                  if (onCancel != null) {
                    onCancel!();
                  } else {
                    Get.back();
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: AppColors.colors.background.elementBackground,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.colors.bordersAndSeparators.defaultColor,
                      width: 1.w,
                    ),
                  ),
                  child: Text(
                    cancelText!,
                    style: AppTextStyle.poppinMedium600(
                      color: AppColors.colors.typography.paragraph,
                    ),
                  ),
                ),
              ),
            ),

          // 按钮之间的间距
          if (cancelText != null && confirmText != null) SizedBox(width: 12.w),

          // 确认按钮
          if (confirmText != null)
            Expanded(
              child: InkWell(
                onTap: confirmDisabled
                    ? null
                    : () {
                        if (onConfirm != null) {
                          onConfirm!();
                        } else {
                          Get.back();
                        }
                      },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: confirmDisabled
                        ? AppColors.colors.background.disabled
                        : AppColors.colors.background.primary,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    confirmText!,
                    style: AppTextStyle.poppinMedium600(
                      color: confirmDisabled
                          ? AppColors.colors.typography.disabled
                          : AppColors.colors.typography.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // 显示底部弹出框的静态方法
  static Future<T?> show<T>({
    String? title,
    required Widget content,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    double? height,
    bool showCloseButton = true,
    bool showBottomButtons = true,
    double borderRadius = 24.0,
    bool confirmDisabled = false,
    Widget? customBottomButtons,
    bool barrierDismissible = true,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return Get.bottomSheet<T>(
      AppBottomPopup(
        title: title,
        content: content,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
        height: height,
        showCloseButton: showCloseButton,
        showBottomButtons: showBottomButtons,
        borderRadius: borderRadius,
        confirmDisabled: confirmDisabled,
        customBottomButtons: customBottomButtons,
        contentPadding: contentPadding,
      ),
      barrierColor: Colors.black.withOpacity(0.5),
      isDismissible: barrierDismissible,
      enableDrag: true,
      isScrollControlled: true,
      ignoreSafeArea: false,
    );
  }
}
