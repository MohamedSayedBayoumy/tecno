import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/cart/order_details_model.dart';
import '../controllers/reviews_controller.dart';
import 'reviewed_view_widget.dart';
import 'unreviewed_view_widget.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({super.key, required this.order});
  final OrderDetailsModel order;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewsController>(
      builder: (controller) {
        if (order.rating != null) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xffDDDDEE),
              borderRadius: BorderRadius.circular(7),
            ),
            child: ReviewedViewWidget(
              starCount: order.rating!.rating,
              text: order.rating!.review,
            ),
          );
        } else {
          return UnReviewedViewWidget(
            orderId: order.id!,
          );
        }
      },
    );
  }
}
