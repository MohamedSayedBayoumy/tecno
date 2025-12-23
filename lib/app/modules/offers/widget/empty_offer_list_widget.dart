
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/assets.dart';

class EmptyOfferListWidget extends StatelessWidget {
  const EmptyOfferListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          // ignore: avoid_unnecessary_containers
          child: Container(
            child: SizedBox(
                width: 200, height: 200, child: Image.asset(AppAssets.offers)),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "There are no current offers".tr,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
