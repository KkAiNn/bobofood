import 'package:bobofood/constants/colors.dart';
import 'package:bobofood/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// 操作项数据模型
class ActionSheetItem<T> {
  /// 操作项显示文本
  final String title;

  /// 操作项图标
  final IconData? icon;

  /// 图标颜色
  final Color? iconColor;

  /// 文本颜色
  final Color? textColor;

  /// 是否为危险操作
  final bool isDanger;

  /// 操作项关联的值
  final T? value;

  /// 是否禁用
  final bool isDisabled;

  final Function()? onTap;

  ActionSheetItem({
    required this.title,
    this.icon,
    this.iconColor,
    this.textColor,
    this.isDanger = false,
    this.value,
    this.isDisabled = false,
    this.onTap,
  });
}

/// ActionSheet组件
class AppActionSheet extends StatelessWidget {
  /// 操作项列表
  final List<ActionSheetItem> items;

  /// 标题
  final String? title;

  /// 取消按钮文本
  final String? cancelText;

  /// 弹出框圆角大小
  final double borderRadius;

  /// 分割线颜色
  final Color? dividerColor;

  /// 操作项高度
  final double itemHeight;

  /// 标题文本样式
  final TextStyle? titleStyle;

  /// 间距
  final double spacing;

  const AppActionSheet({
    Key? key,
    required this.items,
    this.title,
    this.cancelText,
    this.borderRadius = 24.0,
    this.dividerColor,
    this.itemHeight = 56.0,
    this.titleStyle,
    this.spacing = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 操作项容器
          Container(
            decoration: BoxDecoration(
              color: AppColors.colors.background.layer1Background,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 标题
                if (title != null && title!.isNotEmpty) _buildTitle(),

                // 操作项列表
                ...List.generate(
                  items.length,
                  (index) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 不是第一项且有标题时添加分割线
                      if (index > 0 || (title != null && title!.isNotEmpty))
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: dividerColor ??
                              AppColors.colors.bordersAndSeparators.light,
                        ),
                      // 操作项
                      _buildActionItem(items[index]),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spacing),

          // 取消按钮
          Container(
            margin: EdgeInsets.only(
              left: 8.w,
              right: 8.w,
              bottom: 8.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.colors.background.layer1Background,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Get.back(),
                borderRadius: BorderRadius.circular(borderRadius),
                child: Container(
                  height: itemHeight,
                  alignment: Alignment.center,
                  child: Text(
                    cancelText ?? '取消',
                    style: AppTextStyle.poppinMedium600(
                      color: AppColors.colors.typography.paragraph,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 构建标题
  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      width: double.infinity,
      alignment: Alignment.center,
      child: Text(
        title!,
        style: titleStyle ??
            AppTextStyle.poppinMedium400(
              color: AppColors.colors.typography.paragraph,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // 构建操作项
  Widget _buildActionItem(ActionSheetItem item) {
    final textColor = item.isDanger
        ? AppColors.colors.typography.danger
        : (item.textColor ?? AppColors.colors.typography.heading);

    final iconColor = item.isDanger
        ? AppColors.colors.typography.danger
        : (item.iconColor ?? AppColors.colors.icon.defaultColor);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.isDisabled
            ? null
            : () {
                Get.back(result: item.value ?? item.title);
                item.onTap?.call();
              },
        child: Opacity(
          opacity: item.isDisabled ? 0.5 : 1.0,
          child: Container(
            height: itemHeight,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (item.icon != null) ...[
                  Icon(
                    item.icon,
                    color: iconColor,
                    size: 24.w,
                  ),
                  SizedBox(width: 12.w),
                ],
                Expanded(
                  child: Text(
                    item.title,
                    style: AppTextStyle.poppinMedium600(
                      color: item.isDisabled
                          ? AppColors.colors.typography.disabled
                          : textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 显示ActionSheet的静态方法
  static Future<T?> show<T>({
    required List<ActionSheetItem<T>> items,
    String? title,
    String? cancelText,
    double borderRadius = 24.0,
    Color? dividerColor,
    double itemHeight = 56.0,
    TextStyle? titleStyle,
    double spacing = 8.0,
    bool barrierDismissible = true,
  }) {
    return Get.bottomSheet<T>(
      AppActionSheet(
        items: items,
        title: title,
        cancelText: cancelText,
        borderRadius: borderRadius,
        dividerColor: dividerColor,
        itemHeight: itemHeight,
        titleStyle: titleStyle,
        spacing: spacing,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      isDismissible: barrierDismissible,
      enableDrag: true,
      isScrollControlled: true,
    );
  }
}
