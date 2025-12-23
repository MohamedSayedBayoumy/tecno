import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/enum.dart';
import '../../../../core/widgets/buttons/custom_app_button.dart';
import '../../../../core/widgets/common/custom_asset_image.dart';
import '../../../../core/widgets/common/custom_loading.dart';
import '../../auth_footer_widget.dart';
import '../controllers/register_controller.dart';
import '../widgets/register_form_widget.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: GetBuilder<RegisterController>(builder: (controller) {
            switch (controller.branchesStatus) {
              case Status.loading:
                return const Center(
                  child: CustomLoading(),
                );
              case Status.loaded:
                return SingleChildScrollView(
                  child: IgnorePointer(
                    ignoring: controller.status == Status.loading,
                    child: const Column(
                      children: [
                        CustomAssetsImage(
                          imagePath: "assets/images/applogo.png",
                          width: 250,
                        ),
                        SizedBox(height: 10),
                        RegisterFormWidget(),
                        SizedBox(height: 20),
                        AuthFooterWidget(
                          isLogin: false,
                        ),
                      ],
                    ),
                  ),
                );
              case Status.fail:
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'error_message'.tr,
                        style: Styles.styleExtraBold15
                            .copyWith(color: Colors.black),
                      ),
                      const SizedBox(height: 10),
                      CustomAppButton(
                        text: 'try_again',
                        action: controller.getBranches,
                      ),
                    ],
                  ),
                );
            }
          }),
        ),
      ),
    );
  }
}
