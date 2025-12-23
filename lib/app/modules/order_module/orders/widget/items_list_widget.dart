import 'package:animate_do/animate_do.dart';
import 'package:customer/app/core/widgets/buttons/custom_app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/config.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/utils.dart';
import '../../../../core/widgets/common/sizer.dart';
import '../../../../models/cart/order_details_model.dart';
import '../../../reviews/controllers/reviews_controller.dart';
import '../../../reviews/widgets/rate_bottom_sheet.dart';
import '../../../reviews/widgets/reviewed_view_widget.dart';

class ItemListWidget extends StatelessWidget {
  const ItemListWidget({
    super.key,
    required this.order,
    required this.showRate,
  });

  final OrderDetailsModel order;
  final bool showRate;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Colors.grey.shade300,
      ),
      itemCount: order.orderDetails.length,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final productItem = order.orderDetails[index];
        return Row(
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: FadeIn(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    productItem.photo!,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset("name");
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productItem.itemName ?? "",
                    style: Styles.styleBold15.copyWith(
                      fontFamily: AppUtils.isArabic(productItem.itemName ?? "a")
                          ? "ar_family"
                          : "en_family",
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${'count'.tr}: ${(productItem.quantity ?? 0).toString()}",
                    style: Styles.styleRegular13,
                  ),
                  if (showRate == true) ...[
                    if (productItem.rating != null) ...[
                      const SizedBox(height: 5),
                      ReviewedViewWidget(
                        starCount: productItem.rating!.rating,
                        text: productItem.rating!.review,
                        starSize: 20,
                      ),
                    ],
                  ],
                ],
              ),
            ),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${productItem.price} ${Config().currency}",
                  style: Styles.styleMedium15
                      .copyWith(color: Colors.grey.shade800),
                ),
                if (showRate == true) ...[
                  if (productItem.rating == null) ...[
                    const SizedBox(height: 10),
                    CustomAppButton(
                      width: 80,
                      height: 30,
                      text: "rate_item",
                      action: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (context) {
                            return RateBottomSheet(
                              title: "rate_item_title",
                              onSubmit: (rate, review) {
                                Get.find<ReviewsController>().rateItem(
                                  orderId: order.id,
                                  rate: rate,
                                  text: review,
                                  itemId: productItem.itemId,
                                );
                              },
                            );
                          },
                        );
                      },
                    )
                  ]
                ]
              ],
            ),
          ],
        );
      },
    );
  }
}
