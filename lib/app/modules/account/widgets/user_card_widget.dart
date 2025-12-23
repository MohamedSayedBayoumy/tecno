import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/constants/styles.dart';
import '../../../core/widgets/common/custom_asset_image.dart';
import '../../../core/widgets/common/custom_box_shadow.dart';
import '../../../core/widgets/common/custom_screen_padding.dart';
import '../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';

class UserCardWidget extends StatelessWidget {
  const UserCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreenPadding(
      child: CustomBoxShadow(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const CustomAssetsImage(
            //   imagePath: Assets.assetsImagesNewVersionUser,
            //   width: 50,
            // ),
            // const SizedBox(width: 7),
            Expanded(
              child: GetX<HomeController>(
                builder: (controller) {
                  if (Get.find<HomeController>().profile.value == null) {
                    return const SizedBox();
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${"hi".tr}, ",
                            style: Styles.styleSemiBold14,
                          ),
                          Expanded(
                            child: Text(
                              "${Get.find<HomeController>().profile.value!.data!.firstName!} ${Get.find<HomeController>().profile.value!.data!.lastName!}",
                              style: Styles.styleSemiBold14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        Get.find<HomeController>().profile.value!.data!.email!,
                        style: Styles.styleSemiBold14
                            .copyWith(fontFamily: "en_family"),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.EditProfile);
              },
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                    color: AppColors.whiteGrey,
                    borderRadius: BorderRadius.circular(AppSizes.borderRadius)),
                child: Text(
                  "edit".tr,
                  style: Styles.styleSemiBold14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
