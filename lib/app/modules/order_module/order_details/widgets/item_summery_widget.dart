import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/widgets/common/sizer.dart';
import '../../../../core/widgets/labels/label_style.dart';
import '../../../../models/cart/order_details_model.dart';
import 'items_list_widget.dart';

class ItemSummeryWidget extends StatefulWidget {
  const ItemSummeryWidget({
    super.key,
    required this.item,
  });

  final OrderDetailsModel? item;

  @override
  State<ItemSummeryWidget> createState() => _ItemSummeryWidgetState();
}

class _ItemSummeryWidgetState extends State<ItemSummeryWidget>
    with SingleTickerProviderStateMixin {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // clickable title
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                labelStyle(
                  text: 'Items Summery'.tr,
                  style: Styles().normalCustom(
                      color: Colors.black, weight: FontWeight.bold),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.black,
                )
              ],
            ),
          ),

          const SizedBox(height: 5),

          // animated container
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: isExpanded
                ? Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        labelStyle(
                          text:
                              '${'Order No.'.tr} ${widget.item!.orderDetails.first.orderId}',
                          style: Styles.styleBold15,
                        ),
                        const Divider(thickness: .8),
                        sizer(),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            "${"Items".tr}:",
                            style: Styles.styleSemiBold16,
                          ),
                        ),
                        sizer(),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return ItemDetailsListWidget(
                              item: widget.item!.orderDetails[index],
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const Divider(thickness: .8),
                          itemCount: widget.item!.orderDetails.length,
                        ),
                      ],
                    ),
                  )
                : const SizedBox(), // يختفي بسلاسة
          ),
        ],
      ),
    );
  }
}
