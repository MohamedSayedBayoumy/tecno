import 'package:customer/app/core/enum.dart';
import 'package:customer/app/core/widgets/common/app_bar/custom_app_bar.dart';
import 'package:customer/app/core/widgets/common/custom_failed_widget.dart';
import 'package:customer/app/core/widgets/common/custom_loading.dart';
import 'package:customer/app/modules/invoice/controllers/invoice_controller.dart';
import 'package:customer/app/modules/invoice/widgets/invoice_actions_widget.dart';
import 'package:customer/app/modules/invoice/widgets/invoice_details_header_widget.dart';
import 'package:customer/app/modules/invoice/widgets/invoice_items_table_widget.dart';
import 'package:customer/app/modules/invoice/widgets/invoice_totals_widget.dart';
import 'package:customer/app/modules/invoice/widgets/invoice_qr_code_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/utils/invoice_pdf_service.dart';

class InvoiceDetailsScreen extends StatefulWidget {
  const InvoiceDetailsScreen({super.key});

  @override
  State<InvoiceDetailsScreen> createState() => _InvoiceDetailsScreenState();
}

class _InvoiceDetailsScreenState extends State<InvoiceDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Get.find<InvoiceController>();
      if (Get.arguments != null) {
        controller.getTransactionDetails(Get.arguments);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoiceController>(
      builder: (controller) => Scaffold(
        body: GetBuilder<InvoiceController>(
          builder: (controller) {
            switch (controller.status) {
              case Status.loading:
                return const Center(child: CustomLoading());
              case Status.loaded:
                if (controller.transactionData == null) {
                  return const Center(
                      child: Text("No transaction details found"));
                }
                final data = controller.transactionData!;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      CustomAppBar(
                        title: "تفاصيل الفاتورة",
                        showCart: false,
                      ),
                      InvoiceQrCodeWidget(
                        qrData:
                            "INV-${data.code}", // Static QR code data for now
                      ),
                      const SizedBox(height: 20),
                      InvoiceDetailsHeaderWidget(data: data),
                      const SizedBox(height: 10),
                      InvoiceItemsTableWidget(items: data.items),
                      const SizedBox(height: 20),
                      InvoiceTotalsWidget(data: data),
                      const SizedBox(height: 20),
                      InvoiceActionsWidget(
                        onPrint: () {
                          InvoicePdfService.generateInvoice(data);
                        },
                        onShare: () {
                          // Simple share of the PDF file would be better,
                          // but for now we share text or let user print and then share.
                          // Usually share also generates the PDF and shares the path.
                          Share.share(
                              "Invoice #${data.code} for ${data.client}. Total: ${data.total} SAR");
                        },
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                );
              case Status.fail:
                return CustomFailedWidget(
                  onTap: () {
                    if (Get.arguments != null) {
                      controller.getTransactionDetails(Get.arguments);
                    }
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
