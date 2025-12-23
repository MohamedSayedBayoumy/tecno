import 'dart:developer';

import 'package:customer/app/data/online/DioRequest.dart';
import 'package:customer/app/data/online/end_points.dart';
import 'package:customer/app/data/online/state_handler.dart';
import 'package:customer/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/auth/profile.dart';

class AuthParser {
  Future<bool> signIn({
    required String email,
    required String password,
    required String token,
  }) async {
    final response = await postRequest(urlExt: EndPoints().login, data: {
      'email': email,
      'password': password,
      "fcm_token": token,
    });
    try {
      final storage = GetStorage();
      storage.write('token', response.data['data']['token']);
      DioRequest.createDioInstance(response.data['data']['token']);

      return response.data['status'];
    } catch (e) {
      areYouSure(Get.context!, () {
        Get.back();
      },
          'Failed'.tr,
          'Email or Password is wrong, please make sure and try again'.tr,
          true);
      return false;
    }
  }

  Future<bool> autoLogin({
    required String email,
    required String password,
  }) async {
    final response = await postRequest(
        urlExt: EndPoints().login,
        data: {'email': email, 'password': password});
    try {
      final storage = GetStorage();
      storage.write('token', response.data['data']['token']);
      DioRequest.createDioInstance(response.data['data']['token']);
      try {
        final ctrl = Get.find<HomeController>();
        ctrl.getProfile();
      } catch (e) {}
      return response.data['status'];
    } catch (e) {
      return false;
    }
  }

  bool isAuth() {
    try {
      if (DioRequest.dioWithToken == null) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<ProfileModel> getProfile() async {
    final response =
        await getRequest(urlExt: EndPoints().profile, requireToken: true);
    log("message>>> ${response.data}");
    return ProfileModel.fromJson(response.data);
  }

  Future<ProfileModel> updateProfile(Map<String, dynamic> body) async {
    final response = await postRequest(
        urlExt: EndPoints().updateProfile, data: body, requiredToken: true);
    return ProfileModel.fromJson(response.data);
  }
}
