import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../models/public/governorate_model.dart';
import '../controllers/addresses_controller.dart';

class CountryFiledWidget extends StatelessWidget {
  CountryFiledWidget({super.key});

  final controller = Get.find<AddressesController>();

  final inputDecoration = InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: textFieldBackGround,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: mainColor,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.red,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.red,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "city".tr,
          style: Styles.styleBold15.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 5),
        DropdownButtonFormField<GovernorateModel>(
          decoration: inputDecoration,
          value: controller.governorate.isNotEmpty
              ? controller.governorate.firstWhereOrNull(
                  (c) =>
                      c.id ==
                      (controller.selectedAddress == null
                          ? -1
                          : controller.selectedAddress!.cityId),
                )
              : null,
          items: controller.governorate.map((governorate) {
            return DropdownMenuItem<GovernorateModel>(
              value: governorate,
              child: Text(governorate.name!),
            );
          }).toList(),
          onChanged: (GovernorateModel? selectedGovernorate) {
            if (selectedGovernorate != null) {
              controller.cityController.text = selectedGovernorate.name!;
              controller.selectedGovernorateId = selectedGovernorate.id!;
              controller.update();
            }
          },
          validator: (value) {
            if (value == null) {
              return 'Please select a city'.tr;
            }
            return null;
          },
        ),
      ],
    );
  }
}
