import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/enum.dart';
import '../../core/widgets/common/custom_failed_widget.dart';
import '../../core/widgets/common/custom_loading.dart';
import 'controllers/invoice_controller.dart';
import 'widgets/all_transactions_header_widget.dart';
import 'widgets/invoice_header_widget.dart';
import 'widgets/list_of_invoices_widget.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  // "Invoices": "الفواتير",

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<InvoiceController>(
        builder: (controller) {
          switch (controller.status) {
            case Status.loading:
              return const Center(child: CustomLoading());
            case Status.loaded:
              return const SingleChildScrollView(
                child: Column(
                  children: [
                    InvoiceHeaderWidget(),
                    SizedBox(height: 10),
                    AllTransactionsHeaderWidget(),
                    ListOfInvoicesWidget(),
                  ],
                ),
              );
            case Status.fail:
              return CustomFailedWidget(
                onTap: () {
                  controller.getInvoices();
                },
              );
          }
        },
      ),
    );
  }
}
