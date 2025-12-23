import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/config.dart';
import '../../../../core/widgets/common/sizer.dart';
import '../../../../models/cart/order_details_model.dart';

class FooterCardWidget extends StatelessWidget {
  const FooterCardWidget({super.key, required this.orderDetailsModel});

  final OrderDetailsModel orderDetailsModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: orderDetailsModel.orderDetails.map(
                    (e) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${e.itemName} = ",
                                maxLines: 1,
                              ),
                            ),
                            Text(
                              "${'count'.tr} ${e.quantity}",
                              maxLines: 1,
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
        sizer(
          width: 5,
        ),
        const Icon(Icons.arrow_forward_ios_rounded),
      ],
    );
  }
}
