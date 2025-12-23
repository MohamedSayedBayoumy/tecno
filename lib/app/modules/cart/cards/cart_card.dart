import 'package:customer/app/config/config.dart';
import 'package:customer/app/core/constants/colors.dart';
import 'package:customer/app/core/constants/styles.dart';
import 'package:customer/app/core/widgets/common/sizer.dart';
import 'package:customer/app/core/widgets/labels/label_style.dart';
import 'package:customer/app/models/cart/cart_data.dart';
import 'package:customer/app/modules/cart/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable, camel_case_types
class cartCard extends StatefulWidget {
  CartItem item;
  cartCard({super.key, required this.item});

  @override
  State<cartCard> createState() => _cartCardState();
}

class _cartCardState extends State<cartCard> {
  int count = 1;
  bool showNumbers = false;
  final controller = Get.find<CartController>();

  @override
  void initState() {
    count = widget.item.qty ?? 1;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                    height: kTextTabBarHeight * 2,
                    width: kTextTabBarHeight * 2,
                    child: Image.network(widget.item.item?.photo ?? '')),
              ),
              sizer(),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  labelStyle(
                      text: widget.item.item?.name ?? '',
                      style: Styles().normalCustom(
                          color: Colors.black, weight: FontWeight.w700)),
                  labelStyle(
                      text: widget.item.item?.details ?? '',
                      style: Styles().normal),
                  Row(
                    children: [
                      labelStyle(
                          text:
                              '${widget.item.item?.discountPrice ?? 0} ${Config().currency}',
                          style: Styles().normalCustom(
                              color: Colors.black, weight: FontWeight.bold)),
                      sizer(),
                      widget.item.item?.previousPrice != null
                          ? Expanded(
                              child: Row(
                                children: [
                                  labelStyle(
                                      text:
                                          '${widget.item.item?.previousPrice ?? 0}',
                                      style: Styles().normalCustom(
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough)),
                                  sizer(),
                                  labelStyle(
                                      text:
                                          '${discountRatio(item: widget.item)}% OFF',
                                      style: Styles().normalCustom(
                                          color: Colors.green,
                                          weight: FontWeight.w700))
                                ],
                              ),
                            )
                          : const SizedBox()
                    ],
                  ),
                  // sizer(),
                  // labelStyle(
                  //     text: '${item.cartOptions['price']}', style: styles().normal),
                ],
              ))
            ],
          ),
          sizer(),
          Row(
            children: [
              InkWell(
                onTap: () {
                  showNumbers = !showNumbers;
                  setState(() {});
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      labelStyle(
                          text: count.toString(),
                          style: Styles().smallCustomized(
                              color: Colors.black, weight: FontWeight.w600)),
                      Icon(
                        showNumbers
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ),
              sizer(),
              InkWell(
                onTap: () {
                  controller.deleteCartItem(id: widget.item.id ?? 0);
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.delete_outline,
                        color: Colors.grey,
                        size: 14,
                      ),
                      labelStyle(
                          text: 'Remove'.tr,
                          style: Styles().smallCustomized(
                              color: Colors.grey, weight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          sizer(),
          showNumbers
              ? SizedBox(
                  height: 30,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            count = (index + 1);
                            CartItem item = widget.item;
                            item.qty = count;
                            controller.updateCartItem(item: item);
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: count == (index + 1)
                                        ? mainColor
                                        : Colors.grey),
                                borderRadius: BorderRadius.circular(5)),
                            child: labelStyle(
                                text: (index + 1).toString(),
                                style: Styles().normalCustom(
                                    color: count == (index + 1)
                                        ? mainColor
                                        : Colors.grey,
                                    weight: FontWeight.w600)),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => sizer(),
                      itemCount: widget.item.item?.stock ?? 0),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  int discountRatio({
    required CartItem item,
  }) {
    double discount =
        (item.item?.previousPrice!.toDouble() ?? 0) - (item.item?.discountPrice ?? 0);
    return ((discount / (item.item?.previousPrice ?? 1)) * 100).toInt();
  }
}
