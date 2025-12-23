import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../core/widgets/common/custom_box_shadow.dart';
import '../../../core/widgets/common/sizer.dart';
import '../../../core/widgets/labels/label_style.dart';
import '../controllers/cart_controller.dart';

class CartFooterWidget extends StatelessWidget {
  CartFooterWidget({
    super.key,
    this.path,
    this.onTap,
  });

  final String? path;
  final void Function()? onTap;
  final controller = Get.find<CartController>();

  dynamic get price => Get.find<CartController>().totalAll;
  @override
  Widget build(BuildContext context) {
    return CustomBoxShadow(
      addPadding: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: InkWell(
          onTap: path != null ? () => Get.toNamed(path!) : onTap,
          child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
                color: mainColor, borderRadius: BorderRadius.circular(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: labelStyle(
                        text: '${controller.totalItems ?? 0}',
                        style: Styles.styleBold15
                            .copyWith(fontFamily: "en_family")),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    labelStyle(
                        text: 'CHECKOUT'.tr,
                        style: Styles().normalCustom(
                            color: Colors.white, weight: FontWeight.bold)),
                    sizer(
                      height: 3,
                    ),
                    Obx(
                      () => labelStyle(
                          text: price,
                          style: Styles().normalCustom(
                              color: Colors.white, weight: FontWeight.bold)),
                    ),
                  ],
                ),
                Container(
                  width: 25,
                  height: 25,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: mainColor,
                    size: 16,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
