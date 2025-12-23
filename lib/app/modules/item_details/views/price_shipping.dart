import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/styles.dart';

class ShippingPriceWidget extends StatelessWidget {
  const ShippingPriceWidget({super.key, required this.price});

  final double price;

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.amber.shade700,
        ),
        child: Row(
          children: [
            Lottie.asset(
              Assets.assetsImagesNewVersionShippingtruck,
              width: 100.0,
            ),
            // Image.asset(
            //   Assets.assetsImagesNewVersionFastDelivery,
            //   width: 100,
            // ),
            const SizedBox(width: 5.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "shipping_extra_title".tr,
                    style: Styles.styleBold20,
                  ),
                  Text(
                    'shipping_extra_desc'.trParams({
                      'fee': price.toString(),
                    }),
                    style: Styles.styleMedium15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
