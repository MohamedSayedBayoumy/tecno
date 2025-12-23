import 'package:customer/app/core/constants/assets.dart';
import 'package:customer/app/core/widgets/common/custom_loading.dart';
import 'package:customer/app/modules/order_module/orders/widget/_order_card_widget.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

import 'package:get/get.dart';

import '../../../../core/widgets/common/app_bar/custom_app_bar.dart';
import '../../../../core/widgets/common/custom_empty_list_widget.dart';
import '../../../../core/widgets/common/sizer.dart';
import '../controllers/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: "Orders",
        ),
        Expanded(
          child: OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              List<ConnectivityResult> connectivity,
              Widget child,
            ) {
              final bool connected =
                  !connectivity.contains(ConnectivityResult.none);
              if (connected) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Obx(() => RefreshIndicator(
                        onRefresh: () async {
                          controller.getData();
                        },
                        child: controller.loading.value
                            ? const Center(
                                child: CustomLoading(),
                              )
                            : controller.orders.value.isEmpty
                                ? const CustomEmptyList()
                                : ListView.separated(
                                    itemBuilder: (context, index) => InkWell(
                                          onTap: () => Get.toNamed(
                                              Routes.ORDER_DETAILS,
                                              arguments:
                                                  controller.orders[index].id),
                                          child: OrderCardWidget(
                                            item: controller.orders[index],
                                            showRate: false,
                                          ),
                                        ),
                                    separatorBuilder: (context, index) =>
                                        sizer(),
                                    itemCount: controller.orders.length),
                      )),
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
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                  ],
                );
              }
            },
            child: const Center(
              child: CustomLoading(),
            ),
          ),
        ),
      ],
    );
  }
}
