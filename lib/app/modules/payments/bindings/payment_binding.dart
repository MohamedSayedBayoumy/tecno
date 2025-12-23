import 'package:get/get.dart';

import '../controllers/payment_controller.dart';

class PaymentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PaymentsController>(PaymentsController());
  }
}
