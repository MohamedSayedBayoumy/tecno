import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/enum.dart';
import '../../../data/online/data_parser.dart';
import '../../../models/brands_models.dart';

class BrandsController extends GetxController {
  Status screenStatus = Status.loading;

  BrandsResponse? brandsResponse;
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
        getMoreBrands(newPage);
      });
    });
  }

  @override
  void onInit() {
    getBrands();
    super.onInit();
  }

  getBrands() async {
    try {
      addListenerToController();
      page = 1;
      screenStatus = Status.loading;
      update();
      brandsResponse = await DataParser().getBrands(1);
      if (brandsResponse!.status == true) {
        screenStatus = Status.loaded;
        update();
      } else {
        Get.snackbar(
          'Error'.tr,
          brandsResponse!.message ?? "error_message".tr,
          snackPosition: SnackPosition.TOP, // Position on the screen
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 3), // Duration for the message
        );
        screenStatus = Status.fail;
        update();
      }
    } catch (e) {
      screenStatus = Status.fail;
      update();
    }
  }

  getMoreBrands(int newPage) async {
    try {
      final result = await DataParser().getBrands(newPage);
      if (brandsResponse!.status == true) {
        brandsResponse!.data.brands.addAll(result.data.brands);
        paginationStatus = Status.loaded;
        update();
      } else {
        Get.snackbar(
          'Error'.tr,
          brandsResponse!.message ?? "error_message".tr,
          snackPosition: SnackPosition.TOP, // Position on the screen
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 3), // Duration for the message
        );
        paginationStatus = Status.loaded;
        update();
      }
    } catch (e) {
      paginationStatus = Status.loaded;
      update();
    }
  }
}
