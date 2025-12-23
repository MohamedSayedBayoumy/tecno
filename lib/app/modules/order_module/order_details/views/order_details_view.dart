import 'package:customer/app/core/enum.dart';
import 'package:customer/app/core/widgets/inputs/custom_text_form_field.dart';
import 'package:customer/app/models/cart/order_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

import 'package:get/get.dart';

import '../../../../config/config.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widgets/buttons/custom_app_button.dart';
import '../../../../core/widgets/common/app_bar/custom_app_bar.dart';
import '../../../../core/widgets/common/custom_loading.dart';
import '../../../../core/widgets/common/sizer.dart';
import '../../../../core/widgets/labels/label_style.dart';
import '../controllers/order_details_controller.dart';
import '../widgets/item_summery_widget.dart';
import '../widgets/order_details_header_widget.dart';
import '../widgets/order_details_status.dart';

class OrderDetailsView extends GetView<OrderDetailsController> {
  const OrderDetailsView({super.key});

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
          return Column(
            children: [
              CustomAppBar(
                addSafeBottom: false,
                title: 'Order Details'.tr,
              ),
              sizer(),
              Expanded(
                child: Obx(() {
                  final item = controller.item.value;

                  return controller.loading.value
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : RefreshIndicator(
                          onRefresh: () async => controller.getOrderDetails(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ListView(
                              padding: EdgeInsets.zero,
                              children: [
                                // Text(
                                //   item!.toJson().toString(),
                                //   textAlign: TextAlign.end,
                                // ),
                                OrderDetailsStatusWidget(
                                  item: item!,
                                ),
                                sizer(),
                                OrderDetailsHeaderWidget(
                                  item: item,
                                ),
                                sizer(),
                                ItemSummeryWidget(item: item),
                                sizer(),
                                orderDetailsWidget(item),
                                sizer(),
                                if (controller.canCancel.value == true) ...[
                                  CustomAppButton(
                                    text: "cancel_order",
                                    color: Colors.transparent,
                                    borderColor: mainColor,
                                    style: Styles.styleBold15,
                                    action: () {
                                      controller.selectedOrder =
                                          controller.item.value;
                                      controller.update();
                                      _showBottomSheet(context, controller);
                                    },
                                  )
                                ],
                              ],
                            ),
                          ),
                        );
                }),
              ),
            ],
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
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 30),
            ],
          );
        }
      },
      child: const Center(
        child: CustomLoading(),
      ),
    ));
  }

  Container orderDetailsWidget(OrderDetailsModel item) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelStyle(
              text: 'Order Details'.tr,
              textAlign: TextAlign.end,
              style: Styles().subTitle),
          sizer(),
          receiptLabelString(
              label: 'payment method'.tr, value: item.paymentMethod!),
          sizer(),
          receiptLabel(
            label: 'Total Products'.tr,
            value: item.orderDetails
                .map((e) => double.parse(e.price ?? "0.0") * (e.quantity ?? 1))
                .toList()
                .map((e) => double.parse(e.toString()))
                .toList()
                .reduce((a, b) => a + b),
          ),
          sizer(),
          receiptLabel(
            label: 'Delivery Fee'.tr,
            value: (double.parse(item.shippingPrice!) ?? 0),
          ),
          const Divider(
            color: Colors.grey,
          ),
          receiptLabel(
              label: 'Total'.tr,
              isTitle: true,
              value: (double.parse(item.totalPrice!)) ?? 0),
        ],
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
            child: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: labelStyle(
              text: value == 0
                  ? 'Free'
                  : '${value.toString()} ${Config().currency}',
              style: Styles().normalCustom(
                  color: value == 0 ? Colors.green : Colors.black,
                  weight: isTitle ? FontWeight.bold : FontWeight.w600)),
        )),
      ],
    );
  }

  Widget receiptLabelString({
    required String label,
    required String value,
    bool isTitle = false,
  }) {
    return Row(
      children: [
        Expanded(child: labelStyle(text: label, style: Styles().normal)),
        Expanded(
            child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: labelStyle(
                    text: value,
                    style: Styles().normalCustom(
                        color: value == 0 ? Colors.green : Colors.black,
                        weight: isTitle ? FontWeight.bold : FontWeight.w600)))),
      ],
    );
  }
}

void _showBottomSheet(BuildContext context, OrderDetailsController controller) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
    ),
    builder: (context) {
      return Obx(
        () {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "cancel_order".tr,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "type_reason".tr,
                    style: Styles.styleMedium15
                        .copyWith(color: Colors.red.shade800),
                  ),
                  const SizedBox(height: 5),
                  CustomTextFormFieldWidget(
                    hint: "reason".tr,
                    controller: controller.cancelReason,
                    action: (p0) => p0,
                  ),
                  const SizedBox(height: 16),
                  if (controller.cancelStatus.value == Status.loading) ...[
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: CustomLoading(),
                      ),
                    ),
                  ] else ...[
                    Center(
                      child: CustomAppButton(
                        borderColor: Colors.red.shade800,
                        color: Colors.red.shade800,
                        text: "Apply",
                        action: () {
                          controller.cancelOrder();
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
