import 'package:customer/app/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:customer/app/models/cart/order_details_model.dart' as order;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../config/config.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widgets/common/sizer.dart';
import '../../../../core/widgets/labels/label_style.dart';

class orderItemCard extends StatelessWidget {
  order.OrderDetail item;
  orderItemCard({required this.item});
  @override
  Widget build(BuildContext context) {
    print('item.photo ${item.photo}');
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                    height: kTextTabBarHeight * 2,
                    width: kTextTabBarHeight * 2,
                    child: Image.network(item.photo ?? '')),
              ),
              sizer(),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  labelStyle(
                      text: "${item.itemName} ${item.variantName ?? ""}",
                      style: Styles().normalCustom(
                          color: Colors.black, weight: FontWeight.w700)),
                  // labelStyle(
                  //     text: item.details ?? '', style: styles().normal),
                  Row(
                    children: [
                      labelStyle(
                          text:
                              '${item.price ?? 0} ${Config().currency}',
                          style: Styles().normalCustom(
                              color: Colors.black, weight: FontWeight.bold)),
                      sizer(),
                    ],
                  ),
                  labelStyle(
                      text:
                      '${'QTY'.tr} : ${item.quantity ?? 0}',
                      style: Styles().normalCustom(
                          color: Colors.black, weight: FontWeight.bold)),
                  // sizer(),
                  // labelStyle(
                  //     text: '${item.cartOptions['price']}', style: styles().normal),
                ],
              ))
            ],
          ),
          sizer(),
          // item.canceled == 1
          //     ? labelStyle(
          //         text: 'Canceled'.tr,
          //         style: styles().normalCustom(
          //             color: Colors.grey, weight: FontWeight.bold))
          //     : Column(
          //         children: [
          //           labelStyle(text: 'Progress'.tr, style: styles().normal),
          //           sizer(),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceAround,
          //             children: [
          //               statusItem(
          //                   done: 1,
          //                   icon: Icons.refresh,
          //                   label: 'In Progress'.tr),
          //               statusItem(
          //                   done: item.confirmed ?? 0,
          //                   icon: Icons.check,
          //                   label: 'Confirmed'.tr),
          //               statusItem(
          //                   done: item.delivered ?? 0,
          //                   icon: Icons.delivery_dining,
          //                   label: 'Delivered'.tr),
          //             ],
          //           )
          //         ],
          //       )
        ],
      ),
    );
  }

  Widget statusItem(
      {required int done, required IconData icon, required String label}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: done == 1 ? Colors.green : Colors.grey,
          child: Icon(
            icon,
            size: 14,
            color: done == 1 ? Colors.white : Colors.white,
          ),
        ),
        sizer(),
        labelStyle(
            text: label,
            style: Styles()
                .smallCustomized(color: done == 1 ? Colors.green : Colors.grey))
      ],
    );
  }
}
