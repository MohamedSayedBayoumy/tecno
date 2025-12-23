import 'package:get/get.dart';

import '../controllers/reviews_controller.dart';

class ReviewsBinding extends Bindings {
  final bool initValues;

  ReviewsBinding({this.initValues = true});

  @override
  void dependencies() {
    Get.put<ReviewsController>(ReviewsController(initValues: initValues));
  }
}
