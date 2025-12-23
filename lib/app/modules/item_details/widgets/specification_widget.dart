import 'package:customer/app/core/widgets/buttons/custom_app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

import '../../../core/constants/styles.dart';
import '../../../core/functions/public/get_lang';
import '../../../models/product/item_details_model.dart';

class SpecificationWidget extends StatelessWidget {
  const SpecificationWidget({super.key, required this.itemDetails});

  final ItemDetails itemDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${"specifications".tr}:",
            style: Styles.styleBold15,
          ),
          if (itemDetails.item!.sortDetails != null) ...[
            InkWell(
              borderRadius: BorderRadius.circular(7),
              onTap: () {
                Clipboard.setData(ClipboardData(
                    text: _extractTextFromHtml(
                        itemDetails.item!.sortDetails ?? "")));
                Fluttertoast.showToast(msg: "تم نسخ الوصف");
              },
              onLongPress: () {
                Clipboard.setData(ClipboardData(
                    text: _extractTextFromHtml(
                        itemDetails.item!.sortDetails ?? "")));
                Fluttertoast.showToast(msg: "تم نسخ الوصف");
              },
              child: Html(
                data: itemDetails.item!.sortDetails,
                style: {
                  "body": Style.fromTextStyle(
                      Styles.styleRegular15.copyWith(color: Colors.black)),
                },
              ),
            ),
          ],
          const SizedBox(height: 20),
          //           'itemCode': 'رقم كود الصنف',
          // 'modelNumber': 'رقم الموديل',
          // 'barcode': 'رقم الباركود',
          SpecificationRowDataWidget(
            title: 'itemCode',
            value: itemDetails.item!.id.toString(),
          ),

          SpecificationRowDataWidget(
            title: 'modelNumber',
            value: (itemDetails.item!.sku ?? "").toString(),
          ),
          SpecificationRowDataWidget(
            title: 'barcode',
            value: (itemDetails.item!.barcode ?? "").toString(),
          )
        ],
      ),
    );
  }

  String _extractTextFromHtml(String htmlString) {
    final document = parse(htmlString);
    return parse(document.body?.text).documentElement?.text ?? '';
  }
}

class SpecificationRowDataWidget extends StatelessWidget {
  const SpecificationRowDataWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title, value;

  String _extractTextFromHtml(String htmlString) {
    final document = parse(htmlString);
    return parse(document.body?.text).documentElement?.text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    if (value.isEmpty) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
              child: Row(
            children: [
              Text(
                "${title.tr}: ",
                style: Styles.styleSemiBold14,
              ),
              Text(
                value,
                style: Styles.styleBold15.copyWith(color: Colors.grey),
              ),
            ],
          )),
          CustomAppButton(
            width: 120,
            height: 30,
            text: "${'copy'.tr} ${title.tr}",
            action: () {
              Clipboard.setData(
                  ClipboardData(text: _extractTextFromHtml(value)));
              final message = language() == "ar"
                  ? "${'copy_done'.tr} ${title.tr}"
                  : "${title.tr} ${'copy_done'.tr}";

              Fluttertoast.showToast(msg: message);
            },
          )
        ],
      ),
    );
  }
}
