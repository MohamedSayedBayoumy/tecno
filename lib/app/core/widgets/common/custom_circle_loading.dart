import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class CustomCircleLoading extends StatelessWidget {
  const CustomCircleLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.mainColor,
        strokeCap: StrokeCap.round,
        strokeWidth: 4.0,
      ),
    );
  }
}
