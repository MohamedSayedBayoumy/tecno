import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../buttons/custom_app_button.dart';

class CustomEmptyList extends StatelessWidget {
  const CustomEmptyList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          // ignore: avoid_unnecessary_containers
          child: Container(
            child: SizedBox(
                width: 200, height: 200, child: Image.asset(AppAssets.order)),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "you haven't placed any orders yet.".tr,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "when you do. their status will appear here".tr,
          style: const TextStyle(
              fontWeight: FontWeight.normal, fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 30),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: CustomAppButton(
                action: () {
                  Get.offAllNamed(Routes.BOTTOMSHEET);
                },
                text: "explore our products".tr,
                color: mainColor),
          ),
        )
      ],
    );
  }
}
