import 'package:flutter/material.dart';

import '../../constants/styles.dart';
import '../labels/label_style.dart';

class textButton extends StatelessWidget {
  VoidCallback action;
  String text;
  TextStyle? style;

  textButton({required this.text, required this.action, this.style});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: action,
        child: labelStyle(
          text: text,
          style: style ?? Styles().normal,
        ));
  }
}
