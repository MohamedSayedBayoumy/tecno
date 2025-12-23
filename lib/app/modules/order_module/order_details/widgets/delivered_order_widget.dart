import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widgets/common/custom_asset_image.dart';
import '../../../../models/cart/order_details_model.dart';
import '../../../reviews/widgets/reviewed_view_widget.dart';

class DeliveredOrderWidget extends StatelessWidget {
  const DeliveredOrderWidget({super.key, this.item});
  final OrderDetailsModel? item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Color(0xffDDDDEE),
        borderRadius: BorderRadius.vertical(top: Radius.circular(7)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Details'.tr,
                  style: Styles.styleExtraBold25,
                ),
                const SizedBox(height: 5),
                Text(
                  "check_secure".tr,
                  style: Styles.styleRegular15,
                ),
                const SizedBox(height: 10),
                if (item!.rating != null) ...[
                  ReviewedViewWidget(
                    starCount: item!.rating!.rating,
                    text: item!.rating!.review,
                  ),
                ],
              ],
            ),
          ),
          const CustomAssetsImage(
            imagePath: Assets.assetsImagesNewVersionRafiki,
            width: 130,
            height: 130,
          )
        ],
      ),
    );
  }
}
