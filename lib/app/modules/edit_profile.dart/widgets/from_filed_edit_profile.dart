import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../core/enum.dart';
import '../../../core/widgets/common/custom_loading.dart';
import '../../../core/widgets/inputs/custom_phone_field.dart';
import '../../../core/widgets/inputs/custom_text_form_field.dart';
import '../../../core/widgets/labels/label_style.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileFormFiledWidget extends StatelessWidget {
  EditProfileFormFiledWidget({
    super.key,
  });

  final controller = Get.find<EditProfileController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            CustomTextFormFieldWidget(
              title: "First Name",
              controller: controller.firstNameController,
              action: (p0) => p0,
            ),
            const SizedBox(height: 20),
            CustomTextFormFieldWidget(
              title: "Last Name",
              controller: controller.lastNameController,
              action: (p0) => p0,
            ),
            const SizedBox(height: 20),
            CustomTextFormFieldWidget(
              title: "E-mail",
              controller: controller.emailNameController,
              action: (p0) => p0,
            ),
            const SizedBox(height: 20),
            CustomPhoneFiledWidget(
              label: "Phone",
              controller: controller.phoneNameController,
              countryCode: controller.countryCode,
              onCountryChanged: (p0) {
                controller.digitalCode = "+${p0.dialCode}";
                controller.update();
              },
            ),
            const SizedBox(height: 20),
            if (controller.status == Status.loading ||
                controller.statusUpdateProfile == Status.loading) ...[
              const CustomLoading()
            ] else ...[
              InkWell(
                onTap: () {
                  controller.updateProfile();
                },
                overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                child: Container(
                  height: kTextTabBarHeight,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: labelStyle(
                        text: 'update'.tr,
                        style: Styles.styleBold15
                            .copyWith(color: Colors.white, height: 2)),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
