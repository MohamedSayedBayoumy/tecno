import 'package:customer/app/core/constants/assets.dart';
import 'package:customer/app/core/constants/styles.dart';
import 'package:customer/app/core/widgets/common/custom_loading.dart';
import 'package:customer/app/core/widgets/labels/label_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/common/chat_button.dart';
import '../../../core/widgets/dynamic/empty_list.dart';
import '../../home/widgets/product_item_widget.dart';
import '../controllers/item_filters_controller.dart';
import '../widgets/filter_search_widget.dart';

class ItemFiltersView extends GetView<ItemFiltersController> {
  const ItemFiltersView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: chatButton(),
        body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            List<ConnectivityResult> connectivity,
            Widget child,
          ) {
            final bool connected =
                !connectivity.contains(ConnectivityResult.none);
            if (connected) {
              return Column(
                children: [
                  const FilterSearchWidget(),
                  const SizedBox(height: 10),
                  Obx(() => controller.loadingSearch.value
                      ? const Column(
                          children: [
                            CustomLoading(),
                            SizedBox(height: 10),
                          ],
                        )
                      : const SizedBox()),
                  Expanded(
                    child: Obx(() => controller.loading.value
                        ? const CustomLoading()
                        : controller.items.isEmpty
                            ? const EmptyList(label: 'There is no products')
                            : GridView.builder(
                                shrinkWrap: true,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 310,
                                ),
                                itemCount: controller.items.length,
                                itemBuilder: (context, index) {
                                  final item = controller.items[index];
                                  return ProductItemWidget(item: item);
                                })),
                  ),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
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

  Widget filterButton() {
    return Container(
      width: kTextTabBarHeight * 1.5,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: mainColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.filter_alt_outlined,
            color: Colors.white,
          ),
          labelStyle(
              text: 'Filter'.tr,
              style: Styles().normalCustom(color: Colors.white)),
        ],
      ),
    );
  }

  Widget sortButton() {
    return Container(
      width: kTextTabBarHeight * 1.5,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: mainColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.sort,
            color: Colors.white,
          ),
          labelStyle(
              text: 'Sort'.tr,
              style: Styles().normalCustom(color: Colors.white)),
        ],
      ),
    );
  }
}
