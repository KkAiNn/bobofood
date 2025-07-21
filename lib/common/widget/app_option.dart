import 'package:bobofood/common/widget/app_svg.dart';
import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/button/app_switch.dart';
import 'package:bobofood/common/widget/form/app_radio.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/constants/index.dart';
import 'package:flutter/material.dart';

enum AppOptionType {
  option,
  toggle,
  radioButton,
}

class AppOption extends StatelessWidget {
  const AppOption(
      {super.key,
      this.type = AppOptionType.option,
      this.svgPath,
      this.iconColor,
      required this.text,
      this.header,
      this.subText,
      this.right,
      this.onTap,
      this.inActive = false,
      this.isDisabled = false});

  final AppOptionType type;
  final String? svgPath;
  final Color? iconColor;
  final String text;
  final String? header;
  final String? subText;
  final Widget? right;

  final bool inActive;
  final bool isDisabled;

  final Function()? onTap;
  Widget buildLeft() {
    Color? iconcolor = iconColor ?? AppColors.colors.icon.defaultColor;
    Color? textColor = AppColors.colors.typography.heading;
    if (isDisabled || inActive) {
      iconcolor = AppColors.colors.icon.light;
      textColor = AppColors.colors.typography.inactive;
    }
    Widget optionName;

    if (header != null) {
      optionName = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(header!,
              style: AppTextStyle.poppinSmall400(
                  color: AppColors.colors.typography.paragraph)),
          AppText(text, style: AppTextStyle.poppinMedium400(color: textColor))
        ],
      );
    } else {
      optionName =
          AppText(text, style: AppTextStyle.poppinMedium400(color: textColor));
    }
    if (svgPath != null) {
      return Row(
        spacing: 12.w,
        children: [
          AppSvg(path: svgPath!, width: 24.w, height: 24.w, color: iconcolor),
          optionName,
        ],
      );
    }

    return optionName;
  }

  Widget buildSubText() {
    var icon = AppSvg(
      path: 'assets/icons/Arrow right.svg',
      width: 24.w,
      height: 24.w,
      color: AppColors.colors.icon.light,
    );
    if (subText != null) {
      return Row(
        spacing: 0.w,
        children: [
          Transform.translate(
            offset: Offset(8.w, 0),
            child: AppText(subText!,
                style: AppTextStyle.poppinMedium400(
                    color: AppColors.colors.typography.paragraph)),
          ),
          icon,
        ],
      );
    }
    return icon;
  }

  Widget buildRadioButton() {
    return AppSvg(
      path: 'assets/icons/Radio button.svg',
      width: 24.w,
      height: 24.w,
      color: AppColors.colors.icon.light,
    );
  }

  Widget buildRight() {
    if (right != null) {
      return right!;
    }
    return buildSubText();
  }

  @override
  Widget build(BuildContext context) {
    return TapEffect(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.colors.background.layer1Background,
            borderRadius: BorderRadius.circular(8.w),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: buildLeft()),
              buildRight(),
            ],
          ),
        ));
  }

  static Widget toggle({
    String? svgPath,
    required String text,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return AppOption(
      type: AppOptionType.toggle,
      svgPath: svgPath,
      text: text,
      right: AppSwitch(value: value, onChanged: onChanged),
    );
  }

  static Widget radio({
    String? svgPath,
    required String text,
    required bool value,
    String? header,
    required Function(bool) onChanged,
    bool enabled = true,
  }) {
    return AppOption(
      type: AppOptionType.toggle,
      svgPath: svgPath,
      text: text,
      header: header,
      onTap: () {
        onChanged(!value);
      },
      right: AppRadio(
        value: value,
        onChanged: onChanged,
        enabled: enabled,
      ),
    );
  }
}
