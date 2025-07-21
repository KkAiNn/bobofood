import 'package:bobofood/common/hooks/countdown_controller.dart';
import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/form/custom_verification_code.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/constants/index.dart';
import 'package:flutter/material.dart';

class VerificationWidget extends StatefulWidget {
  const VerificationWidget(
      {super.key,
      required this.countdownController,
      required this.onChanged,
      required this.title,
      this.description = '',
      required this.verificationCodeLength,
      required this.onTapResend});
  final CountdownController countdownController;
  final Function(String) onChanged;
  final String title;
  final String description;
  final int verificationCodeLength;
  final Function() onTapResend;

  @override
  State<VerificationWidget> createState() => _VerificationWidgetState();
}

class _VerificationWidgetState extends State<VerificationWidget> {
  var verificationCode = '';

  @override
  void initState() {
    super.initState();
    widget.countdownController.start();
  }

  @override
  void dispose() {
    widget.countdownController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(VerificationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.verificationCodeLength != widget.verificationCodeLength) {
      widget.countdownController.dispose();
      widget.countdownController.start();
    }
  }

  void onVerificationCodeonChanged(String value) {
    verificationCode = value;
    widget.onChanged(verificationCode);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        alignment: Alignment.centerLeft,
        child: AppText(widget.title,
            style: AppTextStyle.poppinsHeading1(
                color: AppColors.colors.typography.heading)),
      ),
      SizedBox(height: 12.h),
      Container(
        alignment: Alignment.centerLeft,
        child: AppText(widget.description,
            style: AppTextStyle.poppinMedium400(
                color: AppColors.colors.typography.paragraph)),
      ),
      SizedBox(height: 20.h),
      CustomVerificationCode(
        isAutoWidth: true,
        onCompleted: (code) {},
        length: widget.verificationCodeLength,
        onChanged: (code) {
          onVerificationCodeonChanged(code);
        },
        autoFocus: true,
        height: 48.h,
        borderRadius: 12.r,
        textStyle: AppTextStyle.poppinMedium600(
            color: AppColors.colors.typography.heading),
        backgroundColor: AppColors.colors.background.elementBackground,
        borderColor: AppColors.colors.bordersAndSeparators.defaultColor,
        focusedBorderColor: AppColors.colors.bordersAndSeparators.defaultColor,
      ),
      SizedBox(height: 16.h),
      Row(
        spacing: 2.w,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppText(
            'Didn’t received the code?',
            style: AppTextStyle.poppinMedium400(
                color: AppColors.colors.typography.paragraph),
          ),
          AppText('00:${widget.countdownController.secondsLeftString}',
              style: AppTextStyle.poppinMedium(
                  color: AppColors.colors.typography.paragraph)),
          TapEffect(
            onTap: widget.onTapResend,
            child: AppText('Resend',
                isUnderline: true,
                underlineColor: widget.countdownController.isRunning
                    ? AppColors.colors.typography.disabled
                    : AppColors.colors.bordersAndSeparators.link,
                style: AppTextStyle.poppinMedium600(
                    color: widget.countdownController.isRunning
                        ? AppColors.colors.typography.disabled
                        : AppColors.colors.typography.heading)),
          )
        ],
      )
    ]);
  }
}
