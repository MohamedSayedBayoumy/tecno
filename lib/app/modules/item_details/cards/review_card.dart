import 'package:customer/app/core/constants/styles.dart';
import 'package:customer/app/core/widgets/common/sizer.dart';
import 'package:customer/app/core/widgets/labels/label_style.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../models/product/item_details_model.dart';

class reviewCard extends StatelessWidget {
  ReviewModel item;
  reviewCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.star_rounded,
              color: mainColor,
            ),
            sizer(),
            labelStyle(
                text: '${item.rating}',
                style: Styles().normalCustom(color: mainColor))
          ],
        ),
        labelStyle(
            text: item.subject ?? '',
            style: Styles()
                .normalCustom(color: Colors.black, weight: FontWeight.bold)),
        labelStyle(text: item.review ?? '', style: Styles().normal),
      ],
    );
  }
}
