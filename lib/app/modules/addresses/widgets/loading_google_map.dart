import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/enum.dart';
import '../../../core/widgets/buttons/custom_switch_animation.dart';
import '../../../core/widgets/common/custom_loading.dart';
import '../controllers/addresses_controller.dart';

class LoadingGoogleMap extends StatelessWidget {
  const LoadingGoogleMap({super.key, required this.controller});

  final AddressesController controller;

  @override
  Widget build(BuildContext context) {
    return CustomSwitcherAnimation(
      condition: controller.locationStatus == Status.loading,
      firstWidget: ZoomIn(
        delay: const Duration(milliseconds: 500),
        child: Container(
          width: 50,
          height: 50,
          padding: const EdgeInsets.all(7),
          decoration: ShapeDecoration(
            shape: const CircleBorder(),
            color: Colors.white,
            shadows: [
              BoxShadow(
                color: mainColor.withOpacity(.3),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const CustomLoading(),
        ),
      ),
      secondWidget: const SizedBox(),
    );
  }
}
