import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widgets/common/custom_asset_image.dart';

class ReceivedWidget extends StatelessWidget {
  const ReceivedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomAssetsImage(
          imagePath: Assets.assetsImagesNewVersionVector,
          width: 40,
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            "we_receive_order".tr,
            style: Styles.styleBold18,
          ),
        )
      ],
    );
  }
}
