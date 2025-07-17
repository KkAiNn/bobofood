import 'package:bobofood/common/widget/app_svg.dart';
import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/constants/colors.dart';
import 'package:bobofood/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCheckbox extends StatefulWidget {
  const AppCheckbox(
      {super.key,
      required this.value,
      required this.onChanged,
      this.isDisabled = false,
      this.label});

  final bool value;
  final Function(bool) onChanged;
  final String? label;
  final bool isDisabled;

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  Widget _buildCheckbox() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: 24.w,
      height: 24.h,
      decoration: BoxDecoration(
        color: widget.isDisabled
            ? AppColors.colors.background.disabled
            : widget.value
                ? null
                : AppColors.colors.background.layer1Background,
        gradient: !widget.isDisabled && widget.value
            ? AppColors.gradient.linear
            : null,
        borderRadius: BorderRadius.circular(4.r),
        border: widget.isDisabled
            ? null
            : Border.all(
                color: AppColors.colors.bordersAndSeparators.defaultColor),
      ),
      child: widget.value
          ? Center(
              child: AppSvg(
                path: 'assets/icons/Vector.svg',
                width: 10.w,
                height: 10.h,
                color: AppColors.colors.typography.white,
              ),
            )
          : null,
    );
  }

  Widget _buildLabel() {
    return AppText(widget.label ?? '',
        style: AppTextStyle.poppinMedium400(
            color: AppColors.colors.typography.paragraph));
  }

  Widget _buildCheckboxWithLabel() {
    return Row(
      spacing: 16.w,
      children: [
        _buildCheckbox(),
        _buildLabel(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return TapEffect(
        onTap: () {
          if (widget.isDisabled) return;
          widget.onChanged(!widget.value);
        },
        child: _buildCheckboxWithLabel());
  }
}
