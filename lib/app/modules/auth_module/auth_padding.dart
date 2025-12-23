import 'package:flutter/material.dart';

import '../../core/widgets/common/custom_screen_padding.dart';

class AuthPadding extends StatelessWidget {
  const AuthPadding({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomScreenPadding(
        horizontalPadding: 40, top: 100, bottom: 10, child: child);
  }
}
