import 'package:customer/app/core/widgets/buttons/custom_app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/styles.dart';
import '../../../models/cart/address_model.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/addresses_controller.dart';

class AddressDetailsWidget extends StatelessWidget {
  const AddressDetailsWidget({super.key, required this.addressModel});

  final AddressData addressModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleAndValueWidget(
          title: "Name",
          value:
              Get.find<HomeController>().profile.value!.data!.firstName ?? "",
        ),
        TitleAndValueWidget(
          title: "Phone",
          value: addressModel.additionalPhone,
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TitleAndValueWidget(
                title: "Address",
                value: addressModel.address,
              ),
            ),
            if (addressModel.isDefault == true) ...[
              Expanded(
                child: Text(
                  "current_location".tr,
                  style: Styles.styleBold15.copyWith(color: Colors.green),
                ),
              )
            ] else ...[
              Expanded(
                child: CustomAppButton(
                  text: "assign_as_default",
                  action: () {
                    Get.find<AddressesController>()
                        .setAddressDefault(addressModel.id);
                  },
                ),
              )
            ],
          ],
        ),
      ],
    );
  }
}

class TitleAndValueWidget extends StatelessWidget {
  const TitleAndValueWidget(
      {super.key, required this.title, required this.value});

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.tr,
            textAlign: TextAlign.start,
            style: Styles.styleSemiBold16,
          ),
          Text(
            value,
            textAlign: TextAlign.start,
            style: Styles.styleRegular13,
          ),
        ],
      ),
    );
  }
}
