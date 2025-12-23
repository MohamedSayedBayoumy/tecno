import 'package:flutter/material.dart';
import '../../../../models/cart/order_details_model.dart';
import 'delivered_order_widget.dart';
import 'order_address_widget.dart';
import 'received_widget.dart';

class OrderDetailsHeaderWidget extends StatelessWidget {
  const OrderDetailsHeaderWidget({super.key, required this.item});
  final OrderDetailsModel? item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          if (item!.orderStatus!.toLowerCase().toLowerCase() == "pending" &&
              item!.paymentMethod!.toLowerCase().toLowerCase() == "paid") ...[
            const ReceivedWidget(),
            const SizedBox(height: 5),
          ] else if (item!.orderStatus!.toLowerCase().toLowerCase() ==
              "delivered") ...[
            DeliveredOrderWidget(item: item),
          ],
          OrderAddressWidget(item: item),
        ],
      ),
    );
  }
}
