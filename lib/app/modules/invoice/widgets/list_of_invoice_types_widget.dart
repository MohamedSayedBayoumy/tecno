import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/invoice_controller.dart';
import 'invoice_type_widget.dart';

class ListOfInvoicesTypesWidget extends StatelessWidget {
  const ListOfInvoicesTypesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoiceController>(
      builder: (controller) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              InvoicesTypeWidget(
                isSelected: controller.selectedInvoiceType == "all",
                title: "all",
              ),
              const SizedBox(width: 10),
              InvoicesTypeWidget(
                isSelected: controller.selectedInvoiceType == "bills",
                imagePath: 'assets/images/invoice.png',
                title: "bills",
              ),
              const SizedBox(width: 10),
              InvoicesTypeWidget(
                isSelected: controller.selectedInvoiceType == "payments",
                imagePath: 'assets/images/invoice.png',
                title: "payments",
              ),
            ],
          ),
        );
      },
    );
  }
}
