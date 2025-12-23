import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/enum.dart';
import '../../../core/widgets/buttons/custom_app_button.dart';
import '../../../core/widgets/buttons/custom_switch_animation.dart';
import '../../../core/widgets/common/custom_box_shadow.dart';
import '../../../core/widgets/common/custom_loading.dart';
import '../../../core/widgets/inputs/custom_text_form_field.dart';
import '../controllers/forgot_password_controller.dart';

class PasswordsFieldsWidget extends StatelessWidget {
  const PasswordsFieldsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBoxShadow(
      child: GetBuilder<ForgotPasswordController>(
        builder: (controller) => Form(
          key: controller.passwordKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormFieldWidget(
                title: 'new_password'.tr,
                controller: controller.newPassword,
                action: (v) => v,
                isEmail: false,
                titleColor: AppColors.grey,
                titleIcon: Assets.assetsImagesNewVersionPin,
              ),
              const SizedBox(height: 20),
              CustomTextFormFieldWidget(
                title: 'confirm_new_password'.tr,
                controller: controller.confirmNewPassword,
                action: (v) => v,
                titleColor: AppColors.grey,
                titleIcon: Assets.assetsImagesNewVersionPin,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "validation_filed".tr;
                  }
                  if (value != controller.newPassword.text) {
                    return "passwords_do_not_match".tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: CustomSwitcherAnimation(
                  condition: controller.resetPasswordStatus == Status.loading,
                  firstWidget: const CustomLoading(),
                  secondWidget: CustomAppButton(
                    text: "Apply",
                    action: () {
                      controller.resetPassword();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
