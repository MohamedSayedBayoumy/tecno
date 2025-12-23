import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/styles.dart';

class HeaderVendorWidget extends StatelessWidget {
  const HeaderVendorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mohmaed Sayed",
                style: Styles.styleBold15,
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Text(
                    "${"open_from".tr} ",
                    style: Styles.styleMedium13,
                  ),
                  Text(
                    "20 Jun 2025",
                    style: Styles.styleBold15,
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int i = 0; i < 5; i++) ...[
              const Icon(
                // Icons.star_border_rounded,
                Icons.star_rate_rounded,
                color: Colors.amber,
                // color: Colors.grey,
                size: 20,
              )
            ],
            Text(
              "34,77777",
              style: Styles.styleRegular10.copyWith(fontFamily: "en_family"),
            ),
          ],
        ),
      ],
    );
  }
}
