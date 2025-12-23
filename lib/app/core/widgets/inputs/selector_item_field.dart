import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../common/sizer.dart';

class SelectorItemWidget extends StatelessWidget {
  const SelectorItemWidget({
    super.key,
    required this.label,
    required this.selectorText,
    required this.onPressed,
  });
  final String label;
  final String selectorText;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            label.tr,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        sizer(),
        InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: ShapeDecoration(
              color: inputColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: textFieldBackGround,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(selectorText.tr, style: const TextStyle(fontSize: 16)),
                const Icon(Icons.arrow_drop_down_rounded, size: 30)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
