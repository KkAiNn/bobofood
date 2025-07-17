import 'package:bobofood/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSvg extends StatelessWidget {
  const AppSvg(
      {super.key, required this.path, this.width, this.height, this.color});

  final String path;
  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    var defaultColor = AppColors.colors.icon.defaultColor;
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      colorFilter: ColorFilter.mode(
        color ?? defaultColor,
        BlendMode.srcIn,
      ),
    );
  }
}
