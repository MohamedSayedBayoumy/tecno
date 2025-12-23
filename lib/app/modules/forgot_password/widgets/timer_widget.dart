import 'dart:async';
import 'package:customer/app/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/enum.dart';
import '../../../core/widgets/buttons/custom_app_button.dart';
import '../../../core/widgets/common/custom_loading.dart';
import '../controllers/forgot_password_controller.dart';

class CountdownTimer extends StatefulWidget {
  final int? minutes;

  const CountdownTimer({
    super.key,
    required this.minutes,
  });

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Duration _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer(widget.minutes!);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer(int minutes) {
    _remaining = Duration(minutes: 5);
    setState(() {});

    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;

      if (_remaining.inSeconds <= 1) {
        t.cancel();
        setState(() => _remaining = Duration.zero);
      } else {
        setState(() => _remaining -= const Duration(seconds: 1));
      }
    });
  }

  String get mmss {
    final m = _remaining.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = _remaining.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
      builder: (controller) {
        if (controller.getOtpStatus == Status.loading) {
          return const CustomLoading();
        } else {
          return Column(
            children: [
              if (_remaining.inSeconds <= 1) ...[
                CustomAppButton(
                  text: "resend_code",
                  action: () {
                    controller.getOtp(
                      onCallback: () {
                        startTimer(controller.time);
                      },
                    );
                  },
                )
              ] else ...[
                Text(
                  "can_resend_after".tr,
                  style: Styles.styleMedium15,
                  textAlign: TextAlign.left,
                ),
                Text(
                  mmss,
                  style: Styles.styleRegular20,
                ),
              ],
            ],
          );
        }
      },
    );
  }
}
