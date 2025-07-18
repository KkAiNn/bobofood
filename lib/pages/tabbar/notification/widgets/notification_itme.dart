import 'package:bobofood/common/model/notification.dart';
import 'package:bobofood/common/widget/app_svg.dart';
import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/constants/colors.dart';
import 'package:bobofood/constants/text_style.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationItme extends StatelessWidget {
  const NotificationItme({super.key, required this.notification});

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.w,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(32.w),
          child: Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: AppColors.colors.background.layer2Background,
              ),
              child: Center(
                child: AppSvg(
                  path: "assets/icons/Logo.svg",
                  width: 32.w,
                  height: 32.w,
                  color: AppColors.colors.icon.primary,
                ),
              )),
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(notification.title,
                style: AppTextStyle.poppinMedium600(
                    color: AppColors.colors.typography.heading)),
            AppText(notification.description,
                style: AppTextStyle.poppinSmall400(
                    color: AppColors.colors.typography.paragraph)),
            SizedBox(height: 4.h),
            AppText(notification.time,
                style: AppTextStyle.poppinSmall600(
                    color: AppColors.colors.typography.paragraph)),
          ],
        ))
      ],
    );
  }
}
