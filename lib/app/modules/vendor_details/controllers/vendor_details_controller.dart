import 'dart:developer';

import 'package:customer/app/data/online/data_parser.dart';
import 'package:customer/app/models/product/vendor_details_model.dart';
import 'package:get/get.dart';

class VendorDetailsController extends GetxController {
  int vendorId;
  VendorDetailsController(this.vendorId);
  final data = Rxn<VendorDetails>();
  final loading = RxBool(true);
  @override
  void onInit() {
    super.onInit();
    log("message");
  }

  void getData() async {
    data.value = await DataParser().getVendorDetails(vendorId: vendorId);
    loading.value = false;
  }

  double calculateTotalReviews() {
    double total = 0;
    final reviews = data.value?.reviews ?? [];
    for (var item in reviews) {
      total += item.rating ?? 0;
    }
    return (total / reviews.length);
  }
}
