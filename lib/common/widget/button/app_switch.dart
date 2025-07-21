import 'package:bobofood/constants/index.dart';
import 'package:flutter/material.dart';

class AppSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool disabled;
  final Color? activeColor;
  final Color? inactiveThumbColor;
  final Color? trackColor;
  final double scale;

  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.disabled = false,
    this.activeColor,
    this.inactiveThumbColor,
    this.trackColor,
    this.scale = 1.0,
  });

  Color _getTrackColor() {
    if (disabled) {
      return AppColors.colors.background.disabled;
    }
    if (value) {
      return AppColors.colors.background.primary;
    } else {
      return AppColors.colors.background.elementBackground;
    }
  }

  Color _getThumbColor() {
    if (disabled) {
      return AppColors.colors.icon.disabled;
    }
    if (value) {
      return AppColors.colors.icon.white;
    } else {
      return AppColors.colors.icon.light;
    }
  }

  Color? _getOutlineColor() {
    if (value) {
      return null;
    } else {
      return AppColors.colors.bordersAndSeparators.defaultColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 28.h,
        width: 52.w,
        child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Switch(
              padding: EdgeInsets.zero,
              value: value,
              onChanged: disabled ? null : onChanged,
              activeColor: _getThumbColor(),
              activeTrackColor: _getTrackColor(),
              inactiveThumbColor: _getThumbColor(),
              inactiveTrackColor: _getTrackColor(),
              trackOutlineColor: WidgetStateProperty.all(_getOutlineColor()),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            )));
  }
}
