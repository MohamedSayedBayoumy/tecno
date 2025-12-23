import 'package:flutter/material.dart';

import '../../../../core/widgets/common/sizer.dart';
import '../../../../models/cart/order_details_model.dart';
import 'cancel_order_details_widget.dart';
import 'cancel_order_image_widget.dart';

class CancelOrderCardWidget extends StatelessWidget {
  const CancelOrderCardWidget({super.key, required this.orderDetail});

  final OrderDetail orderDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200)),
      child: Row(
        children: [
          CancelOrderImageWidget(orderDetail: orderDetail),
          sizer(),
          Expanded(
            child: OrderDetailsWidget(orderDetail: orderDetail),
          )
        ],
      ),
    );
  }
}
