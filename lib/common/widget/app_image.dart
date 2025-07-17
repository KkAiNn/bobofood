import 'dart:io';

import 'package:bobofood/common/widget/app_image_preview.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AppImage extends StatelessWidget {
  final String? tag;
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final void Function(String tag)? onTap;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool enablePreview;

  final bool isAsset;
  final bool isLocalFile;

  final bool isTapEffect;

  AppImage({
    super.key,
    required this.imageUrl,
    this.tag,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.onTap,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    bool? isAsset,
    bool? isLocalFile,
    this.enablePreview = true,
    this.isTapEffect = false,
  })  : isAsset = isAsset ?? (!imageUrl.contains('://')),
        isLocalFile = isLocalFile ??
            (imageUrl.startsWith('file://') || File(imageUrl).existsSync());

  String get heroTag => Utils.makeHeroTag(imageUrl);
  Widget _buildImage(BuildContext context) {
    if (isLocalFile) {
      return Image.file(File(imageUrl), width: width, height: height, fit: fit);
    } else if (isAsset) {
      return Image.asset(imageUrl, width: width, height: height, fit: fit);
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => placeholder ?? const SizedBox.shrink(),
        errorWidget: (context, url, error) =>
            errorWidget ?? const Icon(Icons.broken_image),
      );
    }
  }

  void _previewImage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AppImagePreviewPage(
          tag: tag,
          imageUrl: imageUrl,
          isAsset: isAsset,
          isLocalFile: isLocalFile,
          fit: fit,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageWidget = ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: _buildImage(context),
    );

    return Hero(
      tag: heroTag,
      child: isTapEffect
          ? TapEffect(
              onTap: () {
                if (enablePreview) {
                  return _previewImage(context);
                }
                if (onTap != null) {
                  onTap!(heroTag);
                }
              },
              borderRadius: borderRadius,
              child: imageWidget,
            )
          : imageWidget,
    );
  }
}
