import 'package:get/get.dart';

import '../controllers/item_filters_controller.dart';

class ItemFiltersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ItemFiltersController>(
       ItemFiltersController(Get.arguments),
    );
  }
}
