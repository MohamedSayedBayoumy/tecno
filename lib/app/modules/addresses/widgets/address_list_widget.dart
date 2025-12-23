import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/common/custom_box_shadow.dart';
import '../../../routes/app_pages.dart';
import '../controllers/addresses_controller.dart';
import 'address_details_widget.dart';
import 'header_card_address_widget.dart';

class AddressListWidget extends StatelessWidget {
  AddressListWidget({super.key});
  final controller = Get.find<AddressesController>();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: controller.addressResponse!.data.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 20),
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          if (controller.showEdit == true) {
            controller.selectedAddress =
                controller.addressResponse!.data[index];
            controller.getGovernorate();
            Get.toNamed(Routes.address);
          }
        },
        child: CustomBoxShadow(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderCardAddressWidget(
                addressModel: controller.addressResponse!.data[index],
              ),
              const SizedBox(height: 20),
              AddressDetailsWidget(
                addressModel: controller.addressResponse!.data[index],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
