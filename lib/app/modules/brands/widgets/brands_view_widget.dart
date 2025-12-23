import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/constants/styles.dart';
import '../../../core/enum.dart';
import '../../../models/public/category.dart';
import '../../../routes/app_pages.dart';
import '../../categories/widgets/category_card_widget.dart';
import '../../home/widgets/shimmer_product_item.dart';
import '../../search/controllers/search_controller.dart';
import '../controller/brands_controller.dart';

class BrandsGirdViewWidget extends StatelessWidget {
  BrandsGirdViewWidget({super.key, required this.controller});

  final BrandsController controller;
  final searchController = Get.find<SearchControllers>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchControllers>(
      builder: (context) {
        return GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            mainAxisExtent: 260,
          ),
          controller: controller.scrollController,
          itemCount: controller.paginationStatus == Status.loading
              ? controller.brandsResponse!.data.brands.length + 1
              : controller.brandsResponse!.data.brands.length,
          itemBuilder: (context, index) {
            if (index >= controller.brandsResponse!.data.brands.length) {
              return const ProductItemShimmer(
                showAll: false,
              );
            }
            final brand = controller.brandsResponse!.data.brands[index];
            return InkWell(
              onTap: () {
                if (Get.arguments != null) {
                  searchController.setParam("brand_id", brand.id.toString());
                  searchController.update();
                } else {
                  Get.toNamed(
                    Routes.ITEM_FILTERS,
                    arguments: {'brand_id': brand.id},
                  );
                }
              },
              child: Stack(
                children: [
                  CategoryCardWidget(
                    fit: BoxFit.contain,
                    categoryModel: CategoryModel(
                      name: brand.name,
                      slug: brand.slug,
                      photo: brand.photo,
                    ),
                  ),
                  if (Get.arguments != null) ...[
                    if (searchController.params.containsKey("brand_id")) ...[
                      if (searchController.params["brand_id"] ==
                          brand.id.toString()) ...[
                        Positioned.fill(
                          child: Container(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(AppSizes.borderRadius)),
                                color: Colors.black54),
                            child: Center(
                              child: Text(
                                "selected".tr,
                                style: Styles.styleExtraBold25
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ]
                    ],
                  ]
                ],
              ),
            );
          },
        );
      },
    );
  }
}
