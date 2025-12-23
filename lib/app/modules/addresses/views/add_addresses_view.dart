import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/enum.dart';
import '../../../core/widgets/common/app_bar/custom_app_bar.dart';
import '../../../core/widgets/common/custom_failed_widget.dart';
import '../../../core/widgets/common/custom_loading.dart';
import '../../../core/widgets/common/sizer.dart';
import '../controllers/addresses_controller.dart';
import '../widgets/add_address_body_widget.dart';

class AddAddressesView extends StatelessWidget {
  const AddAddressesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AddressesController>(
        builder: (controller) {
          switch (controller.statusGovernorate) {
            case Status.loading:
              return const Center(child: CustomLoading());
            case Status.loaded:
              return Column(
                children: [
                  CustomAppBar(
                    title: "address",
                    showCart: false,
                    addSafeBottom: false,
                  ),
                  sizer(height: 20),
                  Expanded(
                    child: AddAddressBodyWidget(
                      controller: controller,
                    ),
                  )
                ],
              );
            case Status.fail:
              return CustomFailedWidget(
                onTap: () {
                  controller.getGovernorate();
                },
              );
          }
        },
      ),
    );
  }
}
