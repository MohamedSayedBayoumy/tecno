import 'package:get/get.dart';

import '../controller/brands_controller.dart';

class BrandsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BrandsController>(BrandsController());
  }
}
