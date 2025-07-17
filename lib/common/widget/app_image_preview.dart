import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';

class AppImagePreviewPage extends StatelessWidget {
  final String? tag;
  final String imageUrl;
  final bool isAsset;
  final bool isLocalFile;
  final BoxFit fit;

  const AppImagePreviewPage({
    super.key,
    this.tag,
    required this.imageUrl,
    this.isAsset = false,
    this.isLocalFile = false,
    this.fit = BoxFit.contain,
  });

  Widget _buildImage() {
    if (isAsset) {
      return Image.asset(imageUrl, fit: fit);
    } else if (isLocalFile) {
      return Image.file(File(imageUrl), fit: fit);
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        errorWidget:
            (context, url, error) =>
                const Icon(Icons.broken_image, color: Colors.white),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DismissiblePage(
        onDismissed: () => Navigator.of(context).pop(),
        direction: DismissiblePageDismissDirection.multi,
        child: Center(
          child: Hero(
            tag: tag ?? '',
            child: InteractiveViewer(
              // 限制缩放范围
              maxScale: 2.0,
              minScale: 0.5,
              child: _buildImage(),
            ),
          ),
        ),
      ),
    );
  }
}
