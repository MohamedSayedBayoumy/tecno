import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/enum.dart';
import '../../../data/online/data_parser.dart';
import '../../../models/cart/order_details_model.dart';
import '../../../models/product/comments.dart';

class ReviewsController extends GetxController {
  final bool initValues;

  ReviewsController({this.initValues = true});
  Status status = Status.loading;

  List<OrderDetailsModel> orders = [];

  CommentsResponse? commentsResponse;

  @override
  void onInit() {
    super.onInit();
    if (initValues == true) {
      getMyOrders();
    }
  }

  getMyOrders() async {
    try {
      status = Status.loading;
      update();
      orders = await DataParser().getOrders();
      orders.removeWhere(
        (element) =>
            element.orderStatus.toString().toLowerCase() !=
                "Delivered".toString().toLowerCase() &&
            element.paymentMethod.toString().toLowerCase() !=
                "Paid".toString().toLowerCase(),
      );
      status = Status.loaded;
      update();
    } on Exception catch (e) {
      log("Failed $e");
      status = Status.fail;
      update();
    }
  }

  rateOrder({orderId, rate, text}) async {
    try {
      status = Status.loading;
      update();
      commentsResponse = await DataParser().rateOrder(
        orderId: orderId,
        rate: rate,
        text: text,
      );

      if (commentsResponse!.status == true) {
        getMyOrders();
        Get.snackbar(
          'Success'.tr,
          commentsResponse!.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      } else {
        status = Status.loaded;
        update();
        Get.snackbar(
          'Error'.tr,
          commentsResponse!.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      }
    } on Exception catch (e) {
      log("Failed in Rete$e");
      status = Status.loaded;
      update();
      Get.snackbar(
        'Error'.tr,
        'error_message'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  rateItem({orderId, rate, text, itemId}) async {
    try {
      status = Status.loading;
      update();
      commentsResponse = await DataParser().rateItem(
        orderId: orderId,
        rate: rate,
        text: text,
        itemId: itemId,
      );

      if (commentsResponse!.status == true) {
        getMyOrders();
        Get.snackbar(
          'Success'.tr,
          commentsResponse!.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      } else {
        status = Status.loaded;
        update();
        Get.snackbar(
          'Error'.tr,
          commentsResponse!.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      }
    } on Exception catch (e) {
      log("Failed in Rete$e");
      status = Status.loaded;
      update();
      Get.snackbar(
        'Error'.tr,
        'error_message'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
