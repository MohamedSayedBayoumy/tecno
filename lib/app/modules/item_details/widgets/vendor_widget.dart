 import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../core/widgets/common/custom_asset_image.dart';

class VendorWidget extends StatelessWidget {
  const VendorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        children: [
          CustomAssetsImage(
            imagePath: Assets.assetsImagesNewVersionVendor,
            width: 50,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Row(
              children: [
                VendorDetailsWidget(),
                Spacer(),
                Icon(Icons.arrow_forward_ios_rounded)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class VendorDetailsWidget extends StatelessWidget {
  const VendorDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "${"vendor".tr}:",
              style: Styles.styleRegular15,
            ),
            Text(
              "vendor".tr,
              style: Styles.styleBold15.copyWith(color: mainColor),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            IntrinsicWidth(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.star_rate_rounded,
                      color: Colors.amber,
                    ),
                    Text("4", style: Styles.styleBold15)
                  ],
                ),
              ),
            ),
            const SizedBox(width: 3),
            Text("vendor_rate".tr, style: Styles.styleRegular13),
          ],
        ),
      ],
    );
  }
}
