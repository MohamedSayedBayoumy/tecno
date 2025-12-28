import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/styles.dart';
import '../../../core/widgets/common/custom_screen_padding.dart';
import 'invoice_card_widget.dart';
import 'last_update_widget.dart';
import 'list_of_invoice_types_widget.dart';
import 'title_and_notificaiton_widget.dart';

class InvoiceHeaderWidget extends StatelessWidget {
  const InvoiceHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InvoiceCardWidget(
      child: CustomScreenPadding(
        child: Column(
          children: [
            const TitleAndNotificationWidget(),
            Text(
              "current_balance".tr,
              style: Styles.styleSemiBold16
                  .copyWith(color: const Color(0xff888d96)),
            ),
            Text(
              "1240".tr,
              style: Styles.styleRegular40
                  .copyWith(color: const Color(0xff888d96)),
            ),
            const SizedBox(height: 5),
            const LastUpdateWidget(),
            const SizedBox(height: 20),
            const ListOfInvoicesTypesWidget(),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
