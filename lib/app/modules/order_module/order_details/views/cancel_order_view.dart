import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/common/app_bar/custom_app_bar.dart';
import '../../../../core/widgets/common/sizer.dart';
import '../controllers/order_details_controller.dart';
import '../widgets/cancel_order_card_widget.dart';

class CancelOrderView extends StatelessWidget {
  const CancelOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderDetailsController>();
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "cancel_order",
          ),
          Expanded(
            child: ListView.separated(
              itemCount: controller.selectedOrder!.orderDetails.length,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              separatorBuilder: (context, index) => sizer(),
              itemBuilder: (context, index) {
                return CancelOrderCardWidget(
                  orderDetail: controller.selectedOrder!.orderDetails[index],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
