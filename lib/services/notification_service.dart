import 'package:bobofood/utils/logger.dart';
import 'package:bobofood/utils/toast.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:get/get.dart';
import 'dart:io';

// 全局通知处理函数类型定义
typedef NotificationTapCallback = void Function(String? payload);

class NotificationService {
  // 单例模式
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  // 通知插件实例
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // 通知回调函数
  NotificationTapCallback? _onNotificationTapCallback;

  // 设置通知点击回调
  void setNotificationTapCallback(NotificationTapCallback callback) {
    _onNotificationTapCallback = callback;
  }

  // 通知初始化设置
  final InitializationSettings initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    iOS: DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      notificationCategories: [
        DarwinNotificationCategory(
          'actionable',
          actions: [
            DarwinNotificationAction.plain('id_1', '查看'),
            DarwinNotificationAction.plain('id_2', '忽略'),
          ],
        ),
      ],
    ),
  );

  // 初始化通知服务
  Future<void> init() async {
    // 初始化时区数据
    tz.initializeTimeZones();

    // 检查应用是否通过通知启动
    final NotificationAppLaunchDetails? launchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (launchDetails != null && launchDetails.didNotificationLaunchApp) {
      // 应用是通过点击通知启动的
      _handleApplicationLaunch(launchDetails.notificationResponse?.payload);
    }

    // 初始化通知插件
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: _onBackgroundNotificationTap,
    );

    // 请求通知权限
    await _requestPermissions();
  }

  // 请求通知权限
  Future<void> _requestPermissions() async {
    // iOS权限请求
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    // Android权限请求 (Android 13+)
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    // 额外设置Android通知通道组
    if (Platform.isAndroid) {
      await _setupNotificationChannels();
    }
  }

  // 设置Android通知通道
  Future<void> _setupNotificationChannels() async {
    final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      // 创建高优先级通知通道组
      await androidPlugin.createNotificationChannelGroup(
        AndroidNotificationChannelGroup(
          'high_importance_group',
          '重要通知',
          description: '需要立即注意的通知',
        ),
      );

      // 创建普通通知通道组
      await androidPlugin.createNotificationChannelGroup(
        AndroidNotificationChannelGroup(
          'normal_importance_group',
          '普通通知',
          description: '一般提醒通知',
        ),
      );

      // 创建高优先级通知通道
      await androidPlugin.createNotificationChannel(
        AndroidNotificationChannel(
          'high_importance_channel',
          '重要通知',
          description: '需要立即处理的通知',
          importance: Importance.max,
          enableVibration: true,
          groupId: 'high_importance_group',
          showBadge: true,
          enableLights: true,
          ledColor: Colors.red,
        ),
      );
    }
  }

  // 静态方法用于后台通知处理
  @pragma('vm:entry-point')
  static void _onBackgroundNotificationTap(NotificationResponse response) {
    // 后台通知处理逻辑
    logger.d('后台通知被点击: ${response.payload}');
    // 这里无法直接导航，因为这是在隔离区域运行的
  }

  // 处理通知点击事件
  void _onNotificationTap(NotificationResponse response) {
    // 可以根据response.payload处理不同的通知点击事件
    logger.d('通知被点击: ${response.payload}');

    if (_onNotificationTapCallback != null) {
      _onNotificationTapCallback!(response.payload);
    } else {
      // 默认处理逻辑
      _navigateBasedOnPayload(response.payload);
    }
  }

  // 处理应用通过通知启动的情况
  void _handleApplicationLaunch(String? payload) {
    logger.d('应用通过通知启动，payload: $payload');
    AppToast.show('应用通过通知启动，payload: $payload');
    // 可以在这里添加导航逻辑，但需要确保应用已完全初始化
    Future.delayed(const Duration(seconds: 1), () {
      if (_onNotificationTapCallback != null) {
        _onNotificationTapCallback!(payload);
      } else {
        // 默认处理逻辑，例如导航到特定页面
        _navigateBasedOnPayload(payload);
      }
    });
  }

  // 显示简单通知
  Future<void> showSimpleNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'default_channel',
      '默认通知',
      channelDescription: '用于显示一般通知',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformDetails,
      payload: payload,
    );
  }

  // 显示带图片的通知
  Future<void> showBigPictureNotification({
    required int id,
    required String title,
    required String body,
    required String imagePath,
    String? payload,
  }) async {
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      FilePathAndroidBitmap(imagePath),
      largeIcon: FilePathAndroidBitmap(imagePath),
      contentTitle: title,
      htmlFormatContentTitle: true,
      summaryText: body,
      htmlFormatSummaryText: true,
    );

    final AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'big_picture_channel',
      '图片通知',
      channelDescription: '用于显示带图片的通知',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: bigPictureStyleInformation,
    );

    final DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      attachments: [DarwinNotificationAttachment(imagePath)],
    );

    final NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformDetails,
      payload: payload,
    );
  }

  // 显示定时通知
  Future<void> showScheduledNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'scheduled_channel',
      '定时通知',
      channelDescription: '用于显示定时通知',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      platformDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );
  }

  // 取消所有通知
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  // 取消指定ID的通知
  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  // 根据payload导航到相应页面
  void _navigateBasedOnPayload(String? payload) {
    if (payload == null) return;

    // 示例: 根据不同的payload导航到不同页面
    switch (payload) {
      case 'simple_notification':
        // 导航到简单通知详情页
        // Get.toNamed('/notification_detail');
        break;
      case 'picture_notification':
        // 导航到图片通知详情页
        // Get.toNamed('/picture_notification_detail');
        break;
      case 'scheduled_notification':
        // 导航到定时通知详情页
        // Get.toNamed('/scheduled_notification_detail');
        break;
      default:
        // 默认导航到通知列表页
        Get.toNamed('/notification_demo');
    }
  }
}
