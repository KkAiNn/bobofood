import 'package:bobofood/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppIndicator extends StatelessWidget {
  const AppIndicator(
      {super.key, required this.count, required this.currentIndex});

  final int count;
  final int currentIndex;

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) => index)
          .map(
            (index) => AnimatedContainer(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: 12.w,
              height: 12.h,
              decoration: BoxDecoration(
                  color: currentIndex == index
                      ? AppColors.colors.typography.primary
                      : AppColors.colors.background.secondary,
                  borderRadius: BorderRadius.circular(12.r)),
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildIndicator();
  }
}
