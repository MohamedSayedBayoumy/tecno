import 'package:get/get.dart';

class InvoiceController extends GetxController {
  String selectedInvoiceType = "all";

  void selectInvoiceType(String type) {
    selectedInvoiceType = type;
    update();
  }
}
