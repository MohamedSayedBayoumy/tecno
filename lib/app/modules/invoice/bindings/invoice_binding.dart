import 'dart:developer';

import 'package:get/get.dart';

import '../controllers/invoice_controller.dart';

class InvoiceBinding extends Bindings {
  @override
  void dependencies() {
     Get.put<InvoiceController>(InvoiceController());
  }
}
