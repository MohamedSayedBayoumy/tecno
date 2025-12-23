import 'package:flutter/material.dart';

import '../../constants/colors.dart';


class iconButton extends StatelessWidget {
  VoidCallback action;
  IconData icon;
  double? radius;
  Color? backColor, color;

  iconButton(
      {required this.action, required this.icon, this.radius,this.backColor, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: CircleAvatar(
        backgroundColor: backColor ?? mainColor,
        radius: radius?? 15,
        child: Icon(
          icon,
          color: color ?? Colors.white,
          size: 15,
        ),
      ),
    );
  }
}
