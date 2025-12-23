import 'package:customer/app/core/functions/public/get_lang';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/common/custom_asset_image.dart';

class AddressActionWidget extends StatelessWidget {
  const AddressActionWidget({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });
  final String image, title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAssetsImage(
            imagePath: image,
            height: 15,
            imageColor: Colors.grey,
          ),
          const SizedBox(width: 5),
          Text(
            title.tr,
            style: TextStyle(height: language() == "en" ? null : 2),
          ),
        ],
      ),
    );
  }
}
