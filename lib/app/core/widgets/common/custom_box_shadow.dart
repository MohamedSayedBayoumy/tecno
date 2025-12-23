import 'package:flutter/material.dart';

class CustomBoxShadow extends StatelessWidget {
  const CustomBoxShadow({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.addPadding = true,
  });

  final Widget child;
  final double? width , height;
  final bool addPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding:
          addPadding ==true
              ? const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
              : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 10,
            offset: const Offset(-0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}