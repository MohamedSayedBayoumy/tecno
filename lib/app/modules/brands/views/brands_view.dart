import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/enum.dart';
import '../../../core/widgets/common/app_bar/custom_app_bar.dart';
import '../../../core/widgets/common/custom_failed_widget.dart';
import '../../../core/widgets/common/custom_loading.dart';
import '../controller/brands_controller.dart';
import '../widgets/brands_view_widget.dart';

class BrandsView extends StatelessWidget {
  const BrandsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "brands",
            addSafeBottom: false,
          ),
          const SizedBox(height: 5),
          Expanded(
            child: GetBuilder<BrandsController>(
              builder: (controller) {
                switch (controller.screenStatus) {
                  case Status.loading:
                    return const Center(
                      child: CustomLoading(),
                    );
                  case Status.loaded:
                    if (controller.brandsResponse!.data.brands.isEmpty) {
                      return const SizedBox();
                    }
                    return BrandsGirdViewWidget(
                      controller: controller,
                    );
                  case Status.fail:
                    return Center(
                      child: CustomFailedWidget(
                        onTap: () {
                          controller.getBrands();
                        },
                      ),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
