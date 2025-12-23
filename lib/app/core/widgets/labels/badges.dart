import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/styles.dart';
import 'label_style.dart';

class badgeWidget extends StatelessWidget {
  Color? bgColor;
  String? label;
  TextStyle? style;
  double? paddingHorizontal, paddingVertical, radius;
  badgeWidget({
    this.bgColor,
    this.label,
    this.style,
    this.paddingHorizontal,
    this.paddingVertical,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal ?? 10, vertical: paddingVertical ?? 4),
      decoration: BoxDecoration(
          color: bgColor ?? mainColor,
          borderRadius: BorderRadius.circular(radius ?? 10)),
      child: labelStyle(text: label ?? '', style: style ?? Styles().normal),
    );
  }
}
