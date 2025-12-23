import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/common/app_bar/custom_app_bar.dart';
import '../controllers/search_controller.dart';
import '../widget/filter_body_widget.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "filter_based",
            addSafeBottom: false,
            afterBack: () {
              final controller = Get.find<SearchControllers>();
              if (controller.doSearch == true &&
                  controller.searchController.text.isNotEmpty) {
                controller.search(showLoading: true);
              }
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: FilterBodyWidget(),
            ),
          )
        ],
      ),
    );
  }
}
