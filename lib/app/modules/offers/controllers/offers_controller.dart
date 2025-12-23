import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/enum.dart';
import '../../../data/online/data_parser.dart';
import '../../../models/product/item.dart';

class OffersController extends GetxController {
  List<ItemModel> offers = [];

  Status screenStatus = Status.loading;
  Status paginationStatus = Status.loaded;
  int page = 1;
  ScrollController scrollController = ScrollController();

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
        getMoreOffers(newPage: newPage);
      });
    });
  }

  @override
  void onInit() {
    getOffers();
    super.onInit();
  }

  void getOffers() async {
    try {
      addListenerToController();
      screenStatus = Status.loading;
      update();
      offers = await DataParser().getOffers(page: 1);
      screenStatus = Status.loaded;
      update();
    } catch (e) {
      log("$e");
      screenStatus = Status.fail;
      update();
    }
  }

  getMoreOffers({required int newPage}) async {
    try {
      log("Page >> $newPage");
      final result = await DataParser().getOffers(page: newPage);

      offers.addAll(result);
      paginationStatus = Status.loaded;
      update();
    } catch (e) {
      paginationStatus = Status.loaded;
      update();
      Get.snackbar(
        'Error'.tr,
        "error_message".tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
