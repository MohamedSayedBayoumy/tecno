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
import '../../../../core/widgets/common/custom_underline_text.dart';
import '../../../../core/widgets/inputs/custom_text_form_field.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/sign_in_controller.dart';

class AuthFormWidget extends StatelessWidget {
  const AuthFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBoxShadow(
      child: GetBuilder<SignInController>(builder: (controller) {
        return Column(
          children: [
            const SizedBox(height: 10),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                "Login".tr,
                style: Styles.styleExtraBold18,
              ),
            ),
            const SizedBox(height: 30),
            CustomTextFormFieldWidget(
              title: 'E-mail'.tr,
              action: (v) => controller.email = v,
              isEmail: false,
              titleColor: AppColors.grey,
              titleIcon: Assets.assetsImagesNewVersionPerson,
            ),
            const SizedBox(height: 20),
            CustomTextFormFieldWidget(
              title: 'Password'.tr,
              action: (v) => controller.password = v,
              obscure: controller.obscure,
              titleColor: AppColors.grey,
              titleIcon: Assets.assetsImagesNewVersionPin,
              maxLines: 1,
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
            const SizedBox(height: 4),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: CustomUnderlineText(
                offset: const Offset(0, 0),
                textWidget: Text(
                  "forgot_password".tr,
                  style: Styles.styleBold11,
                ),
                onTap: () {
                  Get.toNamed(Routes.forgotPassword);
                },
              ),
            ),
            const SizedBox(height: 40),
            CustomSwitcherAnimation(
              condition: controller.status == Status.loading,
              firstWidget: const CustomLoading(),
              secondWidget: CustomAppButton(
                text: 'Login'.tr,
                action: () => controller.login(),
                style: Styles.styleSemiBold14.copyWith(color: Colors.white),
              ),
            )
          ],
        );
      }),
    );
  }
}
