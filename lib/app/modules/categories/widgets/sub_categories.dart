// import 'package:customer/app/core/constants/colors.dart';
// import 'package:customer/app/core/constants/styles.dart';
// import 'package:customer/app/core/widgets/labels/label.dart';
// import 'package:customer/app/core/widgets/labels/label_style.dart';
// import 'package:customer/app/models/public/sub_category.dart';
// import 'package:customer/app/modules/categories/controllers/categories_controller.dart';
// import 'package:customer/app/modules/item_details/controllers/item_details_controller.dart';
// import 'package:customer/app/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class subCategoryCard extends StatefulWidget {
//   SubcategoryModel item;
//   subCategoryCard({required this.item});
//
//   @override
//   State<subCategoryCard> createState() => _subCategoryCardState();
// }
//
// class _subCategoryCardState extends State<subCategoryCard> {
//   bool details = false;
//   final controller = Get.find<CategoriesController>();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           InkWell(
//             onTap: () {
//               details = !details;
//               setState(() {});
//             },
//             child: Row(
//               children: [
//                 Expanded(child: label(text: widget.item.name ?? '')),
//                 Icon(
//                   details ? Icons.arrow_drop_up : Icons.arrow_drop_down,
//                   color: Colors.grey,
//                 )
//               ],
//             ),
//           ),
//           details
//               ? RichText(
//                   textAlign: TextAlign.start,
//                   text: TextSpan(children: [
//                     WidgetSpan(
//                         child: InkWell(
//                       onTap: () {
//                         Get.toNamed(Routes.ITEM_FILTERS, arguments: {
//                           'category_id': controller.categoryId.value,
//                           'subcategory_id': widget.item.id,
//                         });
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(2),
//                         margin: const EdgeInsets.all(3),
//                         decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey),
//                             borderRadius: BorderRadius.circular(5)),
//                         child: labelStyle(
//                           text: 'All'.tr,
//                           style: styles().normal,
//                         ),
//                       ),
//                     )),
//                     ...widget.item.childcategory!.map((e) {
//                       return WidgetSpan(
//                           child: InkWell(
//                         onTap: () {
//                           Get.delete<ItemDetailsController>();
//                           Get.toNamed(Routes.ITEM_FILTERS,
//                               arguments: {
//                                 'category_id': controller.categoryId.value,
//                                 'subcategory_id': widget.item.id,
//                                 'childcategory_id': e.id,
//                               },
//                               preventDuplicates: false);
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.all(2),
//                           margin: const EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                               border: Border.all(color: Colors.grey),
//                               borderRadius: BorderRadius.circular(5)),
//                           child: labelStyle(
//                               text: e.name ?? '', style: styles().normal),
//                         ),
//                       ));
//                     }).toList(),
//                   ]))
//               : const SizedBox(),
//         ],
//       ),
//     );
//   }
// }

import 'package:customer/app/core/constants/colors.dart';
import 'package:customer/app/core/constants/styles.dart';
import 'package:customer/app/core/widgets/labels/label.dart';
import 'package:customer/app/core/widgets/labels/label_style.dart';
import 'package:customer/app/models/public/sub_category.dart';
import 'package:customer/app/modules/categories/controllers/categories_controller.dart';
import 'package:customer/app/modules/item_details/controllers/item_details_controller.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class subCategoryCard extends StatefulWidget {
  SubcategoryModel item;
  subCategoryCard({required this.item});

  @override
  State<subCategoryCard> createState() => _subCategoryCardState();
}

class _subCategoryCardState extends State<subCategoryCard> {
  bool details = false;
  final controller = Get.find<CategoriesController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: details ? mainColor.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                details = !details;
              });
            },
            child: Row(
              children: [
                Expanded(
                  child: label(
                    text: widget.item.name ?? '',
                      color: details ? Colors.white : mainColor,

                  ),
                ),
                Icon(
                  details ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: details ? Colors.white : semiGrey,
                ),
              ],
            ),
          ),
          if (details)
            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.ITEM_FILTERS, arguments: {
                          'category_id': controller.categoryId.value,
                          'subcategory_id': widget.item.id,
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey,
                        ),
                        child: labelStyle(
                          text: 'All'.tr,
                          style: Styles().normal.copyWith(
                            color: mainColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // عرض جميع الفئات الفرعية مع زيادة المسافة بين العناصر
                  ...widget.item.childcategory!.map((e) {
                    return WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0), // زيادة المسافة بين الفئات الفرعية
                        child: InkWell(
                          onTap: () {
                            Get.delete<ItemDetailsController>();
                            Get.toNamed(Routes.ITEM_FILTERS, arguments: {
                              'category_id': controller.categoryId.value,
                              'subcategory_id': widget.item.id,
                              'childcategory_id': e.id,
                            }, preventDuplicates: false);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                              color: semiGrey.withOpacity(0.1),
                            ),
                            child: labelStyle(
                              text: e.name ?? '',
                              style: Styles().normal.copyWith(
                                color: mainColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

