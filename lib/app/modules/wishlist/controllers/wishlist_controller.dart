import 'package:customer/app/data/online/data_parser.dart';
import 'package:customer/app/models/product/wish_list_model.dart';
import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';

class WishlistController extends GetxController {
  final homeCTRL = Get.find<HomeController>();
  final wishlist = Get.find<HomeController>().wishList;
  // final wishList = <WishListModel>[].obs;
  @override
  void onInit() {
    homeCTRL.getWishList();
    super.onInit();

  }

  // void getWishList() async {
  //   wishList.value = await DataParser().getWishList();
  // }


}
