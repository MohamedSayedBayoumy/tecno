import 'package:customer/app/core/constants/colors.dart' as AppColors;
import 'package:flutter/material.dart';
import '../../../core/constants/styles.dart';
import '../models/transaction_details_model.dart';
import 'package:get/get.dart';

class InvoiceTotalsWidget extends StatelessWidget {
  final TransactionData data;
  const InvoiceTotalsWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${"Total".tr}: ",
                style: Styles.styleBold16,
              ),
              Text(
                "${data.total}",
                style: Styles.styleBold18.copyWith(fontFamily: 'number'),
              ),
              const SizedBox(width: 5),
              Text("SAR".tr, style: Styles.styleBold14),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Balance Due".tr,
                style: Styles.styleBold16.copyWith(color: Colors.white),
              ),
              Text(
                "${data.total} ${"SAR".tr}",
                style: Styles.styleBold18
                    .copyWith(color: Colors.white, fontFamily: 'number'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
