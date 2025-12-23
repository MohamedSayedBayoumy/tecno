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
import '../widgets/timer_widget.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScreenPadding(
        horizontalPadding: 40,
        top: 100,
        bottom: 10,
        child: GetBuilder<ForgotPasswordController>(
          builder: (controller) => Form(
            key: controller.otpKey,
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
                          Text("reset_password".tr,
                              style: Styles.styleSemiBold16),
                          const SizedBox(height: 5),
                          Text(
                              "${"we_send_email".tr} ${controller.emailController.text}",
                              style: Styles.styleMedium13),
                          const SizedBox(height: 40),
                          CustomTextFormFieldWidget(
                            title: "code",
                            hint: "enter_your_code".tr,
                            disableText: true,
                            controller: controller.otpController,
                            action: (p0) => p0,
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: CustomSwitcherAnimation(
                              condition:
                                  controller.sendOtpStatus == Status.loading,
                              firstWidget: const CustomLoading(),
                              secondWidget: CustomAppButton(
                                text: "Apply",
                                action: () {
                                  controller.sendOtp();
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: CountdownTimer(
                              minutes: controller.time,
                            ),
                          ),
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
