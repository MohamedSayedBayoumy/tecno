// import 'package:customer/app/core/constants/styles.dart';
// import 'package:customer/app/core/widgets/labels/label_style.dart';
// import 'package:customer/app/modules/categories/controllers/categories_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../core/constants/colors.dart';
//
// Widget mainCategories() {
//   final controller = Get.find<CategoriesController>();
//   return Obx(() => Container(
//           child:
//               ListView.builder(
//                   itemCount: controller.categories.length,
//                   itemBuilder: (context, index) {
//                     final item = controller.categories[index];
//                     return Obx(() => InkWell(
//                           onTap: () => controller.selectCategory(id: item.id!),
//                           child: Container(
//                             height: kToolbarHeight,
//                             padding: const EdgeInsets.all(5),
//                             decoration: BoxDecoration(
//                                 color: controller.categoryId.value == item.id
//                                     ? mainColor
//                                     : semiGrey),
//                             child: labelStyle(
//                                 text: item.name ?? '',
//                                 style: controller.categoryId.value == item.id
//                                     ? styles().normalWhite
//                                     : styles().normal),
//                           ),
//                         ));
//                   }),
//       //         GridView.builder(
//       //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//       //     crossAxisCount: 2, // Number of columns in the grid
//       //     crossAxisSpacing: 8, // Horizontal space between items
//       //     mainAxisSpacing: 8, // Vertical space between items
//       //     childAspectRatio: 2, // Decrease the ratio to increase item height
//       //   ),
//       //   itemCount: controller.categories.length,
//       //   itemBuilder: (context, index) {
//       //     final item = controller.categories[index];
//       //     return Obx(
//       //       () => Column(
//       //         children: [
//       //           InkWell(
//       //             onTap: () => controller.selectCategory(id: item.id!),
//       //             child: Container(
//       //               alignment: Alignment.center,
//       //               padding: const EdgeInsets.all(5),
//       //               decoration: BoxDecoration(
//       //                 color: controller.categoryId.value == item.id
//       //                     ? mainColor
//       //                     : semiGrey,
//       //               ),
//       //               child: Column(
//       //                 mainAxisAlignment: MainAxisAlignment.center,
//       //                 children: [
//       //                   // Display the text label
//       //                   labelStyle(
//       //                     text: item.name ?? '',
//       //                     style: controller.categoryId.value == item.id
//       //                         ? styles().normalWhite
//       //                         : styles().normal,
//       //                   ),
//       //                   const SizedBox(height: 5),
//       //                   // Spacing between text and image
//       //                   // Display the network image below the text
//       //                   Image.network(
//       //                     item.photo ?? '',
//       //                     // Provide the URL for the image here
//       //                     width: 50, // Adjust the width as needed
//       //                     height: 50, // Adjust the height as needed
//       //                     fit: BoxFit.cover,
//       //                     errorBuilder: (context, error, stackTrace) => Icon(
//       //                       Icons.broken_image,
//       //                       color: Colors.red,
//       //                     ), // Display an icon if the image fails to load
//       //                   ),
//       //                 ],
//       //               ),
//       //             ),
//       //           ),
//       //           Container(
//       //             height: 10,
//       //             color: Colors.red,
//       //           )
//       //         ],
//       //       ),
//       //     );
//       //   },
//       // )
//   ));
// }

// import 'package:customer/app/core/constants/styles.dart';
// import 'package:customer/app/core/widgets/labels/label_style.dart';
// import 'package:customer/app/modules/categories/controllers/categories_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../core/constants/colors.dart';
//
// Widget mainCategories() {
//   final controller = Get.find<CategoriesController>();
//   return Obx(() => Container(
//     padding: const EdgeInsets.all(8),
//     child: GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2, // عدد الأعمدة في الشبكة (2 فئات في الصف)
//         crossAxisSpacing: 8, // المسافة الأفقية بين العناصر
//         mainAxisSpacing: 8, // المسافة الرأسية بين العناصر
//         childAspectRatio: 1, // نسبة الارتفاع إلى العرض
//       ),
//       itemCount: controller.categories.length,
//       itemBuilder: (context, index) {
//         final item = controller.categories[index];
//         return InkWell(
//           onTap: () => controller.selectCategory(id: item.id!),
//           child: Container(
//             alignment: Alignment.center,
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: controller.categoryId.value == item.id
//                   ? mainColor
//                   : semiGrey,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // عرض الاسم
//                 labelStyle(
//                   text: item.name ?? '',
//                   style: controller.categoryId.value == item.id
//                       ? styles().normalWhite
//                       : styles().normal,
//                 ),
//                 const SizedBox(height: 5),
//                 // عرض الصورة
//                 Image.network(
//                   item.image ?? '',
//                   width: 50,
//                   height: 50,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) => Icon(
//                     Icons.broken_image,
//                     color: Colors.red,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     ),
//   ));
// }

import 'package:customer/app/core/constants/styles.dart';
import 'package:customer/app/core/widgets/labels/label_style.dart';
import 'package:customer/app/modules/categories/controllers/categories_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/dynamic/empty_list.dart';
import '../widgets/sub_categories.dart';

Widget mainCategories() {
  final controller = Get.find<CategoriesController>();

  return Obx(() => Container(
    padding: const EdgeInsets.all(8),
    child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // عدد الأعمدة في الشبكة (2 فئات في الصف)
        crossAxisSpacing: 8, // المسافة الأفقية بين العناصر
        mainAxisSpacing: 8, // المسافة الرأسية بين العناصر
        childAspectRatio: 1.2, // نسبة الارتفاع إلى العرض
      ),
      itemCount: controller.categories.length,
      itemBuilder: (context, index) {
        final item = controller.categories[index];
        bool isExpanded = controller.categoryId.value == item.id;

        return InkWell(
          onTap: () => controller.selectCategory(id: item.id!),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isExpanded ? mainColor : semiGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // عرض الاسم
                labelStyle(
                  text: item.name ?? '',
                  style: isExpanded ? Styles().normalWhite : Styles().normal,
                ),
                const SizedBox(height: 5),
                // عرض الصورة
                Image.network(
                  item.image ?? '',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.broken_image,
                    color: Colors.red,
                  ),
                ),
                // إذا كانت الفئة المحددة، عرض الـ subcategories
                if (isExpanded)
                  Container(
                    padding: const EdgeInsets.only(top: 10, left: 20),
                    child: controller.subcategories.isEmpty
                        ? const EmptyList(label: 'No subcategories available')
                        : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.subcategories.length,
                      itemBuilder: (context, index) {
                        final subItem = controller.subcategories[index];
                        return subCategoryCard(item: subItem);
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    ),
  ));
}
