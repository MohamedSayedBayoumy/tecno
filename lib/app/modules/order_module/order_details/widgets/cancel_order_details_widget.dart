import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/config.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widgets/common/sizer.dart';
import '../../../../core/widgets/labels/label_style.dart';
import '../../../../models/cart/order_details_model.dart';

class OrderDetailsWidget extends StatefulWidget {
  const OrderDetailsWidget({super.key, required this.orderDetail});

  final OrderDetail orderDetail;

  @override
  State<OrderDetailsWidget> createState() => _OrderDetailsWidgetState();
}

class _OrderDetailsWidgetState extends State<OrderDetailsWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: labelStyle(
                text: widget.orderDetail.itemName ?? '',
                maxLines: 3,
                style: Styles()
                    .normalCustom(color: Colors.black, weight: FontWeight.w700),
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
                onTap: () {
                  setState(() {
                    isSelected = !isSelected;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 18,
                  height: 18,
                  decoration: ShapeDecoration(
                    shape: CircleBorder(
                        side: BorderSide(
                            color: isSelected == true
                                ? Colors.red.shade800
                                : mainColor)),
                    color: isSelected == true
                        ? Colors.red.shade800
                        : Colors.transparent,
                  ),
                )),
          ],
        ),
        sizer(),
        Row(
          children: [
            labelStyle(
              text: '${widget.orderDetail.price ?? 0}',
              style: Styles.styleMedium18.copyWith(color: Colors.black),
            ),
            const SizedBox(width: 4),
            labelStyle(
              text: Config().currency,
              style: Styles.styleBold20.copyWith(color: Colors.black),
            ),
          ],
        ),
        if (isSelected == true) ...[
          FadeIn(
            child: Column(
              children: [
                const Divider(
                  thickness: 1,
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      "select_reason".tr,
                      style: Styles.styleMedium18,
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                      size: 20,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
