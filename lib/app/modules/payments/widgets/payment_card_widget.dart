import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/styles.dart';
import '../../../core/widgets/common/custom_asset_image.dart';
import '../../../core/widgets/common/custom_box_shadow.dart';

class PaymentCardWidget extends StatelessWidget {
  const PaymentCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBoxShadow(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomAssetsImage(
            imagePath: Assets.assetsImagesNewVersionPin,
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 10),
          Text(
            "***123",
            style: Styles.styleMedium13,
          ),
          const SizedBox(width: 5),
          Text(
            "QNP",
            style: Styles.styleBold15,
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20,
          )
        ],
      ),
    );
  }
}
