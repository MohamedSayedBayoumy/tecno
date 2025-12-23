import 'package:flutter/material.dart';

import '../../constants/styles.dart';
import '../labels/label_style.dart';

class backAppbar extends StatelessWidget implements PreferredSizeWidget {
  String? title;

  backAppbar({this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 0,
      title: labelStyle(text: title ?? '', style: Styles().subTitle),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
