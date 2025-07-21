import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/constants/index.dart';
import 'package:flutter/material.dart';

enum AppButtonType {
  primary,
  secondary,
  outline,
  danger,
  transparent,
  disabled,
}

enum AppButtonSize {
  normal,
  small,
}

class AppButton extends StatefulWidget {
  const AppButton(
      {super.key,
      this.type = AppButtonType.primary,
      this.size = AppButtonSize.normal,
      this.text = '',
      this.suffixIcon,
      this.prefixIcon,
      this.onTap,
      this.width,
      this.icon,
      this.isDisabled = false,
      this.height});

  final VoidCallback? onTap;

  final AppButtonType type;
  final AppButtonSize size;
  final String? text;
  final Widget? icon;

  final Widget? suffixIcon;
  final Widget? prefixIcon;

  final double? width;
  final double? height;

  final bool isDisabled;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  late Color? backgroundColor;
  late LinearGradient? backgroundLinearGradient;
  late TextStyle? textStyle;

  @override
  void initState() {
    super.initState();
    _initColorAndTextStyle();
  }

  @override
  void didUpdateWidget(AppButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isDisabled != widget.isDisabled) {
      _initColorAndTextStyle();
    }
  }

  void _initColorAndTextStyle() {
    backgroundLinearGradient = null;
    backgroundColor = null;
    textStyle = null;
    var type = widget.type;
    if (widget.isDisabled) {
      type = AppButtonType.disabled;
    }
    switch (type) {
      case AppButtonType.primary:
        backgroundLinearGradient = LinearGradient(
          colors: [
            AppColors.colors.gradient.light,
            AppColors.colors.gradient.dark,
          ],
        );
        textStyle = AppTextStyle.poppinMedium700(
            color: AppColors.colors.typography.white);
        break;
      case AppButtonType.secondary:
        backgroundColor = AppColors.colors.background.secondary;
        textStyle = AppTextStyle.poppinMedium700(
            color: AppColors.colors.typography.primary);
        break;
      case AppButtonType.outline:
        backgroundColor = AppColors.colors.background.elementBackground;
        textStyle = AppTextStyle.poppinMedium700(
            color: AppColors.colors.typography.heading);
        break;
      case AppButtonType.danger:
        backgroundColor = AppColors.colors.background.danger;
        textStyle = AppTextStyle.poppinMedium700(
            color: AppColors.colors.typography.white);
        break;
      case AppButtonType.transparent:
        textStyle = AppTextStyle.poppinMedium700(
            color: AppColors.colors.typography.primary700);
        break;
      case AppButtonType.disabled:
        backgroundColor = AppColors.colors.background.disabled;
        textStyle = AppTextStyle.poppinMedium700(
            color: AppColors.colors.typography.disabled);
        break;
    }
  }

  Widget _initContainer() {
    double height = 52.h;
    switch (widget.size) {
      case AppButtonSize.normal:
        height = 52.h;
        break;
      case AppButtonSize.small:
        height = 40.h;
        break;
    }
    if (widget.height != null) {
      height = widget.height!;
    }
    return Container(
      height: height,
      width: widget.width,
      decoration: BoxDecoration(
        gradient: backgroundLinearGradient,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        border: widget.type == AppButtonType.outline
            ? Border.all(
                color: AppColors.colors.bordersAndSeparators.defaultColor,
                width: 1.w,
              )
            : null,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.prefixIcon != null) ...[
            widget.prefixIcon!,
            SizedBox(width: 8.w),
          ],
          if (widget.text != null) ...[
            AppText(widget.text!, style: textStyle),
          ],
          if (widget.icon != null) ...[
            widget.icon!,
          ],
          if (widget.suffixIcon != null) ...[
            SizedBox(width: 8.w),
            widget.suffixIcon!,
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TapEffect(
      onTap: widget.isDisabled ? null : widget.onTap,
      child: _initContainer(),
    );
  }
}
