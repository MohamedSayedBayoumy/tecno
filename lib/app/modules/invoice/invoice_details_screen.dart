import 'package:customer/app/modules/invoice/controllers/invoice_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart  ';



class InvoiceDetailsScreen extends StatelessWidget {
  const InvoiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoiceController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text('Invoice Details'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('Invoice Details'),
        ),
      ),
    );
  }
}