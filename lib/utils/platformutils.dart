import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class PlatformUtils {
  static final PlatformUtils _instance = PlatformUtils._internal();
  factory PlatformUtils() => _instance;
  PlatformUtils._internal();

  late final bool isAndroid;
  late final bool isIOS;
  late final bool isMobile;
  late final bool isWeb;
  late final bool isWindows;
  late final bool isMacOS;
  late final bool isLinux;
  late final bool isDesktop;
  bool isEmulator = false;

  static bool _initialized = false;

  /// 初始化（必须在程序启动时调用一次，例如 main() 中）
  static Future<void> init() async {
    if (_initialized) return;

    _instance.isWeb = kIsWeb;

    if (!_instance.isWeb) {
      _instance.isAndroid = Platform.isAndroid;
      _instance.isIOS = Platform.isIOS;
      _instance.isWindows = Platform.isWindows;
      _instance.isMacOS = Platform.isMacOS;
      _instance.isLinux = Platform.isLinux;

      _instance.isMobile = _instance.isAndroid || _instance.isIOS;
      _instance.isDesktop =
          _instance.isWindows || _instance.isMacOS || _instance.isLinux;

      final deviceInfo = DeviceInfoPlugin();
      if (_instance.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        _instance.isEmulator = !androidInfo.isPhysicalDevice;
      } else if (_instance.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        _instance.isEmulator = !iosInfo.isPhysicalDevice;
      } else {
        _instance.isEmulator = false;
      }
    } else {
      // Web 平台
      _instance.isAndroid = false;
      _instance.isIOS = false;
      _instance.isWindows = false;
      _instance.isMacOS = false;
      _instance.isLinux = false;
      _instance.isMobile = false;
      _instance.isDesktop = false;
      _instance.isEmulator = false;
    }

    _initialized = true;
  }
}
