import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/enum.dart';
import '../../../data/online/data_parser.dart';
import '../../../models/public/category.dart';
import '../../../models/search/filter.dart';
import '../../../models/search/search_model.dart';
import '../../../routes/app_pages.dart';
import '../../brands/controller/brands_controller.dart';

class SearchControllers extends GetxController {
  List<CategoryModel> categories = <CategoryModel>[];
  FocusNode focusNode = FocusNode();

  Timer? debounceSearch;
  Timer? debounceUpdate;
  SearchResponse? searchResponse;

  TextEditingController searchController = TextEditingController();

  List<FilterListModel> filterList = [];

  final Map<String, String> params = {};

  Status status = Status.loading;
  Status searchStatus = Status.loading;

  bool doSearch = false;

  List<FilterModel> filters = [
    FilterModel(title: "brand", path: Routes.BRANDS),
    FilterModel(title: "price", path: ""),
  ];

  String searchQuery = "";
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
        getMoreProduct(newPage);
      });
    });
  }

  getMoreProduct(page) async {
    try {
      params["page"] = "$page";
      log("message $params");
      update();
      final result = await DataParser().getProductsFilter(
        params: {'key': searchController.text, ...params},
      );
      searchResponse!.data.products.addAll(result.data.products);

      paginationStatus = Status.loaded;

      update();
    } catch (e) {
      paginationStatus = Status.fail;
      update();
    }
  }

  void setParam(String key, String value) {
    params[key] = value;
    doSearch = true;
    update();

    createListOfFilters();
  }

  createListOfFilters() {
    filterList = [];
    if (params.containsKey("min_price") && params.containsKey("max_price")) {
      filterList.add(
        FilterListModel(
          title: "${'price'}: ${params["min_price"]} - ${params["max_price"]}",
          id: "price",
        ),
      );
    }
    if (params.containsKey("brand_id")) {
      final currentBrand = brandsController.brandsResponse!.data.brands
          .where((e) => e.id == int.parse(params["brand_id"].toString()))
          .toList();
      filterList.add(
        FilterListModel(
          title: "${'brand'}: ${currentBrand.first.name}",
          id: "brand_id",
        ),
      );
    }
    update();
  }

  void removeParam(String key) {
    if (key == "price") {
      params.remove("min_price");
      params.remove("max_price");
    } else {
      params.remove(key.toString().toLowerCase());
    }

    update();

    createListOfFilters();
    search(showLoading: true);
  }

  void clearFilters() {
    params.clear();
    searchController.clear();
    doSearch = false;
    update();
  }

  final brandsController = Get.find<BrandsController>();

  searchCategories() {
    if (debounceSearch?.isActive ?? false) {
      debounceSearch?.cancel();
    }
    if (searchController.text.isNotEmpty) {
      searchStatus = Status.loading;
      update();
      debounceSearch = Timer(const Duration(milliseconds: 500), () async {
        search();
      });
    } else {
      update();
    }
  }

  @override
  void onInit() {
    // autofocus
    searchController.removeListener(() => searchCategories());
    searchController.addListener(() => searchCategories());
    addListenerToController();
    Future.delayed(const Duration(milliseconds: 300), () {
      focusNode.requestFocus();
    });
    final args = Get.arguments;
    if (args != null && args is String) {
      searchWithBarcode(barcode: args);
    } else {
      getData();
    }
    super.onInit();
  }

  getData() async {
    try {
      status = Status.loading;
      searchController.clear();
      update();
      searchResponse = await DataParser().getProductsFilter(params: {
        'key': '',
      });
      status = Status.loaded;
      update();
    } catch (e) {
      status = Status.fail;
      update();
    }
  }

  search({showLoading = false}) async {
    try {
      if (showLoading == true) {
        searchStatus = Status.loading;
        update();
      }
      page = 1;
      params["page"] = "1";
      log("message $params");
      update();
      searchResponse = await DataParser().getProductsFilter(
        params: {'key': searchController.text, ...params},
      );
      searchStatus = Status.loaded;
      if (params.length < 2) {
        doSearch = false;
      }

      update();
    } catch (e) {
      searchStatus = Status.fail;
      update();
    }
  }

  void searchWithBarcode({
    required String barcode,
  }) async {
    try {
      status = Status.loaded;
      searchController.text = Get.arguments;
      update();
      searchStatus = Status.loading;
      update();
      searchResponse = await DataParser().getProductsFilter(params: {
        'bar_code': barcode,
      });
      searchStatus = Status.loaded;

      update();
      if (searchResponse!.data.products.isEmpty) {
        Get.snackbar(
          'تنبيه', // عنوان الرسالة
          'لم يتم العثور على منتج بهذا الباركود', // نص الرسالة
          snackPosition: SnackPosition.TOP, // موقع الرسالة
          backgroundColor: Colors.red.withOpacity(0.8), // لون خلفية الرسالة
          colorText: Colors.white, // لون النص
          duration: const Duration(seconds: 3), // مدة ظهور الرسالة
        );
      }
    } catch (e) {
      searchStatus = Status.fail;
      update();
    }
  }
}
