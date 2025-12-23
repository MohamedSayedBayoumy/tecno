import 'package:get/get.dart';

import '../controllers/policies_controller.dart';

class PoliciesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PoliciesController>(
        PoliciesController(),
    );
  }
}
