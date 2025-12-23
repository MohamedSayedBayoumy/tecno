import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widgets/common/custom_asset_image.dart';
import '../../../../models/cart/order_details_model.dart';

class OrderAddressWidget extends StatelessWidget {
  const OrderAddressWidget({super.key, required this.item});

  final OrderDetailsModel? item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
            top: item!.paymentStatus!.toLowerCase() == "unpaid".toLowerCase()
                ? const BorderSide(color: Color(0xff838383))
                : BorderSide.none,
            left: const BorderSide(color: Color(0xff838383)),
            right: const BorderSide(color: Color(0xff838383)),
            bottom: const BorderSide(color: Color(0xff838383))),
        borderRadius: BorderRadius.vertical(
          bottom: const Radius.circular(7),
          top: item!.paymentStatus!.toLowerCase() == "unpaid".toLowerCase() ||
                  item!.orderStatus!.toLowerCase().toLowerCase() == "pending"
              ? const Radius.circular(7)
              : const Radius.circular(0),
        ),
      ),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Address'.tr,
                style: Styles.styleExtraBold18,
              ),
              const SizedBox(height: 3),
              Text(
                "${item?.shippingInfo?.shipFirstName ?? ''}, ${item?.shippingInfo?.shipAddress1 ?? ''}, ${item?.shippingInfo?.shipAddress2 ?? ''}\n${'Phone'.tr}: ${item?.shippingInfo?.shipPhone ?? ''}",
                style: Styles.styleRegular15,
              ),
            ],
          )),
          const CustomAssetsImage(
            imagePath: Assets.assetsImagesNewVersionMapIcon,
            width: 50,
            height: 50,
          )
        ],
      ),
    );
  }
}
