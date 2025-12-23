import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:customer/app/core/functions/public/get_lang';
import 'package:customer/app/core/widgets/common/custom_loading.dart';
import 'package:customer/app/core/widgets/common/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:customer/app/core/constants/colors.dart';
import 'package:customer/app/core/widgets/dynamic/empty_list.dart';
import 'package:customer/app/modules/categories/controllers/categories_controller.dart';
import 'package:customer/app/modules/item_filters/cards/item_card.dart';

import '../../home/widgets/product_item_widget.dart';
import '../widgets/category_app_bar_widget.dart';

class SubCategoryItemsView extends GetView<CategoriesController> {
  final int categoryId;

  const SubCategoryItemsView({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        CategoryAppBarWidget(
          onPressed: () {
            if (Platform.isIOS) {
              final keyboardOpened = FocusScope.of(context).hasFocus;
              if (keyboardOpened == true) {
                FocusScope.of(context).unfocus();
              } else {
                Get.back();
              }
            } else {
              Get.back();
            }
          },
        ),
        const SizedBox(height: 10),
        Obx(() => controller.subcategories.isNotEmpty
            ? Column(
                children: [
                  _buildSubcategoryList(),
                  if (controller.selectedSubcategoryModel != null) ...[
                    if (controller.selectedSubcategoryModel!.childcategory!
                        .isNotEmpty) ...[
                      const SizedBox(height: 10.0),
                      _buildChildSubcategoryList(),
                    ]
                  ],
                ],
              )
            : const SizedBox.shrink()),
        sizer(),
        Obx(
          () => controller.loadingSearch.value == true
              ? const CustomLoading()
              : const SizedBox(),
        ),
        Expanded(
          child: Obx(() {
            if (controller.loading.value) {
              return const CustomLoading();
            }
            return controller.items.isEmpty
                ? const EmptyList(label: 'There is no products')
                : FadeIn(
                    delay: const Duration(milliseconds: 200),
                    child: controller.isGridView.value
                        ? _buildGridView()
                        : _buildListView());
          }),
        ),
      ],
    ));
  }

  /// 🟢 Builds the subcategory selection list (with Skeleton Loader)
  Widget _buildSubcategoryList() {
    if (controller.loading.value) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 10),
      child: AspectRatio(
        aspectRatio: 15,
        child: FadeIn(
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: controller.subcategories.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final subcategory = controller.subcategories[index];
              final isSelected =
                  controller.subCategoryId.value == subcategory.id;

              return GestureDetector(
                onTap: () {
                  controller.selectSubCategory(
                    id: subcategory.id!,
                    index: index,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? mainColor : Colors.transparent,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: language() == "en" ? 0 : 5),
                    child: Center(
                      child: Text(
                        subcategory.name ?? '',
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildChildSubcategoryList() {
    if (controller.loading.value) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 10),
      child: AspectRatio(
        aspectRatio: 15,
        child: FadeIn(
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount:
                controller.selectedSubcategoryModel!.childcategory!.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final childSubcategory =
                  controller.selectedSubcategoryModel!.childcategory![index];
              final isSelected =
                  controller.selectedChildSubcategoryModel == null
                      ? false
                      : controller.selectedChildSubcategoryModel!.id ==
                          childSubcategory.id;

              return GestureDetector(
                onTap: () {
                  controller.selectChildSubCategory(
                    id: childSubcategory.id!,
                    index: index,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? mainColor : Colors.transparent,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: language() == "en" ? 0 : 5),
                    child: Center(
                      child: Text(
                        childSubcategory.name ?? '',
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// 🟢 Toggle between List View and Grid View
  Widget _buildToggleButtons() {
    return ToggleButtons(
      isSelected: [!controller.isGridView.value, controller.isGridView.value],
      selectedColor: Colors.white,
      color: Colors.grey,
      fillColor: mainColor,
      borderRadius: BorderRadius.circular(10),
      children: const [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(Icons.list)),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(Icons.grid_view)),
      ],
      onPressed: (index) {
        controller.toggleView(index == 1);
      },
    );
  }

  /// 🟢 Grid View for displaying items
  Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemCount: controller.items.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 310,
      ),
      itemBuilder: (context, index) {
        final item = controller.items[index];
        return ProductItemWidget(item: item);
      },
    );
  }

  /// 🟢 List View for displaying items
  Widget _buildListView() {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: controller.items.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final item = controller.items[index];
        return ItemCard(item: item);
      },
    );
  }

  /// 🟢 Skeleton Loader for Items (List/Grid)
  Widget _buildLoadingSkeleton() {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: 8,
        itemBuilder: (context, index) => Container(
          height: 80,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
