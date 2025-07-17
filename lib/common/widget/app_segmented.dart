import 'package:bobofood/common/widget/app_badge.dart';
import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/constants/colors.dart';
import 'package:bobofood/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSegmentedItem {
  final String value;
  final String label;
  final bool showDot;

  AppSegmentedItem({
    required this.value,
    required this.label,
    this.showDot = false,
  });

  AppSegmentedItem copyWith({
    bool? showDot,
  }) =>
      AppSegmentedItem(
        value: value,
        label: label,
        showDot: showDot ?? this.showDot,
      );
}

class AppSegmentedControl extends StatelessWidget {
  final List<AppSegmentedItem> items;
  final AppSegmentedItem selectedValue;
  final void Function(AppSegmentedItem) onValueChanged;
  final String Function(AppSegmentedItem)? labelBuilder;
  final double height;
  final double? borderRadius;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? backgroundColor;

  const AppSegmentedControl({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onValueChanged,
    this.labelBuilder,
    this.height = 43,
    this.borderRadius,
    this.selectedColor,
    this.unselectedColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final selectedIndex =
        items.indexWhere((e) => e.value == selectedValue.value);

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth / items.length;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.5.h),
          height: 50.h,
          decoration: BoxDecoration(
            color:
                backgroundColor ?? AppColors.colors.background.layer2Background,
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              // 滑块背景
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                left: selectedIndex * itemWidth,
                width: itemWidth,
                height: 43.h,
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedColor ??
                        AppColors.colors.background.elementBackground,
                    borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                  ),
                ),
              ),
              // 文字区域
              Row(
                spacing: 4.w,
                children: items.map((e) {
                  final isSelected = e == selectedValue;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => onValueChanged(e),
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        alignment: Alignment.center,
                        child: AppBadge(
                          show: e.showDot,
                          top: -4.h,
                          right: -10.w,
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 150),
                            style: AppTextStyle.poppinMedium(
                              color: isSelected
                                  ? AppColors.colors.typography.heading
                                  : unselectedColor ??
                                      AppColors.colors.typography.inactive,
                            ),
                            child: AppText(labelBuilder?.call(e) ?? e.label),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        );
      },
    );
  }
}
