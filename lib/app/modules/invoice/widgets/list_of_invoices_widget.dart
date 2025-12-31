import 'package:customer/app/core/widgets/common/custom_empty_list_widget.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/invoice_controller.dart';
import 'transaction_card_widget.dart';

class ListOfInvoicesWidget extends StatelessWidget {
  const ListOfInvoicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InvoiceController>();
    return controller.walletStatementResponse?.transactions.isEmpty ?? true
        ? CustomEmptyList(title: "you haven't placed any invoices yet.".tr)
        : ListView.separated(
            itemCount:
                controller.walletStatementResponse?.transactions.length ?? 0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
            itemBuilder: (context, index) {
              return TransactionCardWidget(
                  onTap: () {
                    Get.toNamed(Routes.invoiceDetails,
                        arguments: controller
                            .walletStatementResponse!.transactions[index].id);
                  },
                  transaction:
                      controller.walletStatementResponse!.transactions[index]);
            },
          );
  }
}
