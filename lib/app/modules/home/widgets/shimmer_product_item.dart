import 'package:flutter/material.dart';

import '../../../core/constants/sizes.dart';
import 'package:shimmer/shimmer.dart';

class ProductItemShimmer extends StatelessWidget {
  const ProductItemShimmer({super.key, this.showAll = true});
  final bool showAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppSizes.borderRadius),
                  ),
                  color: Colors.grey[300],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildShimmerLine(width: 120, height: 14),
                  const SizedBox(height: 6),
                  _buildShimmerLine(width: 160, height: 12),
                  if (showAll == true) ...[
                    const SizedBox(height: 4),
                    _buildShimmerLine(width: 140, height: 12),
                    const SizedBox(height: 8),
                    _buildShimmerLine(width: 80, height: 14),
                  ],
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerLine({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
