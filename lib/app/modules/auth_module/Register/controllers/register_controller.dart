import 'package:customer/app/data/online/DioRequest.dart';
import 'package:customer/app/data/online/end_points.dart';
import 'package:customer/app/data/online/state_handler.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/enum.dart';
import '../../../../core/services/firebase_messaging.dart';
import '../../../../data/local/auth_info.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  String? fName,
      lName,
      email,
      phone,
      password,
      passwordConfirmation,
      countryCode;

  TextEditingController phoneController = TextEditingController();

  Status status = Status.loaded;
  bool obscure = false;
  void toggleObscure() {
    obscure = !obscure;
    update();
  }

  void register() async {
    if (formKey.currentState!.validate()) {
      status = Status.loading;
      update();

      FirebaseNotificationServices.getFcmToken(
        (p0) async {
          final response =
              await postRequest(urlExt: EndPoints().register, data: {
            "email": email,
            "first_name": fName,
            "last_name": lName,
            "phone":
                int.parse("${countryCode ?? "+20"}${phoneController.text}"),
            "password": password,
            "password_confirmation": passwordConfirmation,
            "fcm_token": p0
          });
          print(response);
          if (response.data['status']) {
            status = Status.loaded;
            update();
            LocalAuthInfo().saveInfo(
              email: email ?? '',
              password: password ?? '',
            );
            AppPages.routes();
            try {
              // areYouSure(Get.context!, () {
              //   Get.offAndToNamed(Routes.SIGN_IN);
              // }, 'تأكيد'.tr, "تم ارسال بريد الكتروني اليك لتأكيد حسابك",false);
              // controller.getProfile();
              Get.offAndToNamed(Routes.SIGN_IN);
            } catch (e) {}
            status = Status.loaded;
            update();
          } else {
            status = Status.fail;
            update();
            areYouSure(Get.context!, () => Get.back(), 'Failed'.tr,
                response.data['message'], true);
          }
        },
      );
    }
  }

  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
