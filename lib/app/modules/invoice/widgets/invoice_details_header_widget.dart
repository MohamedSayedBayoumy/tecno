import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../models/transaction_details_model.dart';
import 'package:get/get.dart';

class InvoiceDetailsHeaderWidget extends StatelessWidget {
  final TransactionData data;
  const InvoiceDetailsHeaderWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "INVOICE".tr,
                    style: Styles.styleBold16.copyWith(color: Colors.black),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    data.code,
                    style: Styles.styleRegular14.copyWith(color: Colors.grey),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "BILL TO".tr,
                    style: Styles.styleSemiBold12.copyWith(color: Colors.black),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    data.client,
                    style: Styles.styleBold14.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.date,
                style: Styles.styleRegular13.copyWith(color: Colors.white70),
              ),
              if (data.status != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    data.status!.tr,
                    style: Styles.styleSemiBold10.copyWith(color: Colors.black),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
