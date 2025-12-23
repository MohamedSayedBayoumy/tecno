import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/styles.dart';
import '../labels/label_style.dart';

class EmptyList extends StatelessWidget {
  final String label;

  const EmptyList({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.list,
          color: Colors.grey,
        ),
        labelStyle(
          text: label.tr,
          style: Styles().normalGrey,
        ),
      ],
    ));
  }
}
