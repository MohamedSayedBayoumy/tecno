import 'package:customer/app/core/widgets/common/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/styles.dart';
import '../controllers/cart_controller.dart';

class ExtraFeesWidget extends StatelessWidget {
  ExtraFeesWidget({super.key});

  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "shipping_extra_title".tr,
              style: Styles.styleMedium13,
            ),
            const Spacer(),
            Text(
              Get.find<CartController>().totalPriceFromShippingPrice.toString(),
              style: Styles.styleMedium13,
            ),
          ],
        ),
        sizer(height: 5),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: controller.itemHaveShippingPrice
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    item.name!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Styles.styleMedium13,
                                  ),
                                ),
                                const SizedBox(width: 5.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "( ${'number_of_items'.tr}: ${item.quantity.toString()} )",
                                      style: Styles.styleMedium13,
                                    ),
                                    Text(
                                      "( ${'unit_cost'.tr}: ${item.shippingPrice!} )",
                                      style: Styles.styleMedium13,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "${double.parse(item.shippingPrice!) * item.quantity!}",
                            style: Styles.styleMedium13,
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ))
      ],
    );
  }
}
