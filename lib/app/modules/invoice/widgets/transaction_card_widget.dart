import 'package:customer/app/core/constants/styles.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/common/custom_asset_image.dart';
import '../models/transaction_model.dart';
import 'time_transaction_widget.dart';

class TransactionCardWidget extends StatelessWidget {
  const TransactionCardWidget({
    super.key,
    required this.transaction,
  });
  final WalletTransaction transaction;
  @override
  Widget build(BuildContext context) {
    final isCredit = transaction.credit > 0;
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 10,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          CustomAssetsImage(
            imagePath: isCredit
                ? 'assets/images/new_version/paid_invoice.png'
                : 'assets/images/new_version/basil_invoice.png',
            width: 50,
            height: 50,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.client.isNotEmpty
                      ? transaction.client
                      : transaction.description,
                  style: Styles.styleSemiBold14,
                ),
                Text(
                  "#${transaction.code}",
                  style: Styles.styleRegular13.copyWith(color: Colors.grey),
                ),
                DateTimeInlineWidget(
                    dateText: transaction.date ?? '',
                    timeText: transaction.time ?? ''),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            decoration: BoxDecoration(
              color:
                  isCredit ? const Color(0xfff4f8ec) : const Color(0xffe8e8eb),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.grey.shade100),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100,
                  blurRadius: 10,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                Text(
                  transaction.total > 0
                      ? '${transaction.total}'
                      : '${transaction.credit}',
                  style: Styles.styleRegular15.copyWith(
                    color: const Color(0xff1c1c38),
                    fontFamily: 'number',
                  ),
                ),
                const SizedBox(width: 2),
                CustomAssetsImage(
                  imagePath: 'assets/images/SAR.png',
                  width: 15,
                  height: 15,
                  imageColor: isCredit
                      ? const Color(0xff95be3d)
                      : const Color(0xff1c1c38),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
