import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/styles.dart';
import '../labels/label_style.dart';

class borderButton extends StatelessWidget {
  String label;
  VoidCallback action;
  Color? color;
  double? height;

  borderButton(
      {required this.label, this.height, this.color, required this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        width: double.infinity,
        height: height ?? kToolbarHeight,
        // padding: const EdgeInsets.symmetric(
        //   vertical: 10,
        // ),
        decoration: BoxDecoration(
            border: Border.all(color: color ?? mainColor),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: labelStyle(
                text: label,
                style: Styles().normalCustom(color: color ?? mainColor))),
      ),
    );
  }
}
