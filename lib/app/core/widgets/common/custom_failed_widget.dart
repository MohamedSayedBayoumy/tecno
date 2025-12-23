import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_assets.dart';
import '../../constants/styles.dart';
import '../buttons/custom_app_button.dart';
import 'custom_asset_image.dart';

class CustomFailedWidget extends StatelessWidget {
  const CustomFailedWidget({super.key, required this.onTap});

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomAssetsImage(
          imagePath: Assets.assetsImagesNewVersionErrorImage,
        ),
        Text(
          "error_message".tr,
          style: Styles.styleExtraBold18,
        ),
        const SizedBox(height: 20),
        CustomAppButton(
          width: 200,
          text: "try_again",
          color: Colors.red.shade800,
          action: onTap,
        )
      ],
    );
  }
}
