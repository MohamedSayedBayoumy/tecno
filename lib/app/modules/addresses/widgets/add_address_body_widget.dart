import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/enum.dart';
import '../../../core/widgets/buttons/custom_app_button.dart';
import '../../../core/widgets/common/custom_loading.dart';
import '../../../core/widgets/common/sizer.dart';
import '../../../routes/app_pages.dart';
import '../controllers/addresses_controller.dart';
import '../views/google_map_view.dart';
import 'address_form_fields.dart';

class AddAddressBodyWidget extends StatelessWidget {
  const AddAddressBodyWidget({super.key, required this.controller});

  final AddressesController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            if (controller.updateMap == Status.loading) ...[
              const Center(
                child: CustomLoading(),
              )
            ] else ...[
              InkWell(
                onTap: () {
                  controller.markers = {};

                  controller.update();
                  Get.toNamed(Routes.googleMapView);

                  log("${controller.markers}");
                },
                child: const SizedBox(
                  height: 300,
                  child: GoogleMapView(
                    isFullView: false,
                  ),
                ),
              ),
            ],
            sizer(),
            AddressFormFields(),
            sizer(),
            if (controller.addressStatus == Status.loading) ...[
              const Center(child: CustomLoading()),
            ] else ...[
              CustomAppButton(
                text: "Apply",
                action: () {
                  if (controller.selectedAddress != null) {
                    controller.updateAddress();
                  } else {
                    controller.addNewAddress();
                  }
                },
              )
            ],
            sizer(),
          ],
        ),
      ),
    );
  }
}
