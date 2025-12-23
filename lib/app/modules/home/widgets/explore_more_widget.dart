// ignore_for_file: unnecessary_null_comparison, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class ExploreMoreWidget extends StatelessWidget {
  const ExploreMoreWidget({super.key, required this.controller});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("لقد وصلت لنهاية الصفحة استمر في التصفح!",
            style: Styles().subTitle.copyWith(
                color: mainColor, fontWeight: FontWeight.bold, fontSize: 20)),
        // sectionHeader(text: "اكتشف المزيد" ?? ''),
        GridView.builder(
          itemCount: controller.categories.length >= 4 ? 4: controller.categories.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            final item = controller.categories[index];
            return InkWell(
              onTap: () {
                Get.toNamed(
                  Routes.ITEM_FILTERS,
                  arguments: {'category_id': item.id},
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 2,
                      spreadRadius: 0.5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: item != null
                          ? Image.network(
                              item.photo ?? '',
                              width: 110,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.image,
                                      size: 80, color: Colors.grey),
                            )
                          : Container(
                              width: 110, height: 80, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${item.name ?? ''}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        TextButton(
            onPressed: () {
              Get.toNamed(Routes.SEARCH);
            },
            child: Text(
              "عرض المزيد",
              style: TextStyle(color: secondaryColor),
            ))
      ],
    );
  }
}
