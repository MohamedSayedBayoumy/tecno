import 'package:customer/app/core/constants/assets.dart';
import 'package:customer/app/core/widgets/app_bars/title_app_bar.dart';
import 'package:customer/app/core/widgets/common/custom_loading.dart';
import 'package:customer/app/core/widgets/common/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

import 'package:get/get.dart';

import '../../../config/config.dart';
import '../../../core/constants/styles.dart';
import '../../../core/widgets/labels/label_style.dart';
import '../../cart/widgets/bill_cart_view_widget.dart';
import '../../cart/widgets/card_footer_widget.dart';
import '../controllers/check_out_controller.dart';
import '../widgets/address_check_out_widget.dart';

class CheckOutView extends GetView<CheckOutController> {
  const CheckOutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: titleAppbar(label: 'Checkout'.tr),
        bottomNavigationBar: Obx(
          () => controller.loading.value == true
              ? const SizedBox()
              : Opacity(
                  opacity: controller.haveMissingAddressData.value == true ||
                          controller.loading.value == true
                      ? .5
                      : 1,
                  child: CartFooterWidget(
                    onTap: () {
                      if (controller.loading.value == true) {
                        return;
                      }
                      if (controller.haveMissingAddressData.value == true) {
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
                      controller.placeOrder(
                        context: context,
                        paymentMethodId: controller.paymentMethod.value,
                        cart: controller.cartData,
                      );
                    },
                  ),
                ),
        ),
        body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            List<ConnectivityResult> connectivity,
            Widget child,
          ) {
            final bool connected =
                !connectivity.contains(ConnectivityResult.none);
            if (connected) {
              return Obx(
                () => controller.loading.value == true
                    ? const Center(
                        child: CustomLoading(),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: RefreshIndicator(
                          onRefresh: () async => controller.getData(),
                          child: Column(
                            children: [
                              AddressCheckoutWidget(controller: controller),
                              sizer(),
                              BillCartViewWidget(),
                              sizer(),
                              paymentOptions(),
                              sizer(),
                            ],
                          ),
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
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                ],
              );
            }
          },
          child: const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ));
  }

  Widget paymentOptions() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200)),
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
              // Adjust height to content
              physics: const NeverScrollableScrollPhysics(),
              // Prevents scrolling
              itemCount: controller.paymentMethods.length,
              itemBuilder: (context, index) {
                final payment = controller.paymentMethods[index];
                return paymentOption(
                  key: UniqueKey(),
                  // Ensures unique widget for each item
                  title: payment.name!,
                  description: payment.text!,
                  value: payment.id.toString(),
                  image: payment.photo ?? '',
                  isSelected:
                      controller.paymentMethod.value == payment.id.toString(),
                  onSelected: () {
                    controller.selectPaymentMethod(payment.id.toString());
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget paymentOption({
    required String title,
    required String description,
    required String value,
    required String image,
    required bool isSelected,
    required VoidCallback onSelected,
    Key? key,
  }) {
    return GestureDetector(
      onTap: onSelected, // Trigger selection on tap
      child: Obx(
        () => Container(
          key: key,
          child: Row(
            children: [
              Radio<String>(
                value: value,
                // Value of this radio option
                groupValue: controller.paymentMethod.value,
                activeColor: Colors.green,
                // Reactive value
                onChanged: (v) => onSelected(), // Trigger on change
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
                  ),
                ),
              ),
            ],
          ),
        ),
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
                text: value == 0
                    ? 'Free'
                    : '${value.toString()} ${Config().currency}',
                style: Styles().normalCustom(
                    color: value == 0 ? Colors.green : Colors.black,
                    weight: isTitle ? FontWeight.bold : FontWeight.w600))),
      ],
    );
  }
}
