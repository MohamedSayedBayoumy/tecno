import 'package:customer/app/core/constants/assets.dart';
import 'package:customer/app/core/constants/colors.dart';
import 'package:customer/app/core/widgets/buttons/custom_app_button.dart';
import 'package:customer/app/core/widgets/common/app_bar/custom_app_bar.dart';
import 'package:customer/app/modules/home/widgets/product_item_widget.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

import 'package:get/get.dart';

import '../controllers/wishlist_controller.dart';

class WishlistView extends GetView<WishlistController> {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        List<ConnectivityResult> connectivity,
        Widget child,
      ) {
        final bool connected = !connectivity.contains(ConnectivityResult.none);
        if (connected) {
          return Obx(
            () => RefreshIndicator(
              onRefresh: () {
                controller.homeCTRL.getWishList();
                return Future.value();
              },
              child: Column(
                children: [
                  CustomAppBar(
                    title: "Wishlist",
                    addSafeBottom: false,
                  ),
                  Expanded(
                    child: controller.homeCTRL.wishList.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: Image.asset(AppAssets.wish),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "add_to_wish_text".tr,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "add_to_wish_text2".tr,
                              ),
                              const SizedBox(height: 30),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Center(
                                  child: CustomAppButton(
                                      action: () {
                                        Get.toNamed(Routes.BOTTOMSHEET);
                                      },
                                      text: "Add To Wish".tr,
                                      color: mainColor),
                                ),
                              )
                            ],
                          )
                        : GridView.builder(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 10,
                            ),
                            itemCount: controller.homeCTRL.wishList.length,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 310,
                            ),
                            itemBuilder: (context, index) {
                              final item = controller.homeCTRL.wishList[index];
                              return ProductItemWidget(item: item);
                            },
                          ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                // ignore: avoid_unnecessary_containers
                child: Container(
                  child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.asset(AppAssets.noConnection)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "check internet connection".tr,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 30),
            ],
          );
        }
      },
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ));
  }
}
