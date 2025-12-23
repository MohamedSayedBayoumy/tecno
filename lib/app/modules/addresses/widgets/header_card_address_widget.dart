import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/widgets/common/custom_asset_image.dart';
import '../../../models/cart/address_model.dart';
import 'edit_and_address_widget.dart';

class HeaderCardAddressWidget extends StatelessWidget {
  const HeaderCardAddressWidget({super.key, required this.addressModel});

  final AddressData addressModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomAssetsImage(
          imagePath: Assets.assetsImagesNewVersionBasilMapLocationSolid,
          imageColor: Colors.grey,
          width: 30,
        ),
        const Spacer(),
        EditAndDeleteAddressWidget(
          addressModel: addressModel,
        )
      ],
    );
  }
}
