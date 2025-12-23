import 'package:flutter/material.dart';

import '../../../core/enum.dart';
import '../../home/widgets/product_item_widget.dart';
import '../../home/widgets/shimmer_product_item.dart';
import '../../item_details/widgets/app_bar_item_details.dart';
import '../controllers/offers_controller.dart';

class OffersListWidget extends StatelessWidget {
  const OffersListWidget({
    super.key,
    required this.controller,
  });
  final OffersController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppBarItemDetails(
          showBackButton: false,
        ),
        const SizedBox(height: 10),
        Expanded(
          child: GridView.builder(
              controller: controller.scrollController,
              itemCount: controller.paginationStatus == Status.loading
                  ? controller.offers.length + 1
                  : controller.offers.length,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 310,
              ),
              itemBuilder: (context, index) {
                if (index >= controller.offers.length) {
                  return const ProductItemShimmer();
                }
                final item = controller.offers[index];
                return ProductItemWidget(item: item);
              }),
        ),
      ],
    );
  }
}
