import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../core/widgets/app_bars/customized_app_bar.dart';
import '../../../core/widgets/common/custom_asset_image.dart';
import '../../../core/widgets/common/custom_screen_padding.dart';
import '../../../core/widgets/inputs/custom_text_form_field.dart';
import '../../../routes/app_pages.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreenPadding(
      top: 0.0,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Get.toNamed(Routes.SEARCH);
                },
                child: CustomTextFormFieldWidget(
                  action: (p0) => p0,
                  hint: "search_about".tr,
                  enabled: false,
                ),
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () async {
                String? barcode = await scanBarcode();
                log("BarCode is  $barcode");
                if (barcode != null && barcode.isNotEmpty) {
                  Get.toNamed(
                    Routes.SEARCH,
                    arguments: barcode,
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const CustomAssetsImage(
                      width: 25,
                      height: 25,
                      imagePath: Assets.assetsImagesNewVersionMageBarCodeScan,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "search_qr".tr,
                      style:
                          Styles.styleSemiBold13.copyWith(color: Colors.white),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
