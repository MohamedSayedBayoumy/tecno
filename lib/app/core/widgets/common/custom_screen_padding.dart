import 'package:flutter/material.dart';

import '../../constants/sizes.dart';

class CustomScreenPadding extends StatelessWidget {
  const CustomScreenPadding({
    super.key,
    this.horizontalPadding,
    required this.child,
    this.top,
    this.bottom,
    this.addSafe, this.addSafeBottom,
  });

  final double? horizontalPadding, top, bottom;
  final Widget child;
  final bool? addSafe , addSafeBottom;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: addSafe ?? true,
      bottom: addSafeBottom ?? true,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          top: top ?? 0.0,
          bottom: bottom ?? 0.0,
          end: horizontalPadding ?? AppSizes.horizontalPadding,
          start: horizontalPadding ?? AppSizes.horizontalPadding,
        ),
        child: child,
      ),
    );
  }
}
