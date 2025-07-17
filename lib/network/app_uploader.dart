import 'dart:io';
import 'package:dio/dio.dart';

import 'upload_service.dart';

enum UploadStrategy {
  normal,
  multiple,
  compressedImage,
  chunked,
  chunkedWithCheckpoint,
  encrypted,
}

class AppUploader {
  final _uploadService = UploadService();

  /// 统一上传接口
  Future<Response?> upload({
    required UploadStrategy strategy,
    required String path,
    File? file,                  // 单文件
    List<File>? files,           // 多文件
    String? secretKey,           // 加密密钥
    String? uploadId,            // 分片唯一标识
    Map<String, dynamic>? data,  // 额外参数
    Function(int, int)? onProgress,
    Function(int, int)? onChunkProgress,
  }) async {
    switch (strategy) {
      case UploadStrategy.normal:
        if (file == null) throw Exception("file is required for normal upload");
        return _uploadService.uploadFile(
          path: path,
          file: file,
          data: data,
          onProgress: onProgress,
        );

      case UploadStrategy.multiple:
        if (files == null || files.isEmpty) throw Exception("files are required for multiple upload");
        return _uploadService.uploadMultipleFiles(
          path: path,
          files: files,
          data: data,
          onProgress: onProgress,
        );

      case UploadStrategy.compressedImage:
        if (file == null) throw Exception("file is required for image compression");
        return _uploadService.uploadCompressedImage(
          path: path,
          file: file,
          data: data,
          onProgress: onProgress,
        );

      case UploadStrategy.chunked:
        if (file == null) throw Exception("file is required for chunked upload");
        await _uploadService.chunkedUpload(
          path: path,
          file: file,
          data: data,
          onChunkProgress: onChunkProgress,
        );
        return null;

      case UploadStrategy.chunkedWithCheckpoint:
        if (file == null || uploadId == null) {
          throw Exception("file and uploadId are required for checkpointed chunked upload");
        }
        await _uploadService.chunkedUploadWithCheckpoint(
          path: path,
          file: file,
          data: data,
          uploadId: uploadId,
          onChunkProgress: onChunkProgress,
        );
        return null;

      case UploadStrategy.encrypted:
        if (file == null || secretKey == null) {
          throw Exception("file and secretKey are required for encrypted upload");
        }
        return _uploadService.uploadEncryptedFile(
          path: path,
          file: file,
          secretKey: secretKey,
          data: data,
          onProgress: onProgress,
        );
    }
  }

  /// 缓存上传结果
  Future<void> cacheResult(String key, String value) {
    return _uploadService.cacheUploadResult(key, value);
  }

  Future<String?> getCachedResult(String key) {
    return _uploadService.getCachedUploadResult(key);
  }
}
