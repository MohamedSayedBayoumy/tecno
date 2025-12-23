import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/styles.dart';
import '../../../core/widgets/common/custom_asset_image.dart';
import '../../../core/widgets/common/custom_loading.dart';
import '../controllers/home_controller.dart';

class UserLocationWidget extends StatelessWidget {
  const UserLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(
      () {
        if (controller.loadingLocation.value == true) {
          return const Center(
            child: CustomLoading(
              size: 30,
            ),
          );
        } else {
          if (controller.address.value!.isEmpty) {
            return const SizedBox();
          }
          return FadeIn(
            child: Row(
              children: [
                const CustomAssetsImage(
                  imagePath:
                      Assets.assetsImagesNewVersionFluentLocation24Filled,
                  width: 30,
                  height: 30,
                ),
                Expanded(
                  child: Text(
                    controller.address.value!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.styleBold15.copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
