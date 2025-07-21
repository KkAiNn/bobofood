import 'package:bobofood/common/widget/app_svg.dart';
import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/constants/index.dart';
import 'package:flutter/material.dart';

enum CounterButtonType { small, medium, remove }

class AppCounterButton extends StatelessWidget {
  const AppCounterButton(
      {super.key,
      this.type = CounterButtonType.medium,
      this.count = 1,
      this.onTapRemove,
      this.onTapAdd,
      this.onTapDelete,
      this.maxCount});
  final CounterButtonType type;
  final int count;
  final Function? onTapRemove;
  final Function? onTapAdd;
  final Function? onTapDelete;
  final int? maxCount;

  Widget _buildIcon(
    String path,
    double size,
    double iconSize, {
    Function? onTap,
  }) {
    return TapEffect(
        onTap: () => onTap?.call(),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppColors.colors.background.layer2Background,
            borderRadius: BorderRadius.circular(32.r),
          ),
          child: Center(
            child: AppSvg(
              path: path,
              width: iconSize,
              height: iconSize,
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    double size = 40.w;
    double iconSize = 20.w;
    if (type != CounterButtonType.medium) {
      size = 32.w;
      iconSize = 16.w;
    }

    Widget leftIcon = _buildIcon('assets/icons/Remove.svg', size, iconSize,
        onTap: onTapRemove);
    Widget rightIcon =
        _buildIcon('assets/icons/Add.svg', size, iconSize, onTap: () {
      if (maxCount != null && count >= maxCount!) {
        return;
      }
      onTapAdd?.call();
    });
    if (type == CounterButtonType.remove) {
      leftIcon = _buildIcon('assets/icons/Delete.svg', size, iconSize,
          onTap: onTapDelete);
    }

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.colors.background.elementBackground,
        borderRadius: BorderRadius.circular(32.r),
        border: type == CounterButtonType.medium
            ? Border.all(
                color: AppColors.colors.bordersAndSeparators.defaultColor,
              )
            : null,
      ),
      child: Row(
        spacing: 12.w,
        children: [
          leftIcon,
          AppText(count.toString(),
              style: AppTextStyle.robotoMedium(
                  color: AppColors.colors.typography.paragraph)),
          rightIcon,
        ],
      ),
    );
  }
}
