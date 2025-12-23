import 'package:get/get.dart';

import '../../../../data/local/auth_info.dart';
import '../controllers/orders_controller.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    if ((LocalAuthInfo().readEmail() ?? "").isNotEmpty) {
      Get.put<OrdersController>(
        OrdersController(),
      );
    }
  }
}
