import 'dart:async';

import 'package:customer/app/data/online/data_parser.dart';
import 'package:customer/app/models/product/item.dart';
import 'package:customer/app/models/public/category.dart';
import 'package:customer/app/models/public/sub_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  final categories = <CategoryModel>[].obs;
  final subcategories = <SubcategoryModel>[].obs;
  final items = <ItemModel>[].obs;
  final categoryId = Rxn<int>();
  final subCategoryId = 0.obs;
  final loading = RxBool(true);
  var isGridView = true.obs;
  final loadingSearch = RxBool(false);

  Timer? debounceSearch;

  TextEditingController searchController = TextEditingController();

  searchCategories() {
    if (debounceSearch?.isActive ?? false) {
      debounceSearch?.cancel();
    }
    if (searchController.text.isNotEmpty) {
      loadingSearch.value = true;
      update();
      debounceSearch = Timer(const Duration(milliseconds: 500), () async {
        getProductsSearch();
      });
    } else {
      loadingSearch.value = false;
      debounceSearch = Timer(const Duration(milliseconds: 100), () async {
        getProducts();
      });
    }
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    searchController.removeListener(() => searchCategories());
    searchController.addListener(() => searchCategories());
    getCategories();
    if (categories.isNotEmpty) {
      selectCategory(id: categories.first.id ?? 0);
      loadSubcategories(categories.first.id ?? 0);
      selectSubCategory(id: subcategories.first.id!);
    }
  }

  // دالة لجلب الفئات
  void getCategories() async {
    loading.value = true;
    categories.value = await DataParser().getCategories();
    loading.value = false;
  }

  // دالة لاختيار الفئة وتحميل الـ subcategories الخاصة بها
  void selectCategory({required int id}) async {
    categoryId.value = id;
    loadSubcategories(id);
  }

  SubcategoryModel? selectedSubcategoryModel;
  Childcategory? selectedChildSubcategoryModel;
  void selectSubCategory({
    required int id,
    int? index,
  }) async {
    subCategoryId.value = id;
    if (index != null) {
      selectedSubcategoryModel = subcategories.value[index];
      subcategories.value.removeAt(index);
      subcategories.value.insert(0, selectedSubcategoryModel!);
    }
    selectedChildSubcategoryModel = null;
    update(['subcategories']);
    loading.value = true;

    if (searchController.text.isNotEmpty) {
      getProductsSearch();
    } else {
      getProducts();
    }
  }

  void selectChildSubCategory({
    required int id,
    required int? index,
  }) async {
    selectedChildSubcategoryModel =
        selectedSubcategoryModel!.childcategory![index!];

    selectedSubcategoryModel!.childcategory!.removeAt(index);
    selectedSubcategoryModel!.childcategory!
        .insert(0, selectedChildSubcategoryModel!);

    update(['subcategories']);
    loading.value = true;

    if (searchController.text.isNotEmpty) {
      getProductsSearch();
    } else {
      getProducts();
    }
  }

  void toggleView(bool isGrid) {
    isGridView.value = isGrid;
  }

  void loadSubcategories(int id, {String? search}) async {
    loading.value = true;
    subcategories.value = await DataParser().getSubcategories(id: id);
    loading.value = false;

    if (subcategories.isNotEmpty) {
      selectSubCategory(id: subcategories.first.id!);
    } else {
      getProducts();
    }
    update();
  }

  void getProductsSearch() async {
    final data = await DataParser().getProductsFilter(params: {
      'category_id': categoryId.value,
      'subcategory_id': subCategoryId.value,
      'key': searchController.text,
      "childcategory_id": selectedChildSubcategoryModel!.id,
    });
    items.value = data.data.products;
    loadingSearch.value = false;
    loading.value = false;
  }

  void getProducts() async {
    final data = await DataParser().getProductsFilter(params: {
      'category_id': categoryId.value,
      'subcategory_id': subCategoryId.value,
      if (selectedChildSubcategoryModel != null)
        "childcategory_id": selectedChildSubcategoryModel!.id,
    });
    items.value = data.data.products;

    loading.value = false;
  }
}
