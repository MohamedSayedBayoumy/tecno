import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/config.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widgets/common/sizer.dart';
import '../../../../models/cart/order_details_model.dart';

import '../../../reviews/widgets/review_widget.dart';
import 'card_header_widget.dart';
import 'footer_card_widget.dart';
import 'items_list_widget.dart';
import 'order_status_widget.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget(
      {super.key, required this.item, required this.showRate});
  final OrderDetailsModel item;
  final bool showRate;

  bool isPaid(status) => status != 'paid' ? true : false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: color())),
          child: Column(
            children: [
              CardHeaderWidget(item: item),
              if (item.orderDetails.isNotEmpty) ...[
                const Divider(
                  thickness: .8,
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    "${"Items".tr}:",
                    style: Styles.styleSemiBold16,
                  ),
                ),
                const SizedBox(height: 4),
                ItemListWidget(
                  order: item,
                  showRate: showRate,
                ),
                const SizedBox(height: 5),
                OrderStatusWidget(item: item),
                const SizedBox(height: 5),
                const Divider(
                  thickness: .8,
                ),
              ],
              FooterCardWidget(
                orderDetailsModel: item,
              ),
              sizer(),
              Container(
                height: .5,
                decoration: const BoxDecoration(color: Colors.black),
              ),
              sizer(
                width: 5,
              ),
              Text(
                "${item.totalPrice.toString()} ${Config().currency}",
              ),
              sizer(),
              if (showRate == true) ...[ReviewWidget(order: item)]
            ],
          ),
        ),
        if (item.orderStatus!.toLowerCase() == "cancelled".toLowerCase()) ...[
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Center(
                child: Text(
                  "order_cancelled".tr,
                  style: Styles.styleExtraBold30.copyWith(color: Colors.white),
                ),
              ),
            ),
          )
        ]
      ],
    );
  }

  Color color() {
    return isPaid(item.paymentStatus)
        ? Colors.grey.shade400
        : Colors.red.shade800;
  }
}
