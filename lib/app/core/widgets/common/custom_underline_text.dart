import 'package:flutter/material.dart';

class CustomUnderlineText extends StatelessWidget {
  const CustomUnderlineText({
    super.key,
    this.textWidget,
    this.addUnderLine = true,
    this.offset,
    this.onTap,
  });
  final Widget? textWidget;
  final bool? addUnderLine;
  final Offset? offset;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            textWidget ?? const SizedBox(),
            if (addUnderLine == true) ...[
              Transform.translate(
                offset: offset ?? const Offset(-3, -5),
                child: Container(
                  height: .5,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
