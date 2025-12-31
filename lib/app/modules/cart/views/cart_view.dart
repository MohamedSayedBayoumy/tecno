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
// HIDDEN: Unused import - commented out as per requirements
// import '../widgets/bill_cart_view_widget.dart';
import '../widgets/card_footer_widget.dart';
import '../../checkOut/controllers/check_out_controller.dart';
// HIDDEN: Unused import - commented out as per requirements
// import '../../checkOut/widgets/address_check_out_widget.dart';

class CartView extends GetView<CartController> {
  CartView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize checkout data when view is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final checkoutCtrl = Get.find<CheckOutController>();
      if (checkoutCtrl.paymentMethods.isEmpty) {
        checkoutCtrl.getPaymentMethods();
      }
      checkoutCtrl.getProfile();
    });
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
                                // CHANGED: Instead of navigating to checkout, call placeOrder directly
                                // path: Routes.CHECK_OUT,
                                onTap: () => _handleCheckout(context),
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
                                        // HIDDEN: Order details widget - commented out as per requirements
                                        // BillCartViewWidget()
                                        sizer(),
                                        // HIDDEN: Address status widget - commented out as per requirements
                                        // _buildAddressStatusWidget(),
                                        sizer(),
                                        // Payment methods widget
                                        _buildPaymentOptionsWidget(),
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

  // HIDDEN: Address status widget - commented out as per requirements
  // Widget _buildAddressStatusWidget() {
  //   final checkoutCtrl = Get.find<CheckOutController>();
  //   return Obx(
  //     () => Container(
  //       padding: const EdgeInsets.all(10),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(10),
  //         border: Border.all(
  //           color: checkoutCtrl.haveMissingAddressData.value
  //               ? Colors.red.shade700
  //               : Colors.grey.shade200,
  //         ),
  //       ),
  //       child: InkWell(
  //         onTap: () {
  //           Get.toNamed(Routes.ADDADDRESSES, arguments: true)!.then((result) {
  //             if (result == true) {
  //               checkoutCtrl.getData();
  //             }
  //           });
  //         },
  //         child: Row(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Icon(
  //               Icons.location_on,
  //               color: checkoutCtrl.haveMissingAddressData.value
  //                   ? Colors.red.shade700
  //                   : Colors.black,
  //             ),
  //             const SizedBox(width: 8),
  //             Expanded(
  //               child: Text(
  //                 checkoutCtrl.haveMissingAddressData.value
  //                     ? "must_complete_address".tr
  //                     : "${"receive_place".tr}: ${checkoutCtrl.shippingInfo}",
  //                 style: Styles.styleBold15.copyWith(
  //                   color: checkoutCtrl.haveMissingAddressData.value
  //                       ? Colors.red.shade700
  //                       : Colors.black,
  //                 ),
  //               ),
  //             ),
  //             Text(
  //               checkoutCtrl.haveMissingAddressData.value
  //                   ? "complete".tr
  //                   : "change".tr,
  //               style: Styles.styleBold15.copyWith(
  //                 color: checkoutCtrl.haveMissingAddressData.value
  //                     ? Colors.red.shade700
  //                     : Colors.black,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Payment options widget (moved from check_out_view.dart)
  Widget _buildPaymentOptionsWidget() {
    final checkoutCtrl = Get.find<CheckOutController>();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Text(
            "Payment Method".tr,
            style: Styles.styleExtraBold18,
          ),
          const SizedBox(height: 8),
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: checkoutCtrl.paymentMethods.length,
              itemBuilder: (context, index) {
                final payment = checkoutCtrl.paymentMethods[index];
                return _buildPaymentOption(
                  key: UniqueKey(),
                  title: payment.name!,
                  description: payment.text!,
                  value: payment.id.toString(),
                  image: payment.photo ?? '',
                  isSelected: checkoutCtrl.paymentMethod.value ==
                      payment.id.toString(),
                  onSelected: () {
                    checkoutCtrl.selectPaymentMethod(payment.id.toString());
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Payment option widget (moved from check_out_view.dart)
  Widget _buildPaymentOption({
    required String title,
    required String description,
    required String value,
    required String image,
    required bool isSelected,
    required VoidCallback onSelected,
    Key? key,
  }) {
    final checkoutCtrl = Get.find<CheckOutController>();
    return GestureDetector(
      onTap: onSelected,
      child: Obx(
        () => Container(
          key: key,
          child: Row(
            children: [
              Radio<String>(
                value: value,
                groupValue: checkoutCtrl.paymentMethod.value,
                activeColor: Colors.green,
                onChanged: (v) => onSelected(),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelStyle(text: title, style: Styles.styleSemiBold16),
                    labelStyle(
                      text: description,
                      style: Styles.styleRegular13,
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: kTextTabBarHeight * 1.5,
                  width: kTextTabBarHeight * 1.5,
                  child: Image.network(
                    image.isNotEmpty ? image : '',
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Handle checkout button tap
  void _handleCheckout(BuildContext context) {
    final checkoutCtrl = Get.find<CheckOutController>();
    
    // Check if address is complete
    if (checkoutCtrl.haveMissingAddressData.value == true) {
      Get.snackbar(
        'Error'.tr,
        "must_complete_address".tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
      return;
    }

    // Check if payment method is selected
    if (checkoutCtrl.paymentMethod.value.isEmpty) {
      Get.snackbar(
        'Error'.tr,
        'Please choose the payment method that suits you'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    // Place order directly
    checkoutCtrl.placeOrder(
      context: context,
      paymentMethodId: checkoutCtrl.paymentMethod.value,
      cart: checkoutCtrl.cartData,
    );
  }
}
