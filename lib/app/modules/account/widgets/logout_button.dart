import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/styles.dart';
import '../../../core/functions/public/get_lang';
import '../../../core/widgets/common/custom_asset_image.dart';
import '../../../core/widgets/common/custom_box_shadow.dart';
import '../../../core/widgets/common/custom_screen_padding.dart';
import '../controllers/account_controller.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreenPadding(
        child: InkWell(
      onTap: () {
        Get.find<AccountController>().logout();
      },
      child: CustomBoxShadow(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomAssetsImage(
            imagePath: Assets.assetsImagesNewVersionLogout,
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 6),
          Padding(
            padding: EdgeInsets.only(top: language() == "ar" ? 5 : 0),
            child: Text(
              "logout".tr,
              style: Styles.styleBold15,
            ),
          )
        ],
      )),
    ));
  }
}
