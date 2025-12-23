import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../routes/app_pages.dart';
import '../controllers/addresses_controller.dart';

class AddAddressButtonWidget extends StatelessWidget {
  AddAddressButtonWidget({super.key});

  final controller = Get.find<AddressesController>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: () {
        controller.selectedAddress = null;
        controller.getGovernorate();
        Get.toNamed(Routes.address);
      },
      child: Container(
        height: kTextTabBarHeight,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
            border: Border.all(color: mainColor),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            "add_new_address".tr,
            style: Styles.styleBold15,
          ),
        ),
      ),
    );
  }
}
