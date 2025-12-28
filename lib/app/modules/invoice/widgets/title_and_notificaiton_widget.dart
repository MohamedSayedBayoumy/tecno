import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../core/widgets/common/custom_asset_image.dart';

class TitleAndNotificationWidget extends StatelessWidget {
  const TitleAndNotificationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(
          'Invoices'.tr,
          style: Styles.styleBold18.copyWith(color: mainColor),
        )),
        const CustomAssetsImage(
          imagePath: 'assets/images/notification_icons.png',
          width: 50,
          height: 50,
        ),
      ],
    );
  }
}
