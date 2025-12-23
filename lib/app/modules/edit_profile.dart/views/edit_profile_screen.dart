import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/enum.dart';
import '../../../core/widgets/common/app_bar/custom_app_bar.dart';
import '../../../core/widgets/common/custom_loading.dart';
import '../controllers/edit_profile_controller.dart';
import '../widgets/from_filed_edit_profile.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: EditProfileController(),
        builder: (controller) {
          switch (controller.status) {
            case Status.loading:
              return const Center(
                child: CustomLoading(),
              );
            case Status.loaded:
              return SingleChildScrollView(
                child: Column(
                  children: [
                    CustomAppBar(
                      title: "profile".tr,
                    ),
                    IgnorePointer(
                      ignoring: controller.status == Status.loading ||
                          controller.statusUpdateProfile == Status.loading,
                      child: EditProfileFormFiledWidget(),
                    )
                  ],
                ),
              );
            case Status.fail:
              return SizedBox();
          }
        },
      ),
    );
  }
}
