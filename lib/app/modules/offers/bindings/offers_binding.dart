import 'package:get/get.dart';

import '../controllers/offers_controller.dart';

class OffersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OffersController>(
     OffersController(),
    );
  }
}
