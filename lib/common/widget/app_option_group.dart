import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/constants/colors.dart';
import 'package:bobofood/constants/text_style.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppOptionGroup extends StatelessWidget {
  const AppOptionGroup({super.key, required this.title, required this.options});
  final String title;
  final List<Widget> options;

  @override
  Widget build(BuildContext context) {
    return Column(
        spacing: 16.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: AppText(
              title,
              style: AppTextStyle.poppinSmall600(
                  color: AppColors.colors.typography.lightGrey),
            ),
          ),
          ...options,
        ]);
  }
}
