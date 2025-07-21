import 'package:bobofood/common/widget/app_image.dart';
import 'package:bobofood/common/widget/app_svg.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/constants/index.dart';
import 'package:flutter/material.dart';

enum AvatarSize { xl, lg, md, sm }

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    required this.avatarUrl,
    this.onTap,
    this.isShowCamera = false,
    this.size = AvatarSize.md,
  });
  final String avatarUrl;
  final AvatarSize size;
  final Function()? onTap;
  final bool isShowCamera;
  Widget _buildAvatar() {
    double radius = size == AvatarSize.xl
        ? 60.r
        : size == AvatarSize.lg
            ? 40.r
            : size == AvatarSize.md
                ? 24.r
                : 20.r;
    double width = size == AvatarSize.xl
        ? 120.w
        : size == AvatarSize.lg
            ? 80.w
            : size == AvatarSize.md
                ? 48.w
                : 40.w;
    final avatar = CircleAvatar(
      radius: radius,
      backgroundColor: avatarUrl.isNotEmpty
          ? Colors.transparent
          : AppColors.colors.background.grey,
      child: avatarUrl.isNotEmpty
          ? AppImage(
              imageUrl: avatarUrl,
              fit: BoxFit.cover,
              width: width,
              height: width,
              borderRadius: BorderRadius.circular(radius),
            )
          : Center(
              child: AppSvg(
                path: 'assets/icons/Profile.svg',
                width: 72.w,
                height: 72.w,
                color: AppColors.colors.icon.white,
              ),
            ),
    );
    if (!isShowCamera) {
      return TapEffect(
        onTap: onTap,
        child: avatar,
      );
    }

    return Container(
      alignment: Alignment.center,
      child: TapEffect(
        onTap: onTap,
        child: Stack(
          children: [
            SizedBox(
              width: 140.w,
              height: 140.w,
              child: Center(child: avatar),
            ),
            Positioned(
              right: 0.w,
              bottom: 0.w,
              child: CircleAvatar(
                radius: 24.r,
                backgroundColor: AppColors.colors.background.elementBackground,
                child: CircleAvatar(
                  radius: 18.r,
                  backgroundColor: AppColors.colors.background.layer2Background,
                  child: Center(
                    child: AppSvg(
                      path: 'assets/icons/Camera filled.svg',
                      width: 24.w,
                      height: 24.w,
                      color: AppColors.colors.icon.defaultColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildAvatar();
  }
}
