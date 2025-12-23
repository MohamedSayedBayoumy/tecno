import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/colors.dart';
import '../controllers/search_controller.dart';
import 'filter_card_widget.dart';

class SelectedSearchWidget extends StatelessWidget {
  const SelectedSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchControllers>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: controller.filterList.map(
                  (e) {
                    return InkWell(
                      onTap: () {
                        controller.removeParam(e.id);
                      },
                      child: FilterCardWidget(value: e.title),
                    );
                  },
                ).toList(),
              ),
            ),
            InkWell(
              onTap: () {
                controller.clearFilters();
              },
              borderRadius: BorderRadius.circular(6),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.close,
                  color: mainColor,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
