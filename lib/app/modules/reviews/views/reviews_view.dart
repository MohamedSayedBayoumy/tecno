import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/enum.dart';
import '../../../core/widgets/common/app_bar/custom_app_bar.dart';
import '../../../core/widgets/common/custom_empty_list_widget.dart';
import '../../../core/widgets/common/custom_failed_widget.dart';
import '../../../core/widgets/common/custom_loading.dart';
import '../../../core/widgets/common/custom_screen_padding.dart';
import '../controllers/reviews_controller.dart';
import '../widgets/order_list_widget.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: 'Reviews',
          ),
          Expanded(
            child: CustomScreenPadding(
              addSafe: false,
              child: GetBuilder<ReviewsController>(
                builder: (controller) {
                  final controller = Get.find<ReviewsController>();
                  switch (controller.status) {
                    case Status.loading:
                      return const CustomLoading();
                    case Status.loaded:
                      if (controller.orders.isEmpty) {
                        return const CustomEmptyList();
                      }
                      return OrdersListWidget(controller: controller);
                    case Status.fail:
                      return CustomFailedWidget(
                        onTap: () {
                          controller.getMyOrders();
                        },
                      );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
