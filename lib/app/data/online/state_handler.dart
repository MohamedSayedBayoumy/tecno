import 'package:customer/app/core/widgets/buttons/text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/styles.dart';
import '../../core/widgets/labels/label_style.dart';

void areYouSure(
    BuildContext context, VoidCallback action, String title, String message, bool isLogin) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(

          actions: [
            isLogin
            ?textButton(text: 'close'.tr, action: () => Get.back(),)
            :Row(
              children: [
                textButton(text: 'Yes'.tr, action: action),
                textButton(text: 'No'.tr, action: () => Get.back()),
              ],
            )
          ],
          title: labelStyle(
            text: title,
            style: Styles().normal,

          ),
          content: labelStyle(
            text: message,
            style: Styles().normal,
            textAlign: TextAlign.start,
            maxLines: 2,
          ),
        );
      });
}
