import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../../core/constants/colors.dart';
import '../controllers/item_details_controller.dart';

class ItemDescriptionWidget extends StatefulWidget {
  final String? details;
  final ItemDetailsController controller;

  const ItemDescriptionWidget({
    super.key,
    required this.details,
    required this.controller,
  });

  @override
  State<ItemDescriptionWidget> createState() => _ItemDescriptionWidgetState();
}

class _ItemDescriptionWidgetState extends State<ItemDescriptionWidget> {
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    if (widget.details == null || widget.details!.isEmpty) {
      return IconButton(
        alignment: Alignment.centerLeft,
        onPressed: () {
          widget.controller.shareViaWhatsApp();
        },
        icon: Icon(
          Icons.share_outlined,
          color: mainColor,
        ),
      );
    }

    String displayText = showAll == true
        ? widget.details!
        : widget.details!.length > 160
            ? "${widget.details!.substring(0, min(widget.details!.length, 160))}..."
            : widget.details!;

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              showAll = !showAll;
              setState(() {});
            },
            child: Html(
              data:
                  "$displayText\n${widget.details!.length > 160 ? showAll == true ? "show_less".tr : "see_more".tr : ""}",
              style: {
                "body": Style.fromTextStyle(
                  const TextStyle(fontSize: 15, color: Colors.black),
                ),
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            widget.controller.shareViaWhatsApp();
          },
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: const Color(0xffF3F3F3),
            ),
            child: IconButton(
              alignment: Alignment.center,
              padding: EdgeInsets.zero,
              onPressed: () {
                widget.controller.shareViaWhatsApp();
              },
              icon: Icon(
                Icons.share_rounded,
                color: mainColor,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
