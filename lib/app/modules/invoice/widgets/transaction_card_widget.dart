import 'package:flutter/material.dart';

import '../../../core/widgets/common/custom_asset_image.dart';
import 'time_transaction_widget.dart';

class TransactionCardWidget extends StatelessWidget {
  const TransactionCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
      // assets/images/new_version/paid_invoice.png
      child: Row(
        children: [
          const CustomAssetsImage(
            imagePath: 'assets/images/new_version/basil_invoice.png',
            width: 50,
            height: 50,
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Invoice 1234567890'),
                DateTimeInlineWidget(
                    dateText: '12/2/2023', timeText: '20:12 AM'),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            decoration: BoxDecoration(
              // #f4f8ec
              color: const Color(0xffe8e8eb),
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
            child: const Text('123'),
          )
        ],
      ),
    );
  }
}
