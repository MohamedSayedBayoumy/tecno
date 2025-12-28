import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/styles.dart';
import '../../../core/widgets/common/custom_asset_image.dart';
import '../../../core/widgets/common/custom_screen_padding.dart';
import '../controllers/invoice_controller.dart';
import 'invoice_card_widget.dart';
import 'last_update_widget.dart';
import 'title_and_notificaiton_widget.dart';

class InvoiceHeaderWidget extends StatelessWidget {
  const InvoiceHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InvoiceController>();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${controller.walletStatementResponse?.balance}",
                  style: Styles.styleRegular40.copyWith(
                      color: const Color(0xff1c1c38), fontFamily: 'number'),
                ),
                const SizedBox(width: 5),
                const CustomAssetsImage(
                  imagePath: 'assets/images/SAR.png',
                  width: 25,
                  height: 25,
                  imageColor: Color(0xff1c1c38),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const LastUpdateWidget(),
            const SizedBox(height: 20),
            // const ListOfInvoicesTypesWidget(),
            // const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
