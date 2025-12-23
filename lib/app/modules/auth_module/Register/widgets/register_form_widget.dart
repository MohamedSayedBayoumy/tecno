import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/enum.dart';
import '../../../../core/widgets/buttons/custom_app_button.dart';
import '../../../../core/widgets/buttons/custom_switch_animation.dart';
import '../../../../core/widgets/common/custom_box_shadow.dart';
import '../../../../core/widgets/common/custom_loading.dart';
import '../../../../core/widgets/common/custom_screen_padding.dart';
import '../../../../core/widgets/inputs/custom_phone_field.dart';
import '../../../../core/widgets/inputs/custom_text_form_field.dart';
import '../controllers/register_controller.dart';

class RegisterFormWidget extends StatelessWidget {
  const RegisterFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreenPadding(
      horizontalPadding: 40,
      child: CustomBoxShadow(
        child: GetBuilder<RegisterController>(
          builder: (controller) => Column(
            children: [
              const SizedBox(height: 10),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  "Register".tr,
                  style: Styles.styleExtraBold18,
                ),
              ),
              const SizedBox(height: 30),
              CustomTextFormFieldWidget(
                title: 'First Name'.tr,
                action: (v) => controller.fName = v,
                isEmail: false,
                titleColor: AppColors.grey,
                titleIcon: Assets.assetsImagesNewVersionPerson,
              ),
              const SizedBox(height: 20),
              CustomTextFormFieldWidget(
                title: 'Last Name'.tr,
                action: (v) => controller.lName = v,
                isEmail: false,
                titleColor: AppColors.grey,
                titleIcon: Assets.assetsImagesNewVersionPerson,
              ),
              const SizedBox(height: 20),
              CustomTextFormFieldWidget(
                title: 'E-mail'.tr,
                action: (v) => controller.email = v,
                isEmail: false,
                titleColor: AppColors.grey,
                titleIcon: Assets.assetsImagesNewVersionPerson,
              ),
              const SizedBox(height: 20),
              CustomPhoneFiledWidget(
                label: "Phone",
                controller: controller.phoneController,
                onCountryChanged: (p0) {
                  controller.countryCode = "+${p0.dialCode}";
                  controller.update();
                },
              ),
              CustomTextFormFieldWidget(
                title: 'Password'.tr,
                action: (v) => controller.password = v,
                titleColor: AppColors.grey,
                titleIcon: Assets.assetsImagesNewVersionPin,
                suffix: IconButton(
                  onPressed: controller.toggleObscure,
                  icon: Icon(
                    controller.obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomTextFormFieldWidget(
                title: 'Password confirmation'.tr,
                action: (v) => controller.passwordConfirmation = v,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "validation_filed".tr;
                  } else if (controller.passwordConfirmation !=
                      controller.password) {
                    return "incorrect_password".tr;
                  }

                  return null;
                },
                titleColor: AppColors.grey,
                titleIcon: Assets.assetsImagesNewVersionPin,
                suffix: IconButton(
                  onPressed: controller.toggleObscure,
                  icon: Icon(
                    controller.obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              CustomSwitcherAnimation(
                condition: controller.status == Status.loading,
                firstWidget: const CustomLoading(),
                secondWidget: CustomAppButton(
                  text: 'Register'.tr,
                  action: controller.register,
                  style: Styles.styleSemiBold14.copyWith(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
