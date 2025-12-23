import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/auth/profile.dart';
import '../../../../modules/home/controllers/home_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/styles.dart';
import '../custom_asset_image.dart';
import '../custom_screen_padding.dart';
import 'icon_cart.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({
    super.key,
    this.title,
    this.showCart = true,
    this.addSafeBottom = true,
    this.afterBack,
  });

  final String? title;
  final bool showCart, addSafeBottom;
  final void Function()? afterBack;

  final homeController = Get.find<HomeController>();

  String get currentRoute => Get.currentRoute;
  ProfileModel? get image => homeController.profile.value;

  @override
  Widget build(BuildContext context) {
    return CustomScreenPadding(
      addSafeBottom: addSafeBottom,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (currentRoute == "/bottom-sheet") ...[
            const SizedBox(width: 40)
          ] else ...[
            InkWell(
              onTap: () {
                log("message>>. ${Get.previousRoute}");
                if (Get.previousRoute == Routes.splash) {
                  Get.offAllNamed(Routes.BOTTOMSHEET);
                } else {
                  Get.back();
                }
                if (afterBack != null) {
                  afterBack!();
                }
              },
              child: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ],
          Expanded(
            child: title != null
                ? Center(
                    child: Text(
                      title!.tr,
                      style: Styles.styleBold20,
                    ),
                  )
                : InkWell(
                    onTap: () {
                      Get.find<HomeController>().getData();
                    },
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: AlignmentDirectional.center,
                      child: Transform.scale(
                        scale: 1.5,
                        alignment: Alignment.center,
                        child: const CustomAssetsImage(
                          imagePath: "assets/images/applogo.png",
                          width: 100,
                          height: 40,
                        ),
                      ),
                    ),
                  ),
          ),
          if (showCart == true) ...[
            const IconCart(),
          ] else ...[
            const SizedBox(width: 20)
          ]
        ],
      ),
    );
  }
}
