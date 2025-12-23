import 'dart:math';
import 'package:flutter/material.dart';

import '../../constants/app_assets.dart';
import 'custom_asset_image.dart';

class CustomLoading extends StatefulWidget {
  const CustomLoading(
      {super.key, this.color, this.size = 30, this.width, this.height});

  final Color? color;
  final double? size, width, height;

  @override
  State<CustomLoading> createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(); // rotation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Transform.rotate(
            angle: -_controller.value * 2 * pi,
            child: child,
          );
        },
        child: CustomAssetsImage(
          imagePath: Assets.assetsImagesNewVersionLoading,
          width: widget.size,
        ),
      ),
    );
  }
}
