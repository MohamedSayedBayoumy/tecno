import 'package:flutter/material.dart';

import '../../constants/styles.dart';
import 'label_style.dart';

class customizedLabel extends StatelessWidget {
  Color color;
  String label;
  TextStyle? style;

  customizedLabel({required this.label, required this.color, this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: color.withOpacity(.1),
          borderRadius: BorderRadius.circular(15)),
      child: Center(
          child: labelStyle(
              text: label,
              style: style ?? Styles().normalCustom(color: color))),
    );
  }
}
