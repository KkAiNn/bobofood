import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorHandler {
  static void handle(DioException e) {
    final context = Get.context;
    if (context == null) return;

    final message = switch (e.type) {
      DioExceptionType.connectionTimeout => '连接超时',
      DioExceptionType.receiveTimeout => '接收超时',
      DioExceptionType.badResponse => '服务器错误 ${e.response?.statusCode}',
      _ => '网络异常，请重试',
    };

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('请求错误'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('确定'),
              ),
            ],
          ),
    );
  }
}
