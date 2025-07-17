import 'dart:async';

import 'package:event_bus/event_bus.dart';

/// 创建全局 EventBus 实例
final EventBus appEventBus = EventBus();

/// 定义事件类
class ThemeChangedEvent {}

typedef ThemeChangeCallback = void Function();

class ThemeEventListener {
  static StreamSubscription listen(ThemeChangeCallback callback) {
    return appEventBus.on<ThemeChangedEvent>().listen((event) => callback());
  }
}
