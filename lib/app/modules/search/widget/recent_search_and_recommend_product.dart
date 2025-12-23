import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/styles.dart';
import '../../../routes/app_pages.dart';
import '../controllers/search_controller.dart';

class RecentSearchAndRecommendProduct extends StatelessWidget {
  const RecentSearchAndRecommendProduct({super.key, required this.controller});

  final SearchControllers controller;

  @override
  Widget build(BuildContext context) {
    final recommendedProducts =
        controller.searchResponse!.data.recommendedProducts;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "recent_search".tr,
            //   style: Styles.styleExtraBold15,
            // ),
            // sizer(),
            Text(
              "recommend_search".tr,
              style: Styles.styleExtraBold15,
            ),
            ListView.separated(
              shrinkWrap: true,
              itemCount: recommendedProducts.length,
              padding: const EdgeInsets.symmetric(vertical: 5),
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
                thickness: 1.2,
                height: 5,
              ),
              itemBuilder: (context, index) {
                if (recommendedProducts[index].name!.isEmpty) {
                  return const SizedBox();
                }
                return InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: () {
                    Get.toNamed(
                      Routes.ITEM_DETAILS,
                      arguments: recommendedProducts[index].id,
                      preventDuplicates: false,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      recommendedProducts[index].name!,
                      style: Styles.styleRegular13,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
