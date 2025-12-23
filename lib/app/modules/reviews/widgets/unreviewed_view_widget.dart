import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/colors.dart';
import '../../../core/widgets/buttons/custom_app_button.dart';
import '../controllers/reviews_controller.dart';
import 'rate_bottom_sheet.dart';

class UnReviewedViewWidget extends StatelessWidget {
  const UnReviewedViewWidget({super.key, required this.orderId});
  final int orderId;

  @override
  Widget build(BuildContext context) {
    return CustomAppButton(
      text: "rate_order",
      color: mainColor,
      action: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) {
            return RateBottomSheet(
              title: "rate_order_title",
              onSubmit: (rate, review) {
                Get.find<ReviewsController>().rateOrder(
                  orderId: orderId,
                  rate: rate,
                  text: review,
                );
              },
            );
          },
        );
      },
    );
  }
}
