 
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/app_bars/customized_app_bar.dart';
import '../../../core/widgets/common/custom_asset_image.dart';
import '../../../core/widgets/common/custom_screen_padding.dart';
import '../../../core/widgets/inputs/custom_text_form_field.dart';
import '../../../routes/app_pages.dart';
import '../controllers/categories_controller.dart';

class CategoryAppBarWidget extends StatelessWidget {
  const CategoryAppBarWidget({super.key, this.onPressed});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoriesController>();
    return Obx(
      () => IgnorePointer(
        ignoring: controller.loading.value,
        child: CustomScreenPadding(
            addSafeBottom: false,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BackButton(
                  color: Colors.black,
                  onPressed: onPressed,
                ),
                Expanded(
                  child: CustomTextFormFieldWidget(
                    action: (p0) => p0,
                    controller: controller.searchController,
                    hint: "search_about".tr,
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
                          imagePath:
                              Assets.assetsImagesNewVersionMageBarCodeScan,
                          imageColor: mainColor,
                          height: 5,
                          width: 5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // InkWell(
                //   onTap: () {},
                //   child: const CustomAssetsImage(
                //     width: 30,
                //     height: 30,
                //     imagePath: Assets.assetsImagesNewVersionFilter,
                //   ),
                // )
              ],
            )),
      ),
    );
  }
}
