import 'package:customer/app/core/services/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../core/constants/styles.dart';
import '../../../core/enum.dart';
import '../../../core/functions/public/get_lang';
import '../../../core/widgets/common/custom_failed_widget.dart';
import '../controllers/notification_controller.dart';
import '../widgets/notification_card_widget.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Navigator.of(context).canPop()
            ? IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                color: Colors.black,
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              )
            : null,
        title: Text(
          "notification".tr,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Styles.styleBold20.copyWith(color: Colors.black, height: 2),
        ),
      ),
      body: GetBuilder<NotificationController>(
        builder: (controller) {
          switch (controller.status) {
            case Status.loading:
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            case Status.loaded:
              if (controller
                  .notificationsResponse!.data.notifications.isEmpty) {
                return const SizedBox();
              }
              final notifications =
                  controller.notificationsResponse!.data.notifications;
              return ListView.separated(
                controller: controller.scrollController,
                itemCount: controller.paginationStatus == Status.loading
                    ? notifications.length + 1
                    : notifications.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  if (index >= notifications.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child:
                          Center(child: CircularProgressIndicator.adaptive()),
                    );
                  }
                  final notification = notifications[index];
                  return NotificationCardWidget(
                    timeLabel: timeago.format(
                      notification.sentAt!,
                      locale: language(),
                    ),
                    title: notification.title,
                    description: notification.body,
                    enablePulse: notification.fromNotification,
                    onTap: () {
                      FirebaseNotificationServices.redirect(
                        page: notification.direct,
                        id: notification.directId.toString(),
                      );
                    },
                  );
                },
              );
            case Status.fail:
              return CustomFailedWidget(
                onTap: () {
                  controller.getNotifications();
                },
              );
          }
        },
      ),
    );
  }
}
