import 'package:customer/app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/enum.dart';
import '../../../../core/widgets/common/custom_asset_image.dart';
import '../../../../core/widgets/common/custom_screen_padding.dart';
import '../../auth_footer_widget.dart';
import '../controllers/sign_in_controller.dart';
import '../widgets/auth_form_widget.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScreenPadding(
        horizontalPadding: 40,
        top: 100,
        bottom: 10,
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: GetBuilder<SignInController>(builder: (controller) {
              return IgnorePointer(
                ignoring: controller.status == Status.loading,
                child: const Column(
                  children: [
                    CustomAssetsImage(
                      imagePath: "assets/images/applogo.png",
                      width: 250,
                    ),
                    SizedBox(height: 30),
                    AuthFormWidget(),
                    SizedBox(height: 20),
                    AuthFooterWidget(
                      isLogin: true,
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
