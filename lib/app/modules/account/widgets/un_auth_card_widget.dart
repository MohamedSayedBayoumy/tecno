import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/styles.dart';
import '../../../core/widgets/buttons/custom_app_button.dart';
import '../../../core/widgets/common/custom_asset_image.dart';
import '../../../core/widgets/common/custom_box_shadow.dart';
import '../../../core/widgets/common/custom_screen_padding.dart';
import '../../../routes/app_pages.dart';

class UnAuthCardWidget extends StatelessWidget {
  const UnAuthCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScreenPadding(
        child: CustomBoxShadow(
            child: Column(
          children: [
            Row(
              children: [
                const CustomAssetsImage(
                  imagePath: Assets.assetsImagesNewVersionUser,
                  width: 50,
                ),
                const SizedBox(width: 5),
                Expanded(
                    child: Text(
                  "better_experience".tr,
                  style: Styles.styleSemiBold12,
                ))
              ],
            ),
            const SizedBox(height: 20),
            CustomAppButton(
              text: 'Login'.tr,
              action: () => Get.toNamed(Routes.SIGN_IN),
              style: Styles.styleSemiBold14.copyWith(color: Colors.white),
            ),
          ],
        )));
  }
}
