import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../core/widgets/buttons/custom_app_button.dart';
import '../../../core/widgets/common/app_bar/custom_app_bar.dart';
import '../../../core/widgets/common/custom_asset_image.dart';
import '../../../core/widgets/common/custom_screen_padding.dart';
import '../../../core/widgets/common/sizer.dart';

class PaymentDetailsScreen extends StatelessWidget {
  const PaymentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "Payment",
          ),
          CustomScreenPadding(
            addSafe: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAssetsImage(
                  imagePath: Assets.assetsImagesNewVersionPin,
                  width: 20,
                  height: 20,
                ),
                sizer(height: 25),
                Row(
                  children: [
                    Text(
                      "***123",
                      style: Styles.styleRegular25,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "QNP",
                      style: Styles.styleExtraBold25,
                    ),
                  ],
                ),
                sizer(height: 5),
                Row(
                  children: [
                    Text(
                      "${"expiry_date".tr}: ",
                      style: Styles.styleBold15,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "05 / 2028",
                      style: Styles.styleRegular13,
                    ),
                  ],
                ),
                sizer(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: CustomAppButton(
                        text: "edit",
                        color: Colors.transparent,
                        borderColor: mainColor,
                        style: Styles.styleBold11.copyWith(color: mainColor),
                        action: () {},
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomAppButton(
                        color: Colors.red.shade800,
                        text: "delete",
                        action: () {},
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
