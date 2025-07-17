import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  /// 检查单个权限是否已授权
  static Future<bool> isGranted(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }

  /// 请求单个权限，返回是否授权成功
  static Future<bool> requestPermission(Permission permission) async {
    final status = await permission.request();
    return status.isGranted;
  }

  /// 检查并请求单个权限，如果未授权则请求
  static Future<bool> checkAndRequest(Permission permission) async {
    if (await isGranted(permission)) {
      return true;
    }
    return await requestPermission(permission);
  }

  /// 检查并请求存储权限（Android）或相册权限（iOS）
  static Future<bool> checkAndRequestStorage() async {
    if (await Permission.storage.isGranted) {
      return true;
    }

    // iOS 需要访问相册权限
    if (await Permission.photos.isGranted) {
      return true;
    }

    if (await Permission.storage.isDenied) {
      final result = await Permission.storage.request();
      if (result.isGranted) return true;
    }

    if (await Permission.photos.isDenied) {
      final result = await Permission.photos.request();
      if (result.isGranted) return true;
    }

    return false;
  }

  /// 检查并请求相机权限
  static Future<bool> checkAndRequestCamera() async {
    return await checkAndRequest(Permission.camera);
  }

  /// 检查并请求麦克风权限
  static Future<bool> checkAndRequestMicrophone() async {
    return await checkAndRequest(Permission.microphone);
  }

  /// 判断某权限是否永久拒绝（用户点了“不再询问”）
  static Future<bool> isPermanentlyDenied(Permission permission) async {
    final status = await permission.status;
    return status.isPermanentlyDenied;
  }

  /// 打开应用设置页，方便用户手动开启权限
  static Future<bool> openAppSettings() async {
    return await openAppSettings();
  }
}
