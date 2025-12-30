import 'package:get/get.dart';

import '../../../core/enum.dart';
import '../../../data/online/DioRequest.dart';
import '../../../data/online/end_points.dart';
import '../models/transaction_model.dart';

class InvoiceController extends GetxController {
  String selectedInvoiceType = "all";

  Status status = Status.loading;

  DateTime? fromDate;
  DateTime? toDate;

  void selectInvoiceType(String type) {
    selectedInvoiceType = type;
    update();
  }

  @override
  void onInit() {
    print(">>> InvoiceController initialized");
    super.onInit();
    getInvoices();
  }

  WalletStatementResponse? walletStatementResponse;

  getInvoices({DateTime? from, DateTime? to}) async {
    print(">>> getInvoices called. status: loading");
    status = Status.loading;
    update();
    try {
      Map<String, dynamic> params = {};
      if (from != null) {
        params['from_date'] =
            "${from.year}-${from.month.toString().padLeft(2, '0')}-${from.day.toString().padLeft(2, '0')}";
      }
      if (to != null) {
        params['to_date'] =
            "${to.year}-${to.month.toString().padLeft(2, '0')}-${to.day.toString().padLeft(2, '0')}";
      }

      final response = await getRequest(
          urlExt: "/transactions", requireToken: true, params: params);
      print(">>>>>>>> response ${response.data}");
      if (response.data['status'] == true && response.data['data'] != null) {
        try {
          walletStatementResponse =
              WalletStatementResponse.fromJson(response.data['data']);
        } catch (e) {
          print("Error parsing WalletStatementResponse: $e");
          status = Status.fail;
          update();
          return;
        }
      }
      status = Status.loaded;
      update();
    } catch (e) {
      print("Error fetching invoices: $e");
      status = Status.fail;
      update();
    }
  }

  void applyFilter({DateTime? from, DateTime? to}) {
    fromDate = from;
    toDate = to;
    getInvoices(from: from, to: to);
  }

  void resetFilter() {
    fromDate = null;
    toDate = null;
    getInvoices();
  }
}
