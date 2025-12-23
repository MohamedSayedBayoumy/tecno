import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../modules/cart/controllers/cart_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/styles.dart';
import '../../../functions/public/get_lang';
import '../custom_asset_image.dart';

class IconCart extends StatelessWidget {
  const IconCart({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.CART);
      },
      child: Obx(
        () {
          final controller = Get.find<CartController>();
          return Stack(
            children: [
              Container(
                width: 50,
                alignment: Alignment.center,
                child: const CustomAssetsImage(
                  imagePath: Assets.assetsImagesNewVersionMdiLocalGroceryStore,
                  width: 35.0,
                ),
              ),
              if (controller.totalItems.value != 0) ...[
                Positioned(
                  child: ZoomIn(
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: const ShapeDecoration(
                        color: Color(0xffD4D4D4),
                        shape: CircleBorder(),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: AlignmentDirectional.center,
                        child: Center(
                          child: ZoomIn(
                            delay: const Duration(milliseconds: 300),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: language() == "en" ? 0 : 4),
                              child: Text(
                                controller.totalItems.value.toString(),
                                style: Styles.styleExtraBold10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ]
            ],
          );
        },
      ),
    );
  }
}
