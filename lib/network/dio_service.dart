import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'env_config.dart';
import 'app_interceptors.dart';

class DioService {
  static final DioService _instance = DioService._internal();
  factory DioService() => _instance;

  late Dio dio;

  DioService._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: EnvConfig.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        contentType: 'application/json',
      ),
    );

    // 注册拦截器
    dio.interceptors.addAll([
      AppInterceptors.authInterceptor(),
      AppInterceptors.errorInterceptor(),
      AppInterceptors.logInterceptor(),
    ]);
  }

  // 网络可用性检测
  Future<bool> isNetworkAvailable() async {
    final result = await Connectivity().checkConnectivity();
    return result[0] != ConnectivityResult.none;
  }

  // 封装 GET
  Future<Response> get(String path, {Map<String, dynamic>? params}) async {
    if (!await isNetworkAvailable()) throw Exception('无网络连接');
    return dio.get(path, queryParameters: params);
  }

  // 封装 POST
  Future<Response> post(String path, {dynamic data}) async {
    if (!await isNetworkAvailable()) throw Exception('无网络连接');
    return dio.post(path, data: data);
  }

  // 下载文件
  Future<void> downloadFile(
    String url,
    String savePath, {
    Function(int, int)? onReceiveProgress,
  }) async {
    await dio.download(url, savePath, onReceiveProgress: onReceiveProgress);
  }
}
