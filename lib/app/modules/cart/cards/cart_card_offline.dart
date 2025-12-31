// HIDDEN: Unused imports - commented out as per requirements
// import 'package:customer/app/config/config.dart';
import 'package:customer/app/core/constants/assets.dart';
import 'package:customer/app/core/constants/colors.dart';
import 'package:customer/app/core/constants/styles.dart';
import 'package:customer/app/core/widgets/common/sizer.dart';
import 'package:customer/app/core/widgets/labels/label_style.dart';
import 'package:customer/app/models/cart/cart_data.dart';
import 'package:customer/app/models/cart/cart_off_line_model.dart';
import 'package:customer/app/modules/cart/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// HIDDEN: Unused imports - commented out as per requirements
// import 'package:lottie/lottie.dart';
// import '../../../core/constants/app_assets.dart';

// ignore: must_be_immutable, camel_case_types
class CartCardOffline extends StatefulWidget {
  CartOffLineModel item;

  CartCardOffline({super.key, required this.item});

  @override
  State<CartCardOffline> createState() => _CartCardOfflineState();
}

class _CartCardOfflineState extends State<CartCardOffline> {
  int count = 1;
  bool showNumbers = false;
  final controller = Get.find<CartController>();

  @override
  void initState() {
    count = widget.item.quantity ?? 1;
    super.initState();
  }

  @override
  void didUpdateWidget(CartCardOffline oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.id != widget.item.id) {
      count = widget.item.quantity ?? 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200)),
        child: Column(children: [
          Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 180,
                width: 150,
                child: widget.item.image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.item.image!,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(AppAssets.noImage);
                          },
                          fit: BoxFit.contain,
                        ))
                    : Image.asset(AppAssets.noImage, fit: BoxFit.cover),
              ),
            ),
            sizer(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      labelStyle(
                          text: widget.item.name ?? '',
                          maxLines: 2,
                          style: Styles.styleRegular15
                              .copyWith(color: Colors.black)),
                      sizer(),
                      // HIDDEN: Price display - commented out as per requirements
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: labelStyle(
                      //           text:
                      //               '${widget.item.price ?? 0} ${Config().currency}',
                      //           maxLines: 5,
                      //           style: Styles.styleBold15
                      //               .copyWith(color: Colors.black)),
                      //     ),
                      //     if (widget.item.shippingPrice != "0.0") ...[
                      //       const SizedBox(width: 5.0),
                      //       Expanded(
                      //         flex: 2,
                      //         child: Container(
                      //           padding:
                      //               const EdgeInsets.symmetric(vertical: 5),
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(6),
                      //             border: Border.all(
                      //               color: Colors.amber.shade700,
                      //               width: .5,
                      //             ),
                      //           ),
                      //           child: Row(
                      //             children: [
                      //               Lottie.asset(
                      //                 Assets
                      //                     .assetsImagesNewVersionPackageDelivery,
                      //                 width: 50.0,
                      //               ),
                      //               const SizedBox(width: 2.0),
                      //               Expanded(
                      //                 child: Text(
                      //                   'shipping_extra_desc'.trParams({
                      //                     'fee': widget.item.shippingPrice
                      //                         .toString(),
                      //                   }),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ],
                      // ),
                    ],
                  ),
                  sizer(),
                  widget.item.options != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ...widget.item.options!.attribute!.names!
                                    .map((option) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Row(
                                      children: [
                                        Text(
                                            "$option :" ??
                                                '', // Adjust based on the option structure
                                            style: Styles().normal),
                                      ],
                                    ),
                                  );
                                }),
                                ...widget.item.options!.attribute!.optionName!
                                    .map((option) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Row(
                                      children: [
                                        Text(
                                            " $option " ??
                                                '', // Adjust based on the option structure
                                            style: Styles().normal),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            )
                          ],
                        )
                      : const Text(""),
                  const Divider(
                    color: Colors.grey,
                  ),
                  counterWidget(),
                ],
              ),
            )
          ])
        ]));
  }

  Row counterWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  if (count != widget.item.stock) {
                    ++count;
                    CartOffLineModel item = widget.item;
                    item.quantity = count;
                    controller.updateCartItemOffLine(
                        id: item.id!, quantity: item.quantity!);

                    setState(() {});
                  } else {
                    Get.snackbar(
                      'stock'.tr,
                      "${'no_more_on_stock'.tr} ${widget.item.stock}",
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: mainColor.withOpacity(0.8),
                      colorText: Colors.white,
                      duration: const Duration(seconds: 5),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Icon(
                    Icons.add,
                    size: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: labelStyle(
                      text: count.toString(), style: Styles.styleRegular15),
                ),
              ),
              InkWell(
                onTap: () {
                  if (count != 1) {
                    --count;
                    CartOffLineModel item = widget.item;
                    item.quantity = count;
                    controller.updateCartItemOffLine(
                        id: item.id!, quantity: item.quantity!);

                    setState(() {});
                  } else {}
                },
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Icon(
                    Icons.minimize,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            controller.deleteCartItem(id: widget.item.id ?? 0);
          },
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: Colors.red.shade800,
                borderRadius: BorderRadius.circular(5)),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
              size: 15,
            ),
          ),
        ),
      ],
    );
  }

  int discountRatio({
    required CartItem item,
  }) {
    double discount = (item.item?.previousPrice!.toDouble() ?? 0) -
        (item.item?.discountPrice ?? 0);
    return ((discount / (item.item?.previousPrice ?? 1)) * 100).toInt();
  }
}
