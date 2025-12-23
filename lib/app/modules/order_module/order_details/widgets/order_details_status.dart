import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/widgets/buttons/custom_app_button.dart';
import '../../../../models/cart/order_details_model.dart';

class OrderDetailsStatusWidget extends StatelessWidget {
  const OrderDetailsStatusWidget({super.key, required this.item});

  final OrderDetailsModel item;

  @override
  Widget build(BuildContext context) {
    if (item.orderStatus.toString().toLowerCase() ==
        "cancelled".toLowerCase()) {
      return CustomAppButton(
        text: "order_cancelled",
        color: Colors.red.shade800,
        style: Styles.styleBold18.copyWith(color: Colors.white, height: 2.1),
        height: 70,
        action: () {},
      );
    } else if (item.paymentStatus!.toLowerCase() == "unpaid".toLowerCase()) {
      return CustomAppButton(
          color: Colors.red.shade800,
          height: 70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Order Not Paid".tr,
                style: Styles.styleBold18
                    .copyWith(color: Colors.white, height: 2.1),
              ),
              // Text(
              //   '(${"guide_pay".tr})',
              //   maxLines: 2,
              //   style: Styles.styleMedium18.copyWith(color: Colors.white),
              // )
            ],
          ),
          action: () {});
    } else {
      return const SizedBox();
    }
  }
}
