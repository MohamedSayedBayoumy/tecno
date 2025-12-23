import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/enum.dart';
import '../../../data/online/forgot_password_parser.dart';
import '../../../routes/app_pages.dart';

class ForgotPasswordController extends GetxController {
  final emailKey = GlobalKey<FormState>();
  final otpKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();

  Status getOtpStatus = Status.loaded;

  Status sendOtpStatus = Status.loaded;

  Status resetPasswordStatus = Status.loaded;

  String token = "";

  int time = 0;

  getOtp({void Function()? onCallback}) async {
    if (emailKey.currentState!.validate()) {
      getOtpStatus = Status.loading;
      otpController.clear();
      newPassword.clear();
      confirmNewPassword.clear();
      update();

      final result =
          await ForgotPasswordParser.getOtp(email: emailController.text);
      if (result.status == true) {
        Get.snackbar(
          'Success'.tr,
          result.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        time = result.data!.expiresIn;
        update();
        if (onCallback != null) {
          onCallback();
        } else {
          Get.toNamed(Routes.otp);
        }
      } else {
        Get.snackbar(
          'Error'.tr,
          result.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
      getOtpStatus = Status.loaded;
      update();
    }
  }

  sendOtp() async {
    if (otpKey.currentState!.validate()) {
      sendOtpStatus = Status.loading;
      update();
      final result = await ForgotPasswordParser.sendOtp(
        email: emailController.text,
        otp: otpController.text,
      );
      if (result.status == true) {
        Get.snackbar(
          'Success'.tr,
          result.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        token = result.data!.resetToken;
        time = result.data!.expiresIn;
        update();
        Get.offNamed(Routes.fieldsPasswords);
      } else {
        Get.snackbar(
          'Error'.tr,
          result.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
      sendOtpStatus = Status.loaded;
      update();
    }
  }

  resetPassword() async {
    if (passwordKey.currentState!.validate()) {
      resetPasswordStatus = Status.loading;
      update();
      final result = await ForgotPasswordParser.resetPassword(
        resetToken: token,
        password: newPassword.text,
        confirmPassword: confirmNewPassword.text,
      );
      if (result.status == true) {
        Get.snackbar(
          'Success'.tr,
          result.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        Get.offAllNamed(Routes.SIGNIN);
      } else {
        Get.snackbar(
          'Error'.tr,
          result.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
      resetPasswordStatus = Status.loaded;
      update();
    }
  }
}
