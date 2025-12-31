import 'package:customer/app/core/constants/colors.dart' as AppColors;
import 'package:flutter/material.dart';
import '../../../core/constants/styles.dart';
import '../../../core/widgets/buttons/custom_app_button.dart';
import 'package:get/get.dart';
import '../controllers/invoice_controller.dart';

class InvoiceActionsWidget extends StatelessWidget {
  final VoidCallback onPrint;
  final VoidCallback onShare;

  const InvoiceActionsWidget({
    super.key,
    required this.onPrint,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          // CustomAppButton(
          //   text: 'Share Invoice'.tr,
          //   action: onShare,
          //   color: const Color(0xfff5f5f5),
          //   style: Styles.styleSemiBold14.copyWith(color: Colors.black),
          // ),
          // const SizedBox(height: 10),
          CustomAppButton(
            text: 'Print Invoice'.tr,
            action: onPrint,
            color: AppColors.mainColor,
            style: Styles.styleSemiBold14.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
