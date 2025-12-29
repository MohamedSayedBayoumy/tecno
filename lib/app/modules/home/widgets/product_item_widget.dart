import 'package:customer/app/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/config.dart';
import '../../../core/constants/sizes.dart';
import '../../../models/product/item.dart';
import '../../../routes/app_pages.dart';
import '../../item_details/controllers/item_details_controller.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key, required this.item});

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.delete<ItemDetailsController>();
        Get.toNamed(Routes.ITEM_DETAILS,
            arguments: item.id, preventDuplicates: false);
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          width: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 230,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(AppSizes.borderRadius),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(item.photo!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if ((item.stock ?? 0) == 0) ...[
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(AppSizes.borderRadius)),
                            color: Colors.black54),
                        child: Center(
                          child: Text(
                            "Out of Stock".tr,
                            style: Styles.styleExtraBold25
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ]
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name ?? "",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    if (item.sortDetails?.isNotEmpty ?? false) ...[
                      Text(
                        item.sortDetails ?? "",
                        style: TextStyle(color: Colors.grey[700], fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                    ],
                    // Text(
                    //   '${item.previousPrice == 0 ? item.price : item.previousPrice} ${Config().currency}',
                    //   maxLines: 1,
                    //   style: const TextStyle(fontWeight: FontWeight.bold),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
