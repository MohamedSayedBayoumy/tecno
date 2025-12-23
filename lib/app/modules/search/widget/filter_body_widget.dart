import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/styles.dart';
import '../../../core/functions/public/get_lang';
import '../controllers/search_controller.dart';
import 'price_filter.dart';

class FilterBodyWidget extends StatelessWidget {
  FilterBodyWidget({super.key});

  final controller = Get.find<SearchControllers>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: controller.filters.map((e) {
          return Column(
            children: [
              rowData(
                title: e.title,
                onTap: () {
                  Get.toNamed(e.path, arguments: true);
                },
              ),
              if (e.title.toLowerCase() == "price") ...[
                const PriceRangeWidget(),
              ],
              Divider(
                color: Colors.grey.shade700,
                height: 1,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget rowData({
    required void Function() onTap,
    required String title,
  }) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title.tr,
              style: Styles.styleSemiBold16,
            ),
          ),
          InkWell(
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Icon(
                language() != 'ar'
                    ? Icons.arrow_back_ios_new_rounded
                    : Icons.arrow_forward_ios_rounded,
                size: 20,
                color: title != "price" ? Colors.black : Colors.transparent,
              ),
            ),
          )
        ],
      ),
    );
  }
}
