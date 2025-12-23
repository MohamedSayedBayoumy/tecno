import 'dart:async';
import 'dart:developer';

import 'package:customer/app/core/enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/online/data_parser.dart';
import '../../../models/notifications_model.dart';

class NotificationController extends GetxController {
  NotificationsResponse? notificationsResponse;

  Status status = Status.loading;

  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }

  ScrollController scrollController = ScrollController();

  Status paginationStatus = Status.loaded;
  int page = 1;

  Timer? debounceScroll;

  addListenerToController() {
    scrollController.dispose();
    scrollController = ScrollController();
    scrollController.removeListener(() => handleScroll());

    scrollController.addListener(() => handleScroll());
  }

  handleScroll() {
    scrollController.addListener(() {
      if (debounceScroll?.isActive ?? false) {
        debounceScroll?.cancel();
      }
      if (paginationStatus != Status.loading) {
        paginationStatus = Status.loading;
        update();
      }

      debounceScroll = Timer(const Duration(seconds: 1), () async {
        final newPage = ++page;
        getMoreNotifications(newPage);
      });
    });
  }

  getNotifications() async {
    addListenerToController();
    status = Status.loading;
    update();

    try {
      notificationsResponse = await DataParser().getNotifications(1);
      status = Status.loaded;
      update();
    } catch (e) {
      log(">>> $e");
      status = Status.fail;
      update();
    }
  }

  getMoreNotifications(page) async {
    try {
      final result = await DataParser().getNotifications(page);
      notificationsResponse!.data.notifications
          .addAll(result.data.notifications);
      paginationStatus = Status.loaded;
      update();
    } catch (e) {
      paginationStatus = Status.fail;
      update();
    }
  }
}
