import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/styles.dart';
import '../labels/label_style.dart';

class titleAppbar extends StatelessWidget implements PreferredSizeWidget {
  bool? automaticallyImplyLeading;
  String label;
  Widget? bottom;
  VoidCallback? onLeadingPressed;
  List<Widget>? action;

  titleAppbar(
      {this.automaticallyImplyLeading,
      required this.label,
      this.bottom,
      this.action,
      this.onLeadingPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: automaticallyImplyLeading ?? true
          ? IconButton(
              onPressed: onLeadingPressed ?? () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ))
          : const SizedBox(),
      iconTheme: const IconThemeData(color: Colors.black),
      centerTitle: true,
      title: labelStyle(
          text: label, style: Styles().subTitleCustomized(Colors.black)),
      elevation: 0,
      actions: action,
      bottom: bottom != null
          ? PreferredSize(
              preferredSize: preferredSize,
              child: SizedBox(height: kToolbarHeight, child: bottom!))
          : null,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
