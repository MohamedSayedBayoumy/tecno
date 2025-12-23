import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/widgets/common/app_bar/custom_app_bar.dart';
import '../../../core/widgets/common/custom_asset_image.dart';
import '../../../core/widgets/common/sizer.dart';
import '../../item_details/widgets/rate_widget/rate_analysis_widget.dart';
import '../controllers/vendor_details_controller.dart';
import '../widget/about_vendor_widget.dart';
import '../widget/header_vendor_widget.dart';

class VendorDetailsView extends StatelessWidget {
  const VendorDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<VendorDetailsController>(
        init: VendorDetailsController(Get.arguments ?? 0),
        builder: (controller) => RefreshIndicator(
          onRefresh: () async => controller.getData(),
          child: Column(
            children: [
              CustomAppBar(
                title: "vendor",
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const CustomAssetsImage(
                          imagePath: Assets.assetsImagesNewVersionVendor,
                          width: 120,
                        ),
                        sizer(height: 20),
                        const HeaderVendorWidget(),
                        sizer(height: 20),
                        const AboutVendorWidget(),
                        sizer(height: 20),
                        //   RateAnalysisWidget(
                        //   title: "item_rate",
                        //   starCount: 6,
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
