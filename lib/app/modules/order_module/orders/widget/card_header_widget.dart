import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/widgets/labels/label_style.dart';
import '../../../../models/cart/order_details_model.dart';

class CardHeaderWidget extends StatelessWidget {
  const CardHeaderWidget({
    super.key,
    required this.item,
  });

  final OrderDetailsModel item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: labelStyle(
              text: '${'Order No.'.tr} ${item.id}',
              style: Styles.styleBold15),
        ),
        if (item.createdAt is DateTime) ...[
          Text(
            DateFormat('yyyy-MM-dd').format(item.createdAt!),
            style: Styles.styleRegular15
                .copyWith(color: const Color(0xff9B9B9B)),
          ),
        ] else ...[
          Text(
            item.createdAt!.toString(),
            style: Styles.styleRegular15
                .copyWith(color: const Color(0xff9B9B9B)),
          ),
        ]
      ],
    );
  }
}
