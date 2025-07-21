import 'package:bobofood/common/widget/app_svg.dart';
import 'package:bobofood/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:get/get.dart';

class AppNavBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? leadingWidgets;
  final List<Widget>? trailingWidgets;
  final Widget? title;
  final String? titleText;
  final String? subtitleText;
  final bool automaticallyImplyLeading;
  final Color? backgroundColor;
  final double elevation;
  final double height;
  final bool showShadow;
  final double spacing;
  final bool safeTop;
  final double sideMaxWidth;
  final bool titleCenter;

  const AppNavBar({
    super.key,
    this.leadingWidgets,
    this.trailingWidgets,
    this.title,
    this.titleText,
    this.subtitleText,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.elevation = 0,
    this.height = kToolbarHeight,
    this.showShadow = true,
    this.spacing = 0,
    this.safeTop = true,
    this.sideMaxWidth = 58,
    this.titleCenter = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(
        height + (safeTop ? MediaQuery.of(Get.context!).padding.top : 0),
      );

  static final TextStyle textStyle =
      AppTextStyle.poppinMedium700(color: AppColors.typography.typography500);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = backgroundColor ??
        theme.appBarTheme.backgroundColor ??
        theme.scaffoldBackgroundColor;
    final textColor = theme.appBarTheme.titleTextStyle?.color ??
        theme.textTheme.titleLarge?.color ??
        Colors.black;

    final List<Widget> leadingList = leadingWidgets ?? [];
    final List<Widget> trailingList = trailingWidgets ?? [];

    // 自动添加返回按钮
    if (automaticallyImplyLeading &&
        leadingWidgets == null &&
        Navigator.of(context).canPop()) {
      leadingList.insert(
        0,
        backButton(),
      );
    }

    return Material(
      color: bgColor,
      elevation: showShadow ? elevation : 0,
      child: SafeArea(
        top: safeTop,
        bottom: false,
        child: Container(
          height: height,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              SizedBox(
                width: sideMaxWidth.w,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: leadingList
                      .map(
                        (w) => Padding(
                          padding: EdgeInsets.only(right: spacing),
                          child: w,
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: title ??
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: titleCenter
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      children: [
                        if (titleText != null)
                          AppText(
                            titleText!,
                            style: AppTextStyle.poppinLarge(
                                color: AppColors.typography.typography500),
                          ),
                        if (subtitleText != null)
                          AppText(
                            subtitleText!,
                            color: textColor.withValues(alpha: 0.7),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14.sp,
                          ),
                      ],
                    ),
              ),
              SizedBox(width: 8.w),
              SizedBox(
                width: sideMaxWidth.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: trailingList
                      .map(
                        (w) => Padding(
                          padding: EdgeInsets.only(left: spacing),
                          child: w,
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static AppNavBar logo({bool showSkip = false, VoidCallback? onSkip}) {
    return AppNavBar(
      sideMaxWidth: 58,
      spacing: 0,
      title: Image.asset(
        AppConstants.appLogo,
        width: 70.w,
        height: 24.w,
      ),
      leadingWidgets: [backButton()],
      trailingWidgets: showSkip ? [skipButton(onSkip: onSkip)] : [],
    );
  }

  static AppNavBar navigationTab(
      {String? title, String? icon, List<Widget>? trailingWidgets}) {
    return AppNavBar(
        automaticallyImplyLeading: false,
        title: Row(
          spacing: 0,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppSvg(
              path: icon ?? 'assets/icons/Cart tilted.svg',
              width: 24.w,
              height: 24.w,
            ),
            SizedBox(width: 4.w),
            Text(title ?? 'Label', style: textStyle),
          ],
        ),
        trailingWidgets: trailingWidgets
        // ?? [
        //   TapEffect(
        //     child: AppSvg(
        //       path: icon ?? 'assets/icons/More.svg',
        //       width: 24.w,
        //       height: 24.w,
        //     ),
        //   )
        // ],
        );
  }

  static AppNavBar productDetail(
      {bool like = false, VoidCallback? onLike, VoidCallback? onShare}) {
    return AppNavBar(
      sideMaxWidth: 120.w,
      spacing: 0,
      leadingWidgets: [backButton()],
      trailingWidgets: [
        TapEffect(
          onTap: onShare,
          child: AppSvg(
            path: 'assets/icons/Share.svg',
            width: 24.w,
            height: 24.w,
          ),
        ),
        SizedBox(width: 20.w),
        TapEffect(
          onTap: onLike,
          child: AppSvg(
            path:
                like ? 'assets/icons/Like filled.svg' : 'assets/icons/Like.svg',
            width: 24.w,
            height: 24.w,
            color: like
                ? AppColors.colors.icon.red
                : AppColors.colors.icon.defaultColor,
          ),
        )
      ],
    );
  }

  static AppNavBar withEditOption({String? title, VoidCallback? onEdit}) {
    return AppNavBar(
      titleText: title ?? 'Edit',
      spacing: 0,
      leadingWidgets: [backButton()],
      trailingWidgets: [
        TapEffect(
          onTap: onEdit,
          child: AppText('Edit',
              style: AppTextStyle.poppinMedium700(
                  color: AppColors.colors.typography.primary700)),
        )
      ],
    );
  }

  static AppNavBar editingSaveAndCancel(
      {String? title, VoidCallback? onSave, VoidCallback? onCancel}) {
    return AppNavBar(
      sideMaxWidth: 58.w,
      titleText: title ?? 'Edit',
      spacing: 0,
      leadingWidgets: [
        TapEffect(
          onTap: () {
            if (onCancel != null) {
              onCancel();
            } else {
              Get.back();
            }
          },
          child: AppText('Cancel',
              style: AppTextStyle.poppinMedium700(
                  color: AppColors.colors.typography.paragraph)),
        )
      ],
      trailingWidgets: [
        TapEffect(
          onTap: onSave,
          child: AppText('Save',
              style: AppTextStyle.poppinMedium700(
                  color: AppColors.colors.typography.primary700)),
        )
      ],
    );
  }

  static Widget skipButton({VoidCallback? onSkip}) {
    return TapEffect(
      onTap: onSkip,
      child: SizedBox(
        width: 50.w,
        child: Stack(
          children: [
            Positioned(
              right: 16.w,
              top: 0,
              bottom: 0,
              child: Center(
                child: Text('Skip', style: textStyle),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Image.asset(
                'assets/icons/Arrow right.png',
                width: 24.sp,
                height: 24.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget backButton() {
    if (Navigator.of(Get.context!).canPop()) {
      return TapEffect(
        onTap: () => Get.back(),
        child: SizedBox(
          width: 58.w,
          child: Stack(
            children: [
              AppSvg(
                path: 'assets/icons/Arrow left.svg',
                width: 24.sp,
                height: 24.sp,
                color: AppColors.colors.icon.defaultColor,
              ),
              Positioned(
                left: 16.w,
                top: 0,
                bottom: 0,
                child: Text('Back', style: textStyle),
              ),
            ],
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
