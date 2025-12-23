import 'package:flutter/material.dart';

import '../../../../core/constants/assets.dart';
import '../../../../models/cart/order_details_model.dart';

class CancelOrderImageWidget extends StatelessWidget {
  const CancelOrderImageWidget({super.key, required this.orderDetail});

  final OrderDetail orderDetail;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        height: 180,
        width: 150,
        child: orderDetail.photo != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  orderDetail.photo!,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(AppAssets.noImage);
                  },
                  fit: BoxFit.contain,
                ))
            : Image.asset(AppAssets.noImage, fit: BoxFit.cover),
      ),
    );
  }
}
