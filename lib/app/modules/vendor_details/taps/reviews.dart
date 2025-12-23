import 'package:customer/app/core/constants/styles.dart';
import 'package:customer/app/core/widgets/labels/label_style.dart';
import 'package:customer/app/modules/vendor_details/controllers/vendor_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../item_details/cards/review_card.dart';

class vendorReviews extends StatelessWidget {
  final controller = Get.find<VendorDetailsController>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height * .8,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )),
      child: Column(
        children: [
          labelStyle(text: 'Reviews'.tr, style: Styles().normalPrimary),
          const Divider(),
          Expanded(
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final review = controller.data.value!.reviews![index];
                  return reviewCard(item: review);
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: controller.data.value?.reviews?.length ?? 0),
          ),
        ],
      ),
    );
  }
}
