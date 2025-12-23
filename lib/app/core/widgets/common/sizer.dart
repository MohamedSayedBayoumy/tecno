import 'package:flutter/material.dart';

class sizer extends StatelessWidget {
  double? width, height;

  sizer({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 10,
      height: height ?? 10,
    );
  }
}
