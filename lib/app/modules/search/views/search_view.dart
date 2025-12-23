import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/enum.dart';
import '../../../core/widgets/common/custom_failed_widget.dart';
import '../../../core/widgets/common/custom_loading.dart';
import '../../../core/widgets/common/sizer.dart';
import '../controllers/search_controller.dart';
import '../widget/list_of_search_widget.dart';
import '../widget/recent_search_and_recommend_product.dart';
import '../widget/search_bar_widget.dart';
import '../widget/selected_search_widget.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SearchControllers>(
        builder: (controller) => Column(
          children: [
            SearchFilterBarWidget(
              controller: controller,
            ),
            if (controller.doSearch == true) ...[
              const SelectedSearchWidget(),
            ] else ...[
              sizer(height: 20),
            ],
            Expanded(
              child: Builder(
                builder: (context) {
                  switch (controller.status) {
                    case Status.loading:
                      return const Center(child: CustomLoading());
                    case Status.loaded:
                      if (controller.searchController.text.isEmpty) {
                        return RecentSearchAndRecommendProduct(
                          controller: controller,
                        );
                      } else {
                        return ListOfSearchWidget(
                          controller: controller,
                        );
                      }
                    case Status.fail:
                      return Center(
                        child: CustomFailedWidget(
                          onTap: () {
                            controller.getData();
                          },
                        ),
                      );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
