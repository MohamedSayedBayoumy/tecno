import 'dart:developer';

import '../../models/forgot_password/forgot_password.dart';
import 'DioRequest.dart';
import 'end_points.dart';

abstract class ForgotPasswordParser {
  static Future<ForgotPasswordModel> getOtp({
    required String email,
  }) async {
    final response = await postRequest(
      urlExt: EndPoints().forgotPassword,
      data: {'email': email},
    );

    
    try {
      return ForgotPasswordModel.fromJson(response.data);
    } catch (e) {
      log("ssss ${e}");
      log("acaxcsa ${response.data}");
      return ForgotPasswordModel.fromJsosn(response.data);
    }
  }

  static Future<ForgotPasswordModel> reSendOtp({
    required String email,
  }) async {
    final response = await postRequest(
        urlExt: EndPoints().reSendOTP, data: {'email': email});
    try {
      return ForgotPasswordModel.fromJson(response.data);
    } catch (e) {
      return ForgotPasswordModel.fromJson(response.data);
    }
  }

  static Future<ForgotPasswordModel> sendOtp({
    required String email,
    required String otp,
  }) async {
    final response = await postRequest(urlExt: EndPoints().verifyOtp, data: {
      'email': email,
      'otp': otp,
    });
    try {
      return ForgotPasswordModel.fromJson(response.data);
    } catch (e) {
      return ForgotPasswordModel.fromJson(response.data);
    }
  }

  static Future<ForgotPasswordModel> resetPassword({
    required String resetToken,
    required String password,
    required String confirmPassword,
  }) async {
    final response =
        await postRequest(urlExt: EndPoints().resetPassword, data: {
      'reset_token': resetToken,
      'password': password,
      'password_confirmation': confirmPassword,
    });
    try {
      return ForgotPasswordModel.fromJson(response.data);
    } catch (e) {
      return ForgotPasswordModel.fromJson(response.data);
    }
  }
}
