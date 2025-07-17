import 'dart:io';
import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../services/storage_services.dart';
import 'dio_service.dart';

class UploadService {
  final Dio _dio = DioService().dio;

  /// 单文件上传
  // await UploadService().uploadFile(
  //   path: '/upload',
  //   file: File('xxx.jpg'),
  //   onProgress: (sent, total) {
  //    print("上传进度: ${(sent / total * 100).toStringAsFixed(2)}%");
  //  },
  // );
  Future<Response> uploadFile({
    required String path,
    required File file,
    Map<String, dynamic>? data,
    Function(int, int)? onProgress,
  }) async {
    final fileName = file.path.split('/').last;
    final formData = FormData.fromMap({
      ...?data,
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });

    return _dio.post(path, data: formData, onSendProgress: onProgress);
  }

  /// 多文件上传
  // await uploader.uploadMultipleFiles(
  // path: '/upload/multi',
  // files: [File('a.jpg'), File('b.jpg')],
  // );
  Future<Response> uploadMultipleFiles({
    required String path,
    required List<File> files,
    Map<String, dynamic>? data,
    Function(int, int)? onProgress,
  }) async {
    final fileList = await Future.wait(
      files.map((file) async {
        final fileName = file.path.split('/').last;
        return await MultipartFile.fromFile(file.path, filename: fileName);
      }),
    );

    final formData = FormData.fromMap({...?data, 'files': fileList});

    return _dio.post(path, data: formData, onSendProgress: onProgress);
  }

  /// 分片上传（后端需支持）
  // await uploader.chunkedUpload(
  // path: '/upload/chunk',
  // file: File('big.zip'),
  // );
  Future<void> chunkedUpload({
    required String path,
    required File file,
    int chunkSize = 1024 * 1024, // 默认 1MB
    Map<String, dynamic>? data,
    Function(int sent, int total)? onChunkProgress,
  }) async {
    final totalSize = file.lengthSync();
    final totalChunks = (totalSize / chunkSize).ceil();
    final raf = file.openSync();

    for (int i = 0; i < totalChunks; i++) {
      final start = i * chunkSize;
      final end = ((i + 1) * chunkSize).clamp(0, totalSize);
      final size = end - start;

      raf.setPositionSync(start);
      final bytes = raf.readSync(size);

      final formData = FormData.fromMap({
        ...?data,
        'chunkIndex': i,
        'totalChunks': totalChunks,
        'file': MultipartFile.fromBytes(
          bytes,
          filename: file.path.split('/').last,
        ),
      });

      await _dio.post(path, data: formData);
      onChunkProgress?.call(i + 1, totalChunks);
    }

    raf.closeSync();
  }

  /// 加密上传（AES，后端需配合解密）
  // await uploader.uploadEncryptedFile(
  // path: '/upload/secure',
  // file: File('secret.pdf'),
  // secretKey: '1234567890abcdef1234567890abcdef',
  // );
  Future<Response> uploadEncryptedFile({
    required String path,
    required File file,
    required String secretKey, // 长度应为 16/24/32 字节
    Map<String, dynamic>? data,
    Function(int, int)? onProgress,
  }) async {
    final plainBytes = await file.readAsBytes();

    final key = encrypt.Key.fromUtf8(secretKey);
    final iv = encrypt.IV.fromLength(16); // 默认 IV，可调整
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encryptBytes(plainBytes, iv: iv);

    final formData = FormData.fromMap({
      ...?data,
      'file': MultipartFile.fromBytes(
        encrypted.bytes,
        filename: '${file.path.split('/').last}.enc',
      ),
    });

    return _dio.post(path, data: formData, onSendProgress: onProgress);
  }

  /// 压缩图片后上传
  Future<Response> uploadCompressedImage({
    required String path,
    required File file,
    int quality = 80,
    Map<String, dynamic>? data,
    Function(int, int)? onProgress,
  }) async {
    final tempDir = await getTemporaryDirectory();
    final targetPath = p.join(
      tempDir.path,
      '${DateTime.now().millisecondsSinceEpoch}.jpg',
    );

    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: quality,
    );

    if (result == null) throw Exception("图片压缩失败");

    return uploadFile(
      path: path,
      file: File(result.path),
      data: data,
      onProgress: onProgress,
    );
  }

  /// 分片上传 + 本地记录已上传的 chunkIndex
  Future<void> chunkedUploadWithCheckpoint({
    required String path,
    required File file,
    int chunkSize = 1024 * 1024,
    Map<String, dynamic>? data,
    required String uploadId, // 唯一上传标识符
    Function(int, int)? onChunkProgress,
  }) async {
    final totalSize = file.lengthSync();
    final totalChunks = (totalSize / chunkSize).ceil();
    final raf = file.openSync();

    final List<String> uploadedChunks = AppStorage.uplaod.get(
      'upload_$uploadId',
      defaultValue: [],
    );

    for (int i = 0; i < totalChunks; i++) {
      if (uploadedChunks.contains(i.toString())) continue; // 已上传跳过

      final start = i * chunkSize;
      final end = ((i + 1) * chunkSize).clamp(0, totalSize);
      final size = end - start;

      raf.setPositionSync(start);
      final bytes = raf.readSync(size);

      final formData = FormData.fromMap({
        ...?data,
        'chunkIndex': i,
        'totalChunks': totalChunks,
        'uploadId': uploadId,
        'file': MultipartFile.fromBytes(
          bytes,
          filename: file.path.split('/').last,
        ),
      });

      await _dio.post(path, data: formData);
      uploadedChunks.add(i.toString());
      AppStorage.uplaod.put('upload_$uploadId', uploadedChunks);

      onChunkProgress?.call(i + 1, totalChunks);
    }

    raf.closeSync();
    await AppStorage.uplaod.delete('upload_$uploadId'); // 上传完成后清理记录
  }

  Future<void> cacheUploadResult(String key, String value) async {
    await AppStorage.uplaod.put('upload_result_$key', value);
  }

  Future<String?> getCachedUploadResult(String key) async {
    return AppStorage.uplaod.get('upload_result_$key');
  }
}
