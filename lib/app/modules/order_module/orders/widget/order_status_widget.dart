import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/widgets/labels/label_style.dart';
import '../../../../models/cart/order_details_model.dart';

class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({
    super.key,
    required this.item,
  });

  final OrderDetailsModel item;

  @override
  Widget build(BuildContext context) {
    final orderStatus = item.orderStatus.toString();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: labelStyle(
              text: 'Track Order'.tr,
              style: Styles()
                  .normalCustom(color: Colors.black, weight: FontWeight.bold)),
        ),
        if (item.paymentStatus.toString().toLowerCase() == 'paid') ...[
          Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: orderStatus.toLowerCase() == "pending"
                    ? Colors.yellow.shade900
                    : Colors.green.shade800,
                borderRadius: BorderRadius.circular(6),
              ),
              child: labelStyle(
                  text: orderStatus.tr,
                  style: Styles().normalCustom(
                      color: Colors.white, weight: FontWeight.w600))),
        ] else ...[
          Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.shade800,
                borderRadius: BorderRadius.circular(6),
              ),
              child: labelStyle(
                  text: "Order Not Paid".tr,
                  style: Styles().normalCustom(
                      color:
                          item.paymentStatus.toString().toLowerCase() == 'paid'
                              ? Colors.grey
                              : Colors.white,
                      weight: FontWeight.w600))),
        ],
      ],
    );
  }
}
