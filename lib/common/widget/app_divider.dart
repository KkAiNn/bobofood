import 'package:bobofood/constants/index.dart';
import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key, this.height, this.color});

  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height ?? 1.h,
      color: color ?? AppColors.colors.bordersAndSeparators.defaultColor,
    );
  }
}
