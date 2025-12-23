import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/widgets/buttons/custom_app_button.dart';
import '../../../core/widgets/common/app_bar/custom_app_bar.dart';
import '../../../core/widgets/common/custom_screen_padding.dart';
import '../../../core/widgets/common/sizer.dart';
import '../../../core/widgets/inputs/custom_text_form_field.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: 'Security Settings',
          ),
          Expanded(
            child: CustomScreenPadding(
              addSafe: false,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextFormFieldWidget(
                      title: "current_password",
                      controller: TextEditingController(),
                      action: (p0) => p0,
                    ),
                    sizer(height: 20),
                    CustomTextFormFieldWidget(
                      title: "new_password",
                      controller: TextEditingController(),
                      action: (p0) => p0,
                    ),
                    sizer(height: 20),
                    CustomTextFormFieldWidget(
                      title: "confirm_new_password",
                      controller: TextEditingController(),
                      action: (p0) => p0,
                    ),
                    sizer(height: 40),
                    CustomAppButton(
                      text: "edit",
                      borderColor: mainColor,
                      action: () {},
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
