import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/enum.dart';
import '../../../../data/online/data_parser.dart';
import '../../../../models/cart/order_details_model.dart';
import '../../orders/controllers/orders_controller.dart';

class OrderDetailsController extends GetxController {
  int id;
  OrderDetailsController(this.id);

  final item = Rxn<OrderDetailsModel>();
  final loading = RxBool(true);

  OrderDetailsModel? selectedOrder;

  TextEditingController cancelReason = TextEditingController();

  final cancelStatus = Rxn<Status>();

  final formKey = GlobalKey<FormState>();

  RxBool canCancel = false.obs;

  @override
  void onInit() {
    if (id != -1) {
      getOrderDetails();
    }
    super.onInit();
  }

  void getOrderDetails() async {
    selectedOrder = null;
    update();
    item.value = await DataParser().getOrderDetails(id: id);
    canCancel.value = item.value!.orderStatus!.toLowerCase().toLowerCase() ==
            "pending" ||
        (item.value!.paymentStatus!.toLowerCase().toLowerCase() == "unpaid" &&
            item.value!.orderStatus!.toLowerCase().toLowerCase() !=
                "cancelled");
    loading.value = false;
  }

  cancelOrder() async {
    if (formKey.currentState!.validate()) {
      try {
        Get.back();
        loading.value = true;
        final response = await DataParser().cancelOrder(
          id: id.toString(),
          reason: cancelReason.text,
        );
        if (response["status"] == true) {
          success(response);
        } else {
          failed(message: response["message"]);
        }
      } catch (e) {
        failed();
      }
    }
  }

  void success(Map<String, dynamic> response) {
    Get.back();

    Get.snackbar(
      'Success'.tr,
      'item_cancelled'.tr,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
    cancelReason.clear();
    Get.find<OrdersController>().getData();
  }

  void failed({String? message}) {
    loading.value = false;
    Get.snackbar(
      'Error'.tr,
      message ?? 'error_message'.tr,
      snackPosition: SnackPosition.TOP, // Position on the screen
      backgroundColor: Colors.red.withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 3), // Duration for the message
    );
  }
}
