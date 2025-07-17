import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class AppStorage {
  static late final Box<dynamic> userInfo;
  static late final Box<dynamic> auth;
  static late final Box<dynamic> conifg;
  static late final Box<dynamic> uplaod;
  static late final Box<dynamic> download;

  static Future<void> init() async {
    final Directory dir = await getApplicationSupportDirectory();
    final String path = dir.path;
    await Hive.initFlutter('$path/hive');
    registerAdapter();
    // 登录用户信息
    userInfo = await Hive.openBox(
      'userInfo',
      compactionStrategy: (int entries, int deletedEntries) {
        return deletedEntries > 2;
      },
    );

    // 登录
    auth = await Hive.openBox('auth');
    // 设置
    conifg = await Hive.openBox('conifg');
    // 上传
    uplaod = await Hive.openBox('uplaod');
    // 下载
    download = await Hive.openBox('download');
  }

  static void registerAdapter() {
    // Hive.registerAdapter(UserInfoDataAdapter());
  }

  static Future<void> close() async {
    userInfo.compact();
    userInfo.close();
    auth.compact();
    auth.close();
    uplaod.compact();
    uplaod.close();
    conifg.compact();
    conifg.close();
    download.compact();
    download.close();
  }

  static Future<void> clear() async {
    await Hive.deleteFromDisk();
  }

  static Future<void> resetAllBoxes() async {
    await userInfo.clear();
    await auth.clear();
    await conifg.clear();
    await uplaod.clear();
    await download.clear();
  }
}

class ConifgBoxKey {
  /// 启动页
  static const String splash = 'splash';

  /// 外观
  static const String themeMode = 'themeMode';
  static const String defaultTextScale = 'textScale';
  static const String dynamicColor = 'dynamicColor'; // bool
  static const String customColor = 'customColor'; // 自定义主题色
  static const String displayMode = 'displayMode';

  /// 反馈
  static const String feedBackEnable = 'feedBackEnable';
  static const String hideTabBar = 'hideTabBar';
}

class LocalCacheKey {
  static const token = 'token', userInfo = 'userInfo';
}
