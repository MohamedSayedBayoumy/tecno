import 'package:customer/app/data/online/auth_parser.dart';
import 'package:customer/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../core/enum.dart';
import '../../../../core/services/firebase_messaging.dart';
import '../../../../data/local/auth_info.dart';
import '../../../../routes/app_pages.dart';

class SignInController extends GetxController {
  String? email, password;
  final formKey = GlobalKey<FormState>();
  bool obscure = false;
  void toggleObscure() {
    obscure = !obscure;
    update();
  }

  Status status = Status.loaded;

  void login() async {
    if (formKey.currentState!.validate()) {
      status = Status.loading;
      update();
      FirebaseNotificationServices.getFcmToken((p0) async {
        final auth = await AuthParser().signIn(
          email: email ?? '',
          password: password ?? '',
          token: p0,
        );

        if (auth) {
          try {
            final controller = Get.find<HomeController>();
            controller.getProfile();
          } catch (e) {}
          LocalAuthInfo().saveInfo(
            email: email ?? '',
            password: password ?? '',
          );
          AppPages.routes();

          status = Status.loaded;

          update();

          Get.offAllNamed(Routes.BOTTOMSHEET);
        } else {
          status = Status.fail;

          update();
        }
      });
    }
  }
}
