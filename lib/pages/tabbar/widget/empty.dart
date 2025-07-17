import 'package:bobofood/common/widget/app_image.dart';
import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/button/app_button.dart';
import 'package:bobofood/constants/colors.dart';
import 'package:bobofood/constants/constants.dart';
import 'package:bobofood/constants/text_style.dart';
import 'package:bobofood/pages/main/controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget(
      {super.key,
      required this.title,
      this.description = '',
      this.buttonText = '',
      this.onButtonTap});

  final String title;
  final String description;
  final String buttonText;
  final VoidCallback? onButtonTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppImage(
            imageUrl: AppConstants.emptyImg,
            width: 200.w,
            height: 200.h,
          ),
          if (title.isNotEmpty) ...[
            SizedBox(height: 24.h),
            AppText(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyle.poppinsHeading1(
                  color: AppColors.colors.typography.heading),
            )
          ],
          if (description.isNotEmpty) ...[
            SizedBox(height: 12.h),
            AppText(
              description,
              textAlign: TextAlign.center,
              style: AppTextStyle.poppinMedium(
                  color: AppColors.colors.typography.paragraph),
            )
          ],
          if (buttonText.isNotEmpty) ...[
            SizedBox(height: 20.h),
            AppButton(
              text: buttonText,
              width: 102.w,
              size: AppButtonSize.small,
              onTap: onButtonTap,
            )
          ],
        ],
      ),
    );
  }

  static void toHome({int index = 0}) {
    Get.find<MainController>().jumpToPageWithIndex(index);
  }
}
