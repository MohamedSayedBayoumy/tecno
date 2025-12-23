import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../core/widgets/buttons/custom_app_button.dart';
import '../../../core/widgets/common/app_bar/custom_app_bar.dart';
import '../../../core/widgets/common/sizer.dart';
import '../../../routes/app_pages.dart';
import '../widgets/payment_card_widget.dart';

class PaymentViewScreen extends StatelessWidget {
  const PaymentViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "Payment",
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomAppButton(
              text: "add_new_payment",
              color: Colors.transparent,
              borderColor: mainColor,
              style: Styles.styleBold15,
              action: () {},
            ),
          ),
          sizer(height: 20),
          Expanded(
            child: ListView.separated(
              itemCount: 5,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              separatorBuilder: (context, index) => sizer(height: 15),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Get.toNamed(Routes.paymentsDetails);
                },
                child: const PaymentCardWidget(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
