import 'dart:developer';

import 'package:customer/app/data/online/data_parser.dart';
import 'package:customer/app/models/cart/order_details_model.dart';
import 'package:customer/app/models/cart/order_model.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  final orders = <OrderDetailsModel>[].obs;
  final loading = RxBool(false);

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    loading.value = true;
    orders.value = await DataParser().getOrders();
    loading.value = false;
  }
}
