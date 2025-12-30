import 'package:customer/app/core/widgets/buttons/custom_app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../controllers/invoice_controller.dart';

class AllTransactionsHeaderWidget extends StatelessWidget {
  const AllTransactionsHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InvoiceController>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "transactions_history".tr,
              style: Styles.styleBold18.copyWith(color: mainColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: CustomAppButton(
                    action: () {
                      _showFilterBottomSheet(context, controller);
                    },
                    text: "my_account_transactions".tr,
                    color: mainColor),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showFilterBottomSheet(
      BuildContext context, InvoiceController controller) {
    String filterType = controller.fromDate == null ? "all" : "period";
    DateTime? from = controller.fromDate;
    DateTime? to = controller.toDate;

    Get.bottomSheet(
      StatefulBuilder(builder: (context, setState) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Filter Transactions".tr,
                style: Styles.styleBold18.copyWith(color: mainColor),
              ),
              const SizedBox(height: 20),
              RadioListTile<String>(
                title: Text("Select All".tr, style: Styles.styleSemiBold16),
                value: "all",
                groupValue: filterType,
                activeColor: mainColor,
                onChanged: (value) {
                  setState(() {
                    filterType = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text("Select Period".tr, style: Styles.styleSemiBold16),
                value: "period",
                groupValue: filterType,
                activeColor: mainColor,
                onChanged: (value) {
                  setState(() {
                    filterType = value!;
                  });
                },
              ),
              if (filterType == "period") ...[
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: from ?? DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: mainColor,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (picked != null) {
                            setState(() {
                              from = picked;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("From".tr,
                                  style: Styles.styleRegular13
                                      .copyWith(color: Colors.grey)),
                              const SizedBox(height: 5),
                              Text(
                                from == null
                                    ? "Select Date".tr
                                    : intl.DateFormat('yyyy-MM-dd')
                                        .format(from!),
                                style: Styles.styleSemiBold14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: to ?? DateTime.now(),
                            firstDate: from ?? DateTime(2020),
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: mainColor,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (picked != null) {
                            setState(() {
                              to = picked;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("To".tr,
                                  style: Styles.styleRegular13
                                      .copyWith(color: Colors.grey)),
                              const SizedBox(height: 5),
                              Text(
                                to == null
                                    ? "Select Date".tr
                                    : intl.DateFormat('yyyy-MM-dd').format(to!),
                                style: Styles.styleSemiBold14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 30),
              CustomAppButton(
                action: () {
                  if (filterType == "all") {
                    controller.resetFilter();
                  } else {
                    if (from != null && to != null) {
                      controller.applyFilter(from: from, to: to);
                    } else {
                      Get.snackbar(
                        "Error".tr,
                        "Please select both dates".tr,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }
                  }
                  Get.back();
                },
                text: "Apply".tr,
                color: mainColor,
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      }),
      isScrollControlled: true,
    );
  }
}
