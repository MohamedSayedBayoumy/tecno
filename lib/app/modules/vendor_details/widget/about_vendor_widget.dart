import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/styles.dart';
import '../../../core/widgets/common/sizer.dart';

class AboutVendorWidget extends StatelessWidget {
  const AboutVendorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "about_vendor".tr,
            style: Styles.styleBold15,
          ),
          sizer(),
          Text(
            "DATADATADATADATADATADATA  DATADATADATA".tr,
            style: Styles.styleRegular15.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
