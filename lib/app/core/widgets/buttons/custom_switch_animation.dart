import 'package:flutter/material.dart';

class CustomSwitcherAnimation extends StatelessWidget {
  const CustomSwitcherAnimation({
    super.key,
    required this.condition,
    required this.firstWidget,
    required this.secondWidget,
    this.transitionType,
    this.duration,
  });

  final bool condition;
  final Widget firstWidget, secondWidget;
  final String? transitionType;
  final int? duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: duration ?? 200),
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: condition ? firstWidget : secondWidget,
    );
  }
}
