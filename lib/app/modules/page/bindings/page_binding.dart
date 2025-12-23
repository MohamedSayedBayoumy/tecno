

import 'package:customer/app/modules/page/controllers/page_controller.dart';
import 'package:get/get.dart';


class PageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PageDataController>(
  PageDataController(id: Get.arguments),
    );
  }
}
