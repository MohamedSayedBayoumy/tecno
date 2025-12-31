import 'package:customer/app/core/constants/colors.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/styles.dart';
import '../models/transaction_details_model.dart';
import 'package:get/get.dart';

class InvoiceItemsTableWidget extends StatelessWidget {
  final List<TransactionItem> items;
  const InvoiceItemsTableWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.mainColor,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            children: [
              SizedBox(
                width: 40,
                child: Text(
                  "QTY".tr,
                  style: Styles.styleBold11.copyWith(color: Colors.white),
                ),
              ),
              Expanded(
                child: Text(
                  "ITEM".tr,
                  style: Styles.styleBold11.copyWith(color: Colors.white),
                ),
              ),
              Text(
                "PRICE".tr,
                style: Styles.styleBold11.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (context, index) =>
              Divider(color: Colors.grey.shade200, height: 1),
          itemBuilder: (context, index) {
            final item = items[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: Text(
                      "${item.qty}",
                      style:
                          Styles.styleRegular14.copyWith(fontFamily: 'number'),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item.name,
                      style: Styles.styleSemiBold14,
                    ),
                  ),
                  Text(
                    "${item.price}",
                    style: Styles.styleBold14.copyWith(fontFamily: 'number'),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
