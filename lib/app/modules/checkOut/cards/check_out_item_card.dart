import 'package:customer/app/core/constants/styles.dart';
import 'package:customer/app/core/widgets/labels/label_style.dart';
import 'package:customer/app/models/cart/cart_off_line_model.dart';
import 'package:customer/app/models/product/item.dart';
import 'package:flutter/material.dart';

import '../../../config/config.dart';
import '../../../core/widgets/common/sizer.dart';

class checkOutItemCard extends StatelessWidget {
  String headerText;
  ItemModel item;
  checkOutItemCard({required this.headerText, required this.item});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelStyle(text: headerText, style: Styles().normal),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                    height: kTextTabBarHeight * 2,
                    width: kTextTabBarHeight * 2,
                    child: Image.network(item.photo!)),
              ),
              sizer(),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  labelStyle(
                      text: item.name ?? '',
                      style: Styles().normalCustom(
                          color: Colors.black, weight: FontWeight.w700)),
                  labelStyle(text: item.details ?? '', style: Styles().normal),
                  Row(
                    children: [
                      labelStyle(
                          text:
                              '${item.discountPrice ?? 0} ${Config().currency}',
                          style: Styles().normalCustom(
                              color: Colors.black, weight: FontWeight.bold)),
                      sizer(),
                    ],
                  ),
                  // sizer(),
                  // labelStyle(
                  //     text: '${item.cartOptions['price']}', style: styles().normal),
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }
}

class checkOutItemCardOffLine extends StatelessWidget {
  String headerText;
  CartOffLineModel item;
  checkOutItemCardOffLine({required this.headerText, required this.item});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelStyle(text: headerText, style: Styles().normal),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                    height: kTextTabBarHeight * 2,
                    width: kTextTabBarHeight * 2,
                    child: Image.network(item.image!)),
              ),
              sizer(),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      labelStyle(
                          text: item.name ?? '',
                          style: Styles().normalCustom(
                              color: Colors.black, weight: FontWeight.w700)),
                      labelStyle(text: item.name ?? '', style: Styles().normal),
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
                      // sizer(),
                      // labelStyle(
                      //     text: '${item.cartOptions['price']}', style: styles().normal),
                    ],
                  ))
            ],
          ),
          item.options != null
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ...item.options!.attribute!.names!.map((option) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Text(
                              "${option} :" ??
                                  '', // Adjust based on the option structure
                              style: Styles().normal
                          ),

                        ],
                      ),
                    );
                  }).toList(),
                  ...item.options!.attribute!.optionName!.map((option) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Text(
                              " ${option} " ??
                                  '', // Adjust based on the option structure
                              style: Styles().normal
                          ),

                        ],
                      ),
                    );
                  }).toList(),
                ],
              )
            ],
          )
              : Text("data"),
        ],
      ),
    );
  }
}
