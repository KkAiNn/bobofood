import 'package:dio/dio.dart';

import '../services/storage_services.dart';
import 'error_handler.dart';

class AppInterceptors {
  static InterceptorsWrapper authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = AppStorage.auth.get('token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        final int code = response.data['code'];
        if (response.statusCode == 401) {
          AppStorage.auth.delete('token');
        }
        if (code != 200) {
          return handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              error: response.data['msg'],
              response: response,
            ),
          );
        }
        return handler.next(response);
      },
    );
  }

  static LogInterceptor logInterceptor() {
    return LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: false,
      responseHeader: false,
    );
  }

  static InterceptorsWrapper errorInterceptor() {
    return InterceptorsWrapper(
      onError: (e, handler) {
        ErrorHandler.handle(e);
        return handler.next(e);
      },
    );
  }
}
