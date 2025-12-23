import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/widgets/common/app_bar/custom_app_bar.dart';
import '../controllers/categories_controller.dart';
import '../widgets/category_card_widget.dart';
import 'sub_category_items_view.dart';

class CategoriesView extends GetView<CategoriesController> {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: "Categories",
        ),
        Expanded(
          child: Obx(
            () {
              return Skeletonizer(
                enabled: controller.loading.value,
                child: GridView.builder(
                  itemCount: controller.loading.value
                      ? 6
                      : controller.categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    mainAxisExtent: 270,
                  ),
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  itemBuilder: (context, index) {
                    final category = controller.loading.value
                        ? null
                        : controller.categories[index];
                    return InkWell(
                      onTap: () {
                        Get.to(() =>
                            SubCategoryItemsView(categoryId: category!.id!));
                        controller.selectCategory(id: category!.id!);
                        controller.loadSubcategories(category.id!);
                        controller.update();
                      },
                      child: CategoryCardWidget(
                        categoryModel: controller.categories[index],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
