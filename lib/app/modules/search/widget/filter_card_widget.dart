import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../core/functions/public/get_lang';

class FilterCardWidget extends StatelessWidget {
  const FilterCardWidget({super.key, required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        height: 30,
        padding: const EdgeInsetsDirectional.only(start: 10, end: 5),
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${value.toString().toLowerCase().split(":").first.toString().tr}:${value.toString().toLowerCase().split(":").last}",
              style: Styles.styleSemiBold13.copyWith(
                color: Colors.white,
                height: language() == "ar" ? 2 : null,
              ),
            ),
            const SizedBox(width: 5),
            const Padding(
              padding: EdgeInsets.only(top: 2),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
