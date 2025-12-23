import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/styles.dart';
import '../labels/label_style.dart';

class elevatedButton extends StatelessWidget {
  VoidCallback action;
  String text;
  Color? color;
  IconData? icon;

  elevatedButton(
      {required this.action, required this.text, this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(backgroundColor: color ?? mainColor),
        child: icon != null
            ? Container(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      color: Colors.white,
                      size: 30,
                    ),
                    labelStyle(text: text, style: Styles().normalWhite),
                  ],
                ),
              )
            : labelStyle(text: text, style: Styles().normalWhite));
  }
}
