import 'package:customer/app/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/common/sizer.dart';
import '../../../core/widgets/inputs/custom_text_form_field.dart';
import '../controllers/addresses_controller.dart';
import 'country_filed_widget.dart';

class AddressFormFields extends StatelessWidget {
  AddressFormFields({super.key});
  final controller = Get.find<AddressesController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.fromFiled,
      child: Column(
        children: [
          CountryFiledWidget(),
          sizer(),
          Row(
            children: [
              Expanded(
                child: CustomTextFormFieldWidget(
                  title: "your_address",
                  subtitle: Text(
                    "(${'enter_address_hint'.tr})",
                    style: Styles.styleMedium13,
                  ),
                  controller: controller.areaController,
                  minLines: 1,
                  maxLines: 10,
                  action: (p0) {},
                ),
              ),
              // Text(
              //   'display_current_location',
              // ),
            ],
          ),
          sizer(),
          Row(
            children: [
              Expanded(
                child: CustomTextFormFieldWidget(
                  title: "building_number",
                  controller: controller.buildController,
                  disableText: true,
                  action: (p0) {},
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomTextFormFieldWidget(
                  title: "apartment_number",
                  controller: controller.homeController,
                  disableText: true,
                  action: (p0) {},
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomTextFormFieldWidget(
                  title: "floor_number",
                  controller: controller.floorController,
                  disableText: true,
                  action: (p0) {},
                ),
              )
            ],
          ),
          sizer(),
          CustomTextFormFieldWidget(
            title: "Phone",
            disableText: true,
            controller: controller.phoneNumberController,
            action: (p0) {},
          ),
        ],
      ),
    );
  }
}
