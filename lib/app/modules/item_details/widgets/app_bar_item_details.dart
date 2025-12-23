import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/app_bars/customized_app_bar.dart';
import '../../../core/widgets/common/app_bar/icon_cart.dart';
import '../../../core/widgets/common/custom_asset_image.dart';
import '../../../core/widgets/inputs/custom_text_form_field.dart';
import '../../../routes/app_pages.dart';

class AppBarItemDetails extends StatelessWidget {
  const AppBarItemDetails({super.key, this.showBackButton = true});

  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showBackButton == true) ...[
          BackButton(
            color: Colors.black,
            onPressed: () {
              log("message>>. ${Get.previousRoute}");
              if (Get.previousRoute == Routes.splash) {
                Get.offAllNamed(Routes.BOTTOMSHEET);
              } else {
                Get.back();
              }
            },
          ),
        ] else ...[
          const SizedBox(width: 10)
        ],
        Expanded(
          child: InkWell(
            onTap: () {
              Get.toNamed(Routes.SEARCH);
            },
            child: CustomTextFormFieldWidget(
              action: (p0) => p0,
              hint: "search_about".tr,
              enabled: false,
              suffix: InkWell(
                onTap: () async {
                  String? barcode = await scanBarcode();
                  if (barcode != null && barcode.isNotEmpty) {
                    Get.toNamed(Routes.SEARCH, arguments: barcode);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CustomAssetsImage(
                    imagePath: Assets.assetsImagesNewVersionMageBarCodeScan,
                    imageColor: mainColor,
                    height: 5,
                    width: 5,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        const IconCart(),
      ],
    );
  }
}
