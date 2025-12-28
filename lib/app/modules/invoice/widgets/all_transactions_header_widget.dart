import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';

class AllTransactionsHeaderWidget extends StatelessWidget {
  const AllTransactionsHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "transactions_history".tr,
              style: Styles.styleBold18.copyWith(color: mainColor),
            ),
          ),
          // Expanded(
          //   child: InkWell(
          //     onTap: () {},
          //     overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: [
          //         Text(
          //           "all_transactions".tr,
          //           style: Styles.styleRegular13.copyWith(color: mainColor),
          //         ),
          //         const SizedBox(width: 5),
          //         Icon(Icons.arrow_forward_ios, size: 15, color: mainColor),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
