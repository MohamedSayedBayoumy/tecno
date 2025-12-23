import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/enum.dart';
import '../../../core/widgets/common/app_bar/custom_app_bar.dart';
import '../../../core/widgets/common/custom_loading.dart';
import '../controllers/addresses_controller.dart';
import '../widgets/add_address_button_widget.dart';
import '../widgets/address_list_widget.dart';

class AddressListScreen extends StatelessWidget {
  const AddressListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "my_address".tr,
            addSafeBottom: false,
          ),
          AddAddressButtonWidget(),
          Expanded(
            child: GetBuilder<AddressesController>(
              builder: (controller) {
                switch (controller.status) {
                  case Status.loading:
                    return const CustomLoading();
                  case Status.loaded:
                    if (controller.addressResponse!.data.isEmpty) {
                      return const SizedBox();
                    }
                    return AddressListWidget();
                  case Status.fail:
                    return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
