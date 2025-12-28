import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../core/widgets/common/custom_asset_image.dart';
import '../controllers/invoice_controller.dart';

class InvoicesTypeWidget extends StatelessWidget {
  const InvoicesTypeWidget({
    super.key,
    required this.isSelected,
    required this.title,
    this.imagePath,
  });
  final bool isSelected;
  final String? title, imagePath;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoiceController>(
        builder: (InvoiceController controller) {
      return InkWell(
        onTap: () {
          Get.find<InvoiceController>().selectInvoiceType(title!);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xff95be3d) : Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isSelected ? Colors.transparent : const Color(0xffe8e5e5),
              width: 2,
            ),
          ),
          child: Row(
            children: [
              if (imagePath != null) ...[
                CustomAssetsImage(
                  imagePath: imagePath!,
                  width: 20,
                  height: 20,
                  imageColor: isSelected ? Colors.white : mainColor,
                ),
              ],
              const SizedBox(width: 5),
              Text(
                title?.tr ?? "",
                style: Styles.styleRegular15
                    .copyWith(color: isSelected ? Colors.white : mainColor),
              ),
            ],
          ),
        ),
      );
    });
  }
}
