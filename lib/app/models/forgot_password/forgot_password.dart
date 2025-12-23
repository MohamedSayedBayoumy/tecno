import 'dart:developer';

import 'package:customer/app/core/functions/status/failure.dart';
import 'package:get/get.dart';

class ForgotPasswordModel {
  final bool status;
  final String message;
  final OtpData? data;

  ForgotPasswordModel({
    this.status = false,
    this.message = "",
    this.data,
  });

  factory ForgotPasswordModel.fromJsosn(String json) {
    log("message>>> $json");
    return ForgotPasswordModel(
       
    );
  }

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordModel(
      status: json["status"] ?? false,
      message: json["message"] ?? "error".tr,
      data: json["data"] != null ? OtpData.fromJson(json["data"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "data": data?.toJson(),
    };
  }
}

class OtpData {
  final String email;
  final int expiresIn;
  final String resetToken;

  OtpData({
    this.email = "",
    this.expiresIn = 0,
    this.resetToken = "",
  });

  factory OtpData.fromJson(Map<String, dynamic> json) {
    return OtpData(
      email: json["email"] ?? "",
      expiresIn: json["expires_in"] ?? 0,
      resetToken: json["reset_token"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "expires_in": expiresIn,
      "reset_token": resetToken,
    };
  }
}
