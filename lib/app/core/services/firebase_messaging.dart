// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../models/notifications_model.dart';
import '../../modules/notification/controllers/notification_controller.dart';
import '../../routes/app_pages.dart';
import 'notification_services.dart';

class FirebaseNotificationServices {
  static getFcmToken(void Function(dynamic)? token) async =>
      await FirebaseMessaging.instance.getToken().then(
        (value) {
          token!(value!.toString());
        },
      );

  static initFirebaseMessagingListener() {
    FirebaseMessaging.onMessage.listen(onMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpened);

    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  }

  static void onMessage(RemoteMessage message) {
    print("on Message ${message.toMap()}");
    NotificationService.defaultMessage(
      title: message.notification!.title,
      des: message.notification!.body,
      payload: json.encode({
        "direct_id": message.toMap()["data"]["direct_id"],
        "direct": message.toMap()["data"]["direct"]
      }),
    );
    if (Get.currentRoute == "/notification") {
      updateNotificationScreen(message);
    }
  }

  static Future<void> onMessageOpened(RemoteMessage message) async {
    print("Message Opened ${message.toMap()}");
    redirect(
      page: message.toMap()["data"]["direct"],
      id: message.toMap()["data"]["direct_id"],
    );
  }

  static Future<void> backgroundMessageHandler(RemoteMessage message) async {
    print("Message background ${message.toMap()}");
    NotificationService.defaultMessage(
      title: message.notification!.title,
      des: message.notification!.body,
      payload: json.encode({
        "direct_id": message.toMap()["data"]["direct_id"] ?? "-1",
        "direct": message.toMap()["data"]["direct"]
      }),
    );
  }

  static void updateNotificationScreen(RemoteMessage message) {
    final controller = Get.find<NotificationController>();
    final oldRes = controller.notificationsResponse!;
    final oldList = oldRes.data.notifications;

    final newItem = NotificationItem(
      id: (oldList.isNotEmpty ? (oldList.last.id! + 1) : 1),
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      sentAt: DateTime.now(),
      isRead: false,
      fromNotification: true,
      direct: message.toMap()["data"]["direct"],
      directId: int.parse(
        message.toMap()["data"]["direct_id"],
      ),
    );

    final newList = List<NotificationItem>.of(oldList);
    newList.insert(0, newItem);

    controller.notificationsResponse = oldRes.copyWith(
      data: oldRes.data.copyWith(
        notifications: newList,
      ),
    );

    controller.update();
  }

  static redirect({required String page, String? id, bool? fromHome}) async {
    if (page == "home") {
      Get.offAllNamed(Routes.BOTTOMSHEET);
    } else if (page == "product") {
      Get.toNamed(Routes.ITEM_DETAILS, arguments: int.parse(id!));
    } else if (page == "order") {
      Get.toNamed(Routes.ORDER_DETAILS, arguments: int.parse(id!));
    } else {}
  }
}
