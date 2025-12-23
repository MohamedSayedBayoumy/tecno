import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/styles.dart';

class ReviewedViewWidget extends StatelessWidget {
  const ReviewedViewWidget({
    super.key,
    required this.text,
    required this.starCount,
    this.starSize = 30,
  });

  final String text;
  final int starCount, starSize;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${'your_review'.tr}:",
            style: Styles.styleBold15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (int i = 0; i < 5; i++) ...[
                Icon(
                  starCount > i
                      ? Icons.star_rate_rounded
                      : Icons.star_border_rounded,
                  color: starCount > i ? Colors.amber : Colors.grey,
                  size: starSize.toDouble(),
                )
              ]
            ],
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: Styles.styleRegular15,
          ),
        ],
      ),
    );
  }
}
