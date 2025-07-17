import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/constants/colors.dart';
import 'package:bobofood/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLink extends StatelessWidget {
  const AppLink({super.key, required this.title, required this.onTap});
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TapEffect(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.colors.bordersAndSeparators.link,
              width: 2.w,
            ),
          ),
        ),
        child: AppText(
          title,
          style: AppTextStyle.poppinSmall600(
              color: AppColors.colors.typography.heading),
        ),
      ),
    );
  }
}
