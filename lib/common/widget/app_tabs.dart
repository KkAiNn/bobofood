import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/constants/colors.dart';
import 'package:bobofood/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTabs<T> extends StatefulWidget {
  const AppTabs(
      {super.key,
      required this.tabs,
      required this.onTap,
      required this.currentTab,
      this.itemToString});
  final List<T> tabs;
  final Function(T) onTap;
  final T currentTab;

  final String Function(T)? itemToString;

  @override
  State<AppTabs<T>> createState() => _AppTabsState<T>();
}

class _AppTabsState<T> extends State<AppTabs<T>> {
  Widget _buildTabsItem(T tab) {
    final itemString = widget.itemToString?.call(tab) ?? tab.toString();
    final isSelected = tab == widget.currentTab;
    return TapEffect(
        onTap: () {
          widget.onTap(tab);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.colors.background.secondary
                : AppColors.colors.background.elementBackground,
            borderRadius: BorderRadius.circular(12.r),
            border: isSelected
                ? Border.all(
                    color: AppColors.colors.background.secondary,
                    width: 1.w,
                  )
                : Border.all(
                    color: AppColors.colors.bordersAndSeparators.defaultColor,
                    width: 1.w,
                  ),
          ),
          child: Center(
            child: AppText(
              itemString,
              style: isSelected
                  ? AppTextStyle.poppinMedium600(
                      color: AppColors.colors.typography.heading,
                    )
                  : AppTextStyle.poppinMedium400(
                      color: AppColors.colors.typography.lightGrey,
                    ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 8.w,
        children: [
          ...widget.tabs.map((tab) => _buildTabsItem(tab)),
          SizedBox(
            width: 12.w,
          )
        ],
      ),
    );
  }
}
