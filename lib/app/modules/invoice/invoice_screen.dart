import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/styles.dart';
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
          return const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InvoiceHeaderWidget(),
                SizedBox(height: 10),
                AllTransactionsHeaderWidget(),
                ListOfInvoicesWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}
 
