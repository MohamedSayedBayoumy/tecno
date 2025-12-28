import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';

class LastUpdateWidget extends StatelessWidget {
  const LastUpdateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xfff3f3f4),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.refresh,
              color: mainColor,
              size: 20,
            ),
            const SizedBox(width: 5),
            Text(
              "last_updated_minutes_ago".tr.replaceAll("{minutes}", "3"),
              style: Styles.styleRegular13.copyWith(color: mainColor),
            ),
          ],
        ),
      ),
    );
  }
}
