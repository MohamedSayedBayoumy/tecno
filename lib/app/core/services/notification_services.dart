import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:customer/app/core/services/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static final NotificationService _notificationService =
      NotificationService._internal();
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static AndroidInitializationSettings? _androidInitializationSettings;

  static const DarwinInitializationSettings _iosInitializationSettings =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal() {
    init();
  }

  static Future<void> init() async {
    // استخدم مورد صحيح بدون .png
    // لو عملت ic_notification، تقدر تخليه الافتراضي هنا بدل اللانشر
    _androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: _androidInitializationSettings,
      iOS: _iosInitializationSettings,
      macOS: _iosInitializationSettings,
    );

    // iOS: أظهر الإشعارات والاب مفتوح
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // اطلب التصاريح (iOS + Android 13+)
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (Platform.isAndroid) {
      final androidImpl = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      // Android 13+ runtime permission
      await androidImpl?.requestNotificationsPermission();
    }

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: handleOpenNotification,
      onDidReceiveNotificationResponse: handleOpenNotification,
    );
    // await _flutterLocalNotificationsPlugin.cancelAll();
  }

  static void handleOpenNotification(NotificationResponse details) async {
    log("Open App By Notification");
    final payload = json.decode(details.payload!);
    log("$payload");

    if (payload != null && payload.isNotEmpty) {
      FirebaseNotificationServices.redirect(
        page: payload["direct"],
        id: payload["direct_id"],
      ); 
    }
  }

  static void defaultMessage({String? title, String? des, String? payload}) {
    const androidDetails = AndroidNotificationDetails(
      'message_channel_id',
      'Message Channel',
      channelDescription: 'message channel description',
      channelShowBadge: true,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableLights: true,
      enableVibration: true,
      icon: '@mipmap/ic_launcher',
    );

    const iOSDetails = DarwinNotificationDetails(
      presentSound: true,
      presentAlert: true,
      presentBadge: true,
      sound: 'default',
    );

    const platformChannelSpecifics = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    _flutterLocalNotificationsPlugin.show(
      0,
      title,
      des,
      platformChannelSpecifics,
      payload: payload ?? (title ?? '').toLowerCase(),
    );
  }
}
