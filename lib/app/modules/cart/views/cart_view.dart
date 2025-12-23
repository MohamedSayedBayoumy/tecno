import 'package:customer/app/config/config.dart';
import 'package:customer/app/core/constants/assets.dart';
import 'package:customer/app/core/constants/colors.dart';
import 'package:customer/app/core/constants/styles.dart';
import 'package:customer/app/core/widgets/buttons/custom_app_button.dart';
import 'package:customer/app/core/widgets/common/app_bar/custom_app_bar.dart';
import 'package:customer/app/core/widgets/common/sizer.dart';
import 'package:customer/app/core/widgets/labels/label_style.dart';
import 'package:customer/app/modules/cart/cards/cart_card_offline.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../widgets/bill_cart_view_widget.dart';
import '../widgets/card_footer_widget.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        List<ConnectivityResult> connectivity,
        Widget child,
      ) {
        final bool connected = !connectivity.contains(ConnectivityResult.none);
        if (connected) {
          return Obx(
            () {
              final profile = controller.homeCTRL.profile.value;
              return profile == null
                  ? Scaffold(
                      bottomNavigationBar: SizedBox(
                        height: double.infinity,
                        child: Stack(
                          children: [
                            Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: Image.asset(AppAssets.login),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "text_login".tr,
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "text_login2".tr,
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                child: CustomAppButton(
                                  action: () {
                                    Get.toNamed(Routes.SIGN_IN);
                                  },
                                  text: "Login".tr,
                                  color: mainColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Scaffold(
                      bottomNavigationBar: Obx(
                        () => controller.data.value.isEmpty ?? true
                            ? SizedBox(
                                height: double.infinity,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Center(
                                              child: Container(
                                                child: SizedBox(
                                                    width: 200,
                                                    height: 200,
                                                    child: Image.asset(
                                                        AppAssets.addCart)),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "add_to_cart_text".tr,
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "add_to_cart_text2".tr,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : CartFooterWidget(
                                path: Routes.CHECK_OUT,
                              ),
                      ),
                      body: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Obx(
                          () => controller.loading.value
                              ? const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                )
                              : controller.data.value.isEmpty ?? false
                                  ? const SizedBox()
                                  : Column(
                                      children: [
                                        CustomAppBar(
                                          title: "Cart",
                                          showCart: false,
                                        ),
                                        sizer(),
                                        Expanded(
                                          child: RefreshIndicator(
                                            onRefresh: () async =>
                                                controller.getData(),
                                            child: Obx(
                                              () => ListView.separated(
                                                  shrinkWrap: true,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0.0),
                                                  itemBuilder:
                                                      (context, index) {
                                                    final item = controller
                                                        .data.value[index];
                                                    return CartCardOffline(
                                                        item: item);
                                                  },
                                                  separatorBuilder:
                                                      (index, context) =>
                                                          sizer(),
                                                  itemCount: controller
                                                          .data.value.length ??
                                                      0),
                                            ),
                                          ),
                                        ),
                                        const Divider(
                                          color: Colors.grey,
                                        ),
                                        BillCartViewWidget()
                                      ],
                                    ),
                        ),
                      ),
                    );
            },
          );
        } else {
          return Scaffold(
            body: Column(
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
            ),
          );
        }
      },
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget receiptLabel({
    required String label,
    required double value,
    bool isTitle = false,
  }) {
    return Row(
      children: [
        Expanded(child: labelStyle(text: label, style: Styles().normal)),
        Expanded(
            child: labelStyle(
                text: '${value.toString()} ${Config().currency}',
                style: Styles().normalCustom(
                    color: Colors.black,
                    weight: isTitle ? FontWeight.bold : FontWeight.w600))),
      ],
    );
  }
}
