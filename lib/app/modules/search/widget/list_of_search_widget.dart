import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../core/enum.dart';
import '../../../core/widgets/common/custom_failed_widget.dart';
import '../../../core/widgets/common/custom_loading.dart';
import '../../../core/widgets/dynamic/empty_list.dart';
import '../../home/widgets/product_item_widget.dart';
import '../../home/widgets/shimmer_product_item.dart';
import '../controllers/search_controller.dart';

class ListOfSearchWidget extends StatelessWidget {
  const ListOfSearchWidget({super.key, required this.controller});

  final SearchControllers controller;

  @override
  Widget build(BuildContext context) {
    switch (controller.searchStatus) {
      case Status.loading:
        return const Center(child: CustomLoading());
      case Status.loaded:
        if (controller.searchResponse!.data.products.isEmpty) {
          return const EmptyList(label: 'There is no products');
        }
        return GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          controller: controller.scrollController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 310,
          ),
          itemCount: controller.paginationStatus == Status.loading
              ? controller.searchResponse!.data.products.length + 1
              : controller.searchResponse!.data.products.length,
          itemBuilder: (context, index) {
            if (index >= controller.searchResponse!.data.products.length) {
              return const ProductItemShimmer();
            }
            final item = controller.searchResponse!.data.products[index];
            return ProductItemWidget(item: item);
          },
        );
      case Status.fail:
        return Center(
          child: CustomFailedWidget(
            onTap: () {
              controller.getData();
            },
          ),
        );
    }
  }
}
