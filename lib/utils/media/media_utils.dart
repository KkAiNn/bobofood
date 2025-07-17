import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bobofood/utils/logger.dart';
import 'package:bobofood/utils/permission/permission.dart';
import 'package:dio/dio.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:video_compress/video_compress.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

enum MediaType { image, video, file }

class MediaUtils {
  static final Set<String> _imageExtensions = {
    'jpg',
    'jpeg',
    'png',
    'gif',
    'bmp',
    'webp',
    'heic',
    'heif',
  };
  static final Set<String> _videoExtensions = {
    'mp4',
    'mov',
    'avi',
    'mkv',
    'flv',
    'wmv',
    'webm',
    'mpeg',
    '3gp',
  };

  static const List<String> documentExtensions = [
    'pdf',
    'doc',
    'docx',
    'xls',
    'xlsx',
    'ppt',
    'pptx',
    'txt',
    'zip',
    'rar',
    '7z',
    'csv',
    'json',
    'xml',
    'yaml',
    'log',
  ];
  static const Map<String, String> albumNameMap = {
    'Camera': '相机',
    'Screenshots': '截图',
    'WeChat': '微信图片',
    'Download': '下载',
  };
  static MediaType getMediaTypeByPath(String path) {
    final ext = _getFileExtension(path);
    if (ext.isEmpty) return MediaType.file;

    if (_imageExtensions.contains(ext)) return MediaType.image;
    if (_videoExtensions.contains(ext)) return MediaType.video;

    return MediaType.file;
  }

  static MediaType getMediaTypeByFileInfo(FileInfo fileInfo) {
    if (fileInfo.path == null) return MediaType.file;
    return getMediaTypeByPath(fileInfo.path!);
  }

  static String _getFileExtension(String path) {
    final index = path.lastIndexOf('.');
    if (index == -1 || index == path.length - 1) return '';
    return path.substring(index + 1).toLowerCase();
  }

  static String pathNameBuilder(AssetPathEntity path) {
    if (path.isAll) return '最近';
    return albumNameMap[path.name] ?? path.name;
  }

  // region 图片相关

  static Future<CapturePngResult?> capturePng(
    GlobalKey key, {
    String? name,
  }) async {
    try {
      final context = key.currentContext;
      if (context == null) return null;
      final boundary = context.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return null;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final uint8 = byteData?.buffer.asUint8List();
      if (uint8 == null) return null;
      final path = await saveImageToTemp(uint8, name: name);
      return CapturePngResult(uint8: uint8, path: path, file: File(path));
    } catch (e) {
      logger.i('capturePng error: $e');
      return null;
    }
  }

  static Future<void> captureAndSaveImage(
    GlobalKey key, {
    String? name,
    int quality = 80,
    Function(String path)? onSuccess,
  }) async {
    final result = await capturePng(key, name: name);
    if (result != null) {
      await saveImage(
        source: result.path,
        name: name,
        quality: quality,
        onSuccess: onSuccess,
      );
    }
  }

  /// 保存图片到系统相册（支持本地路径或网络地址）
  static Future<bool> saveImage({
    required String source,
    String? name,
    int quality = 80,
    Function(String path)? onSuccess,
  }) async {
    // 权限申请
    final status = await PermissionUtils.checkAndRequestStorage();
    if (!status) return false;
    try {
      Uint8List? bytes;

      if (source.startsWith('http')) {
        final response = await Dio().get<List<int>>(
          source,
          options: Options(responseType: ResponseType.bytes),
        );
        bytes = Uint8List.fromList(response.data!);
      } else {
        final file = File(source);
        if (!file.existsSync()) throw 'File not found';
        bytes = await file.readAsBytes();
      }

      final result = await ImageGallerySaverPlus.saveImage(
        bytes,
        quality: quality,
        name: name,
        isReturnImagePathOfIOS: true,
      );

      if (onSuccess != null && result['filePath'] != null) {
        onSuccess(result['filePath']);
      }
      return true;
    } catch (e) {
      logger.i('saveImageToGallery error: $e');
      return false;
    }
  }

  /// 保存图片到本地目录（外部可见）
  static Future<void> saveImageToLocal(Uint8List bytes, {String? name}) async {
    try {
      final dir = await getExternalStorageDirectory();
      if (dir == null) return;
      final path =
          '${dir.path}/${name ?? DateTime.now().millisecondsSinceEpoch}.png';
      await File(path).writeAsBytes(bytes);
      logger.i('图片已保存至: $path');
    } catch (e) {
      logger.i('saveImageToLocal error: $e');
    }
  }

  /// 保存图片到临时目录
  static Future<String> saveImageToTemp(Uint8List bytes, {String? name}) async {
    final dir = await getTemporaryDirectory();
    final path =
        '${dir.path}/${name ?? DateTime.now().millisecondsSinceEpoch}.png';
    await File(path).writeAsBytes(bytes);
    return path;
  }

  static Future<List<String>> getAssetEntityPaths(
    List<AssetEntity> assets,
  ) async {
    final paths = <String>[];
    for (final asset in assets) {
      final file = await asset.file;
      if (file != null) paths.add(file.path);
    }
    return paths;
  }

  static Future<List<File>> getAssetEntityFiles(
    List<AssetEntity> assets,
  ) async {
    final files = <File>[];
    for (final asset in assets) {
      final file = await asset.file;
      if (file != null) files.add(file);
    }
    return files;
  }

  static Future<ImageAsset?> chooseImage({
    int maxAssets = 9,
    List<AssetEntity>? selectedAssets,
  }) async {
    final result = await AssetPicker.pickAssets(
      Get.context!,
      pickerConfig: AssetPickerConfig(
        pathNameBuilder: pathNameBuilder,
        maxAssets: maxAssets,
        selectedAssets: selectedAssets,
        requestType: RequestType.image,
      ),
    );
    if (result == null) return null;
    final files = await getAssetEntityFiles(result);
    return ImageAsset(path: files, asset: result);
  }

  static Future<ImageAsset?> chooseVideo({
    int maxAssets = 1,
    List<AssetEntity>? selectedAssets,
  }) async {
    final result = await AssetPicker.pickAssets(
      Get.context!,
      pickerConfig: AssetPickerConfig(
        pathNameBuilder: pathNameBuilder,
        maxAssets: maxAssets,
        selectedAssets: selectedAssets,
        requestType: RequestType.video,
      ),
    );
    if (result == null) return null;
    final files = await getAssetEntityFiles(result);
    return ImageAsset(path: files, asset: result);
  }

  static Future<File?> chooseImageFromCamera() async {
    final entity = await CameraPicker.pickFromCamera(
      Get.context!,
      pickerConfig: const CameraPickerConfig(
        shouldAutoPreviewVideo: true,
        enableRecording: true,
        shouldDeletePreviewFile: true,
      ),
    );
    if (entity == null) return null;
    final files = await getAssetEntityFiles([entity]);
    return files.isNotEmpty ? files.first : null;
  }

  static String getQiNiuImageThumbUrl(
    String url, {
    double width = 350.0,
    double? height,
    int quality = 75,
    bool webp = true,
  }) {
    final isHasSizeParam = url.contains('?Size=') || url.contains('?size=');
    if (isHasSizeParam) {
      final parts = url.split(RegExp(r'\?(Size|size)=', caseSensitive: false));
      url = parts.first;
    }
    final suffix =
        '?imageView2/0/format${webp ? '/webp' : ''}/q/$quality/w/${width.floor()}';
    return height != null ? '$url$suffix/h/${height.floor()}' : url + suffix;
  }

  // endregion

  // region 视频相关

  static Future<bool> saveVideo(
    String file, {
    String? name,
    bool isReturnPathOfIOS = false,
  }) async {
    try {
      // 权限申请
      final status = await PermissionUtils.checkAndRequestStorage();
      if (!status) return false;
      await ImageGallerySaverPlus.saveFile(
        file,
        name: name,
        isReturnPathOfIOS: true,
      );
      return true;
    } catch (e) {
      logger.i('saveImage error: $e');
      return false;
    }
  }

  static Future<int> getVideoFileSize(String filePath) async {
    final file = File(filePath);
    return await file.exists() ? file.length() : 0;
  }

  // static Future<MediaInfo> getMediaInfo(String filePath) async {
  //   try {
  //     return await VideoCompress.getMediaInfo(filePath);
  //   } catch (e) {
  //     logger.i('getMediaInfo error: $e');
  //     rethrow;
  //   }
  // }

  // static Future<File> getFileThumbnail(String videoPath) async {
  //   return await VideoCompress.getFileThumbnail(
  //     videoPath,
  //     quality: 100,
  //     position: -1,
  //   );
  // }

  // static Future<Uint8List> _downloadSampleVideo() async {
  //   return Uint8List.fromList(List.generate(1024, (i) => i % 256));
  // }

  // endregion

  // region 文件选择

  // static Future<List<FileInfo>?> pickFiles({
  //   bool allowMultiple = false,
  //   List<String>? allowedExtensions = documentExtensions,
  //   bool returnFile = false,
  // }) async {
  //   try {
  //     final result = await FilePicker.platform.pickFiles(
  //       allowMultiple: allowMultiple,
  //       type: allowedExtensions == null ? FileType.any : FileType.custom,
  //       allowedExtensions: allowedExtensions,
  //     );
  //     if (result != null && result.files.isNotEmpty) {
  //       return result.files
  //           .map(
  //             (pf) => FileInfo(
  //               name: pf.name,
  //               path: pf.path,
  //               size: pf.size,
  //               bytes: pf.bytes,
  //             ),
  //           )
  //           .toList();
  //     }
  //   } catch (e) {
  //     logger.i('pickFiles error: $e');
  //   }
  //   return null;
  // }

  // endregion
  // static preview({required List<String> mediaPaths, int initialIndex = 0}) {
  //   Navigator.push(
  //     Get.context!,
  //     MaterialPageRoute(
  //       builder: (_) => AppMediaGalleryPreview(
  //         mediaPaths: mediaPaths,
  //         initialIndex: initialIndex,
  //       ),
  //     ),
  //   );
  // }
}

class FileInfo {
  final String name; // 文件名（含扩展名）
  final String? path; // 文件路径（可能为null，特别是Web环境）
  final int size; // 文件大小（字节）
  final Uint8List? bytes; // 文件内容，非必需

  FileInfo({required this.name, this.path, required this.size, this.bytes});
}

class ImageAsset {
  final List<File> path;
  final List<AssetEntity> asset;
  ImageAsset({required this.path, required this.asset});
}

class CapturePngResult {
  final Uint8List uint8;
  final String path;
  final File file;
  CapturePngResult({
    required this.uint8,
    required this.path,
    required this.file,
  });
}
