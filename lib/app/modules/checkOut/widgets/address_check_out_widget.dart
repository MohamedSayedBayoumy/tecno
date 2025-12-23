import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/styles.dart';
import '../../../core/widgets/common/custom_asset_image.dart';
import '../../../routes/app_pages.dart';
import '../controllers/check_out_controller.dart';

class AddressCheckoutWidget extends StatelessWidget {
  const AddressCheckoutWidget({
    super.key,
    required this.controller,
  });

  final CheckOutController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: controller.haveMissingAddressData.value
                  ? Colors.red.shade700
                  : Colors.grey.shade200)),
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.ADDADDRESSES, arguments: true)!.then((result) {
            if (result == true) {
              controller.getData();
            }
          });
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAssetsImage(
              imagePath: Assets.assetsImagesNewVersionFluentLocation24Filled,
              width: 20,
              height: 20,
              imageColor: controller.haveMissingAddressData.value == true
                  ? Colors.red.shade700
                  : Colors.black,
            ),
            const SizedBox(width: 2),
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  Text(
                    controller.haveMissingAddressData.value == true
                        ? "must_complete_address".tr
                        : "${"receive_place".tr}:",
                    style: Styles.styleBold15.copyWith(
                      color: controller.haveMissingAddressData.value == true
                          ? Colors.red.shade700
                          : Colors.black,
                    ),
                  ),
                  const SizedBox(width: 1),
                  if (controller.haveMissingAddressData.value == false) ...[
                    Expanded(
                      child: Text(
                        controller.shippingInfo,
                        style: Styles.styleRegular15,
                      ),
                    ),
                  ]
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  controller.haveMissingAddressData.value == true
                      ? "complete".tr
                      : "change".tr,
                  style: Styles.styleBold15.copyWith(
                    color: controller.haveMissingAddressData.value == true
                        ? Colors.red.shade700
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
