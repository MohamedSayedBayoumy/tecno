
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/config.dart';
import '../../../../core/constants/styles.dart';
import '../../../../models/cart/order_details_model.dart';
import '../../../reviews/widgets/reviewed_view_widget.dart';

class ItemDetailsListWidget extends StatelessWidget {
  const ItemDetailsListWidget({
    super.key,
    required this.item,
  });

  final OrderDetail item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: FadeIn(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                item.photo!,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset("assets/no_image");
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
                item.itemName ?? "",
                style: Styles.styleBold15,
              ),
              const SizedBox(height: 5),
              Text(
                "${'count'.tr}: ${(item.quantity ?? 0).toString()}",
                style: Styles.styleRegular13,
              ),
              const SizedBox(height: 5),
              if (item.rating != null) ...[
                ReviewedViewWidget(
                  starCount: item.rating!.rating,
                  text: item.rating!.toJson()["review"],
                  starSize: 20,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: 5),
        Text(
          "${item.price} ${Config().currency}",
          style: Styles.styleRegular13.copyWith(color: Colors.grey.shade800),
        ),
      ],
    );
  }
}
