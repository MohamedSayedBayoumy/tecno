import 'package:get/get.dart';

import '../../../core/enum.dart';
import '../../../data/online/DioRequest.dart';
import '../../../data/online/end_points.dart';
import '../models/transaction_model.dart';

class InvoiceController extends GetxController {
  String selectedInvoiceType = "all";

  Status status = Status.loading;

  void selectInvoiceType(String type) {
    selectedInvoiceType = type;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getInvoices();
  }

  WalletStatementResponse? walletStatementResponse;

  getInvoices() async {
    status = Status.loading;
    update();
    try {
      final response =
          await getRequest(urlExt: "/transactions", requireToken: true);
      print(">>>>>>>> response ${response.data}");
      walletStatementResponse = WalletStatementResponse.fromJson(response.data);
      status = Status.loaded;
      update();
    } on Exception catch (e) {
      status = Status.fail;
      update();
    }
  }
}
