import 'package:bobofood/common/widget/app_svg.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/constants/index.dart';
import 'package:flutter/material.dart';

enum AppActionIconType { filled, light, normal, danger, transparent, disabled }

class AppActionIcon extends StatelessWidget {
  const AppActionIcon(
      {super.key,
      this.icon,
      this.type = AppActionIconType.normal,
      required this.onTap,
      this.rounded = false,
      this.size});

  final String? icon;
  final AppActionIconType type;
  final VoidCallback onTap;
  final bool rounded;
  final double? size;

  @override
  Widget build(BuildContext context) {
    Color? color = AppColors.colors.typography.heading;
    LinearGradient? gradient;
    Color? iconColor = AppColors.colors.icon.white;

    if (type == AppActionIconType.filled) {
      gradient = AppColors.gradient.linear;
      color = null;
    } else if (type == AppActionIconType.light) {
      color = AppColors.colors.background.secondary;
      iconColor = AppColors.colors.icon.primary;
    } else if (type == AppActionIconType.normal) {
      color = AppColors.colors.background.elementBackground;
      iconColor = AppColors.colors.icon.defaultColor;
    } else if (type == AppActionIconType.danger) {
      color = AppColors.colors.background.danger;
    } else if (type == AppActionIconType.transparent) {
      color = AppColors.colors.background.elementBackground;
      iconColor = AppColors.colors.icon.primary;
    } else if (type == AppActionIconType.disabled) {
      color = AppColors.colors.background.disabled;
      iconColor = AppColors.colors.icon.disabled;
    }
    return TapEffect(
      onTap: onTap,
      child: Container(
        width: size ?? 40.w,
        height: size ?? 40.w,
        decoration: BoxDecoration(
          gradient: gradient,
          color: color,
          borderRadius: rounded
              ? BorderRadius.circular(100.r)
              : BorderRadius.circular(8.r),
          border: type == AppActionIconType.normal
              ? Border.all(
                  color: AppColors.colors.bordersAndSeparators.defaultColor,
                  width: 1.w,
                )
              : null,
        ),
        child: Center(
          child: AppSvg(
            path: icon ?? 'assets/icons/Add.svg',
            width: 20.w,
            height: 20.w,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
