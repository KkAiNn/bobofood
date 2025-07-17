import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import '../services/storage_services.dart';

Box<dynamic> setting = AppStorage.conifg;
void feedBack() {
  // 设置中是否开启
  final bool enable =
      setting.get(ConifgBoxKey.feedBackEnable, defaultValue: true) as bool;
  if (enable) {
    HapticFeedback.lightImpact();
  }
}
