import 'package:flutter/material.dart';

class labelStyle extends StatelessWidget {
  TextStyle style;
  String text;
  TextAlign? textAlign;
  int? maxLines;

  labelStyle(
      {required this.text, this.maxLines, required this.style, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text??"",
      style: style,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}
