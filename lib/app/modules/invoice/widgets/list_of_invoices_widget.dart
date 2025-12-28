import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/invoice_controller.dart';
import 'transaction_card_widget.dart';

class ListOfInvoicesWidget extends StatelessWidget {
  const ListOfInvoicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InvoiceController>();
    return ListView.separated(
      itemCount: controller.walletStatementResponse?.transactions.length ?? 0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
      itemBuilder: (context, index) {
        return TransactionCardWidget(
            transaction:
                controller.walletStatementResponse!.transactions[index]);
      },
    );
  }
}
