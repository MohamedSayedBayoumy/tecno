import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/enum.dart';
import '../../../../core/widgets/common/custom_asset_image.dart';
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
          child: SingleChildScrollView(
            child: GetBuilder<RegisterController>(builder: (controller) {
              return IgnorePointer(
                ignoring: controller.status == Status.loading,
                child: const Column(
                  children: [
                    CustomAssetsImage(
                      imagePath: Assets.assetsImagesNewVersionEdit01,
                      width: 250,
                    ),
                    SizedBox(height: 30),
                    RegisterFormWidget(),
                    SizedBox(height: 20),
                    AuthFooterWidget(
                      isLogin: false,
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
