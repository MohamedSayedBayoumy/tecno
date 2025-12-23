import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAssetsImage extends StatelessWidget {
  final String imagePath;
  final double? width, height;
  final Color? imageColor;
  const CustomAssetsImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.imageColor,
  });

  @override
  Widget build(BuildContext context) {
    
    if (imagePath.toString().endsWith("svg")) {
      return FadeIn(
        child: SvgPicture.asset(
          width: width,
          height: height,
          imagePath,
          colorFilter: imageColor != null
              ? ColorFilter.mode(imageColor!, BlendMode.srcIn)
              : null,
        ),
      );
    } else {
      return FadeIn(
        child: Image.asset(
          imagePath,
          width: width,
          height: height,
          color: imageColor,
        ),
      );
    }
  }
}