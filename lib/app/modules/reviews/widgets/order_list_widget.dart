import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/common/sizer.dart';
import '../../../routes/app_pages.dart';
import '../../order_module/orders/widget/_order_card_widget.dart';
import '../controllers/reviews_controller.dart';

class OrdersListWidget extends StatelessWidget {
  const OrdersListWidget({super.key, required this.controller});

  final ReviewsController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: controller.orders.length,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      separatorBuilder: (context, index) => sizer(),
      itemBuilder: (context, index) => InkWell(
        onTap: () => Get.toNamed(Routes.ORDER_DETAILS,
            arguments: controller.orders[index].id),
        child: OrderCardWidget(
          item: controller.orders[index],
          showRate: true,
        ),
      ),
    );
  }
}
