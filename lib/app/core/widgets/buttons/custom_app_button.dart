import 'package:customer/app/core/widgets/common/custom_asset_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';
import '../../constants/styles.dart';
import '../common/sizer.dart';
import '../labels/label_style.dart';

class CustomAppButton extends StatelessWidget {
  final String? text;
  final VoidCallback action;
  final Color? color;
  final double? height, width, heightIcon, widthIcon;
  final TextStyle? style;
  final String? image;
  final Color? borderColor;
  final Widget? child;

  const CustomAppButton({
    super.key,
    this.text,
    this.style,
    this.height,
    this.width,
    this.image,
    this.borderColor,
    required this.action,
    this.color,
    this.heightIcon,
    this.widthIcon,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        height: height ?? 45,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: color ?? mainColor,
          border: Border.all(color: borderColor ?? color ?? mainColor),
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        ),
        child: child ??
            (image != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomAssetsImage(
                        imagePath: image!,
                        height: heightIcon,
                        width: widthIcon,
                      ),
                      sizer(),
                      labelStyle(
                        text: text!.tr,
                        style: style ??
                            Styles.styleBold11.copyWith(color: Colors.white),
                      ),
                    ],
                  )
                : Center(
                    child: labelStyle(
                      text: text!.tr,
                      style: style ??
                          Styles.styleBold11.copyWith(color: Colors.white),
                    ),
                  )),
      ),
    );
  }
}
