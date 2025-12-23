import 'package:customer/app/data/online/auth_parser.dart';
import 'package:customer/app/data/repositories/cart/cart_repo.dart';
import 'package:customer/app/models/cart/cart_off_line_model.dart';
import 'package:customer/app/modules/checkOut/controllers/check_out_controller.dart';
import 'package:customer/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import '../../../config/config.dart';
import '../../../models/cart/cart_data.dart';

class CartController extends GetxController {
  final data = <CartOffLineModel>[].obs;
  final itemHaveShippingPrice = <CartOffLineModel>[].obs;
  final totalPriceFromShippingPrice = 0.0.obs;
  final loading = RxBool(true);
  final formatter = DateFormat('yyyy-MM-dd');
  final homeCTRL = Get.find<HomeController>();
  final totalItems = 0.obs;

  @override
  void onInit() {
    getData();
    ever(data, (_) {
      getData();
      calculateTotalItems();
    });
    super.onInit();
  }

  void getData() async {
    if (AuthParser().isAuth()) {
      data.value = await CartRepo().getOffLineCarts();
      itemHaveShippingPrice.clear();
      totalPriceFromShippingPrice.value = 0.0;
      for (var i = 0; i < data.value.length; i++) {
        if (data.value[i].shippingPrice != "0.0") {
          final item = data.value[i];
          itemHaveShippingPrice.value.add(item);
          totalPriceFromShippingPrice.value +=
              (item.quantity! * double.parse(item.shippingPrice!));
        }
      }
      // print("object");
    }

    loading.value = false;
  }

  void calculateTotalItems() {
    int total = 0;
    for (var item in data) {
      total += item.quantity ?? 0;
    }
    totalItems.value = total;
  }

  dynamic get totalAll =>
      "${calculateTotalPrice() + Get.find<CheckOutController>().selectedGovernorateValue.value + Get.find<CartController>().totalPriceFromShippingPrice.value}  ${Config().currency} ";

  double calculateTotalPrice() {
    double total = 0.0; // Initialize total to 0.0

    for (var cartItem in data) {
      total += double.parse(cartItem.price!) *
          cartItem.quantity!; // Add the item's total price to the total
    }
    // print("total price is $total");
    return total; // Return the total price
  }

  void deleteCartItem({required int id}) async {
    int deleted = await CartRepo().deleteCartItemLocal(id: id);
    if (deleted == 1) {
      Get.snackbar(
        'Removed Successfully'.tr, // Title of the snackbar
        'Success'.tr, // Message
        snackPosition: SnackPosition.TOP, // Position on the screen
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      getData();
      // renderSuccess(message: 'Removed Successfully'.tr);
    }
  }

  // void updateCartItem({
  //   required CartItem item,
  // }) async {
  //   bool updated = await CartRepo().updateCartItem(item: item);
  //   if (updated) {
  //     getData();
  //   }
  // }

  void updateCartItem({
    required CartItem item,
  }) async {
    bool updated = await CartRepo().updateCartItem(item: item);
    if (updated) {
      getData();
    }
  }

  void updateCartItemOffLine({
    required int id,
    required int quantity,
  }) async {
    bool updated =
        await CartRepo().updateCartItemOffLine(id: id, quantity: quantity);
    if (updated) {
      getData();
    }
  }
}
