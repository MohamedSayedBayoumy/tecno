import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/config.dart';
import '../../../core/constants/styles.dart';
import '../../../core/widgets/common/sizer.dart';
import '../../checkOut/controllers/check_out_controller.dart';
import '../controllers/cart_controller.dart';
import 'extra_fees_widget.dart';

class BillCartViewWidget extends StatelessWidget {
  BillCartViewWidget({super.key});

  final controller = Get.find<CheckOutController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IntrinsicHeight(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade200)),
          child: Column(
            children: [
              Text(
                'Order Details'.tr,
                style: Styles.styleExtraBold18,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Total Products'.tr,
                    style: Styles.styleMedium13,
                  ),
                  const Spacer(),
                  Text(
                    Get.find<CartController>().calculateTotalPrice().toString(),
                    style: Styles.styleMedium13,
                  ),
                ],
              ),
              sizer(),
              Row(
                children: [
                  Text(
                    'Delivery Fee'.tr,
                    style: Styles.styleMedium13,
                  ),
                  const Spacer(),
                  Text(
                    controller.selectedGovernorateValue.value.toString(),
                    style: Styles.styleMedium13,
                  ),
                ],
              ),
              if (Get.find<CartController>()
                  .itemHaveShippingPrice
                  .value
                  .isNotEmpty) ...[
                sizer(),
                ExtraFeesWidget(),
              ],
              const Divider(
                color: Colors.grey,
              ),
              sizer(),
              Row(
                children: [
                  Text(
                    'Total'.tr,
                    style: Styles.styleMedium13,
                  ),
                  const Spacer(),
                  Text(
                    '${Get.find<CartController>().calculateTotalPrice() + Get.find<CheckOutController>().selectedGovernorateValue.value + Get.find<CartController>().totalPriceFromShippingPrice.value} ${Config().currency} ',
                    style: Styles.styleMedium13,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
