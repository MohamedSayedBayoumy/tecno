import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/enum.dart';
import '../../../core/widgets/common/custom_failed_widget.dart';
import '../../../core/widgets/common/custom_loading.dart';
import '../controllers/offers_controller.dart';
import '../widget/empty_offer_list_widget.dart';
import '../widget/offers_list_widget.dart';

class OffersView extends StatelessWidget {
  const OffersView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OffersController>(
      builder: (controller) {
        switch (controller.screenStatus) {
          case Status.loading:
            return const CustomLoading();
          case Status.loaded:
            if (controller.offers.isEmpty) {
              return const EmptyOfferListWidget();
            }
            return OffersListWidget(controller: controller);

          case Status.fail:
            return CustomFailedWidget(
              onTap: () {
                controller.getOffers();
              },
            );
        }
      },
    );
  }
}
