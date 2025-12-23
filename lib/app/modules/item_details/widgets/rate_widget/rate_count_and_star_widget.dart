import 'package:flutter/material.dart';

import '../../../../core/constants/styles.dart';

class RateCountAndStarWidget extends StatelessWidget {
  const RateCountAndStarWidget({super.key, this.totalRate, this.totalStar});

  final dynamic totalRate;
  final dynamic totalStar;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          totalRate?.toString() ?? "0",
          style: Styles.styleExtraBold25,
        ),
        Row(
          children: [
            for (int i = 0; i < 5; i++) ...[
              Icon(
                totalStar > i
                    ? Icons.star_rate_rounded
                    : Icons.star_border_rounded,
                color: totalStar > i ? Colors.amber : Colors.grey,
                size: 30,
              )
            ]
          ],
        )
      ],
    );
  }
}
