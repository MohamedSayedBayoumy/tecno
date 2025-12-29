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
import 'branchs_widget.dart';
import 'docs_form_widget.dart';

class RegisterFormWidget extends StatelessWidget {
  const RegisterFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreenPadding(
      horizontalPadding: 40,
      child: GetBuilder<RegisterController>(
        builder: (controller) {
          return Column(
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
              // Institution name field

              CustomTextFormFieldWidget(
                title: 'First Name'.tr,
                action: (v) => controller.fName = v,
                isEmail: false,
                titleColor: AppColors.grey,
                titleIcon: Assets.assetsImagesNewVersionPerson,
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(height: 20),
              CustomTextFormFieldWidget(
                title: 'Last Name'.tr,
                action: (v) => controller.lName = v,
                isEmail: false,
                titleColor: AppColors.grey,
                titleIcon: Assets.assetsImagesNewVersionPerson,
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(height: 20),

              CustomTextFormFieldWidget(
                title: 'institution_name'.tr,
                action: (v) => controller.businessNameController.text = v,
                isEmail: false,
                titleColor: AppColors.grey,
                titleIcon: Assets.assetsImagesNewVersionUserRegister,
                controller: controller.businessNameController,
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(height: 20),
              // Phone number field (keep as is)
              CustomPhoneFiledWidget(
                label: "Phone",
                controller: controller.phoneController,
                onCountryChanged: (p0) {
                  controller.countryCode = "+${p0.dialCode}";
                  controller.update();
                },
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 5),
              CustomTextFormFieldWidget(
                title: 'email'.tr,
                action: (v) => controller.email = v,
                isEmail: false,
                titleColor: AppColors.grey,
                titleIcon: Assets.assetsImagesNewVersionEmailRegister,
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(height: 20),
              // Address field
              CustomTextFormFieldWidget(
                title: 'address'.tr,
                action: (v) {},
                isEmail: false,
                titleColor: AppColors.grey,
                titleIcon: Assets.assetsImagesNewVersionHomeRegister,
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(height: 20),
              // Branch field

              BranchesWidget(),

              const SizedBox(height: 20),
              // Password field
              CustomTextFormFieldWidget(
                title: 'password'.tr,
                action: (v) => controller.password = v,
                titleColor: AppColors.grey,
                titleIcon: Assets.assetsImagesNewVersionPadlockRegister,
                suffix: IconButton(
                  onPressed: controller.toggleObscure,
                  icon: Icon(
                    controller.obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.black,
                  ),
                ),
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(height: 20),
              // Confirm password field
              CustomTextFormFieldWidget(
                title: 'confirm_password'.tr,
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
                titleIcon: Assets.assetsImagesNewVersionPadlockRegister,
                suffix: IconButton(
                  onPressed: controller.toggleObscure,
                  icon: Icon(
                    controller.obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.black,
                  ),
                ),
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(height: 20),
              // Tax number field
              CustomTextFormFieldWidget(
                title: 'tax_number'.tr,
                action: (v) {},
                isEmail: false,
                titleColor: AppColors.grey,
                titleIcon: Assets.assetsImagesNewVersionIdCard,
                controller: controller.taxNumberController,
                maxLength: 15,
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(height: 5),
              // Commercial register field
              CustomTextFormFieldWidget(
                title: 'commercial_register'.tr,
                action: (v) {},
                isEmail: false,
                titleColor: AppColors.grey,
                maxLength: 10,
                titleIcon: Assets.assetsImagesNewVersionContractRegister,
                controller: controller.businessNumberController,
                textInputAction: TextInputAction.done,
              ),

              const UploadFilesSection(),
              const SizedBox(height: 20),
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
          );
        },
      ),
    );
  }
}
