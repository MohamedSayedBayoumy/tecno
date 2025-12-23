import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/styles.dart';
import '../../../core/enum.dart';
import '../../../core/widgets/buttons/custom_app_button.dart';
import '../../../core/widgets/buttons/custom_switch_animation.dart';
import '../../../core/widgets/common/custom_asset_image.dart';
import '../../../core/widgets/common/custom_box_shadow.dart';
import '../../../core/widgets/common/custom_loading.dart';
import '../../../core/widgets/common/custom_screen_padding.dart';
import '../../../core/widgets/inputs/custom_text_form_field.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScreenPadding(
        horizontalPadding: 40,
        top: 100,
        bottom: 10,
        child: GetBuilder<ForgotPasswordController>(
          builder: (controller) => Form(
            key: controller.emailKey,
            child: SingleChildScrollView(
              child: IgnorePointer(
                ignoring: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomAssetsImage(
                      imagePath: Assets.assetsImagesNewVersionEdit01,
                      width: 250,
                    ),
                    const SizedBox(height: 30),
                    CustomBoxShadow(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            "reset_password".tr,
                            style: Styles.styleSemiBold16,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "please_enter_email".tr,
                            style: Styles.styleMedium13,
                          ),
                          const SizedBox(height: 40),
                          CustomTextFormFieldWidget(
                            title: "E-mail",
                            controller: controller.emailController,
                            action: (p0) => p0,
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: CustomSwitcherAnimation(
                              condition:
                                  controller.getOtpStatus == Status.loading,
                              firstWidget: const CustomLoading(),
                              secondWidget: CustomAppButton(
                                text: "Apply",
                                action: () {
                                  controller.getOtp();
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
