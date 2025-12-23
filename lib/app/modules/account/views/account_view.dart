import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/constants/styles.dart';
import '../../../core/widgets/common/custom_asset_image.dart';
import '../../../core/widgets/common/custom_box_shadow.dart';
import '../../../core/widgets/common/custom_loading.dart';
import '../../../core/widgets/common/custom_screen_padding.dart';
import '../../../core/widgets/inputs/custom_text_form_field.dart';
import '../../../routes/app_pages.dart';
import '../controllers/account_controller.dart';
import '../widgets/list_tile_widget.dart';
import '../widgets/logout_button.dart';
import '../widgets/un_auth_card_widget.dart';
import '../widgets/user_card_widget.dart';

import 'package:customer/app/core/constants/colors.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(builder: (controller) {
      return SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            if (controller.isLogin().isNotEmpty) ...[
              const UserCardWidget(),
            ] else ...[
              const UnAuthCardWidget(),
            ],
            const SizedBox(height: 10),
            CustomScreenPadding(
              child: CustomBoxShadow(
                child: Column(
                  children: [
                    ...controller.setting().map((e) {
                      if (e.show == true) {
                        return ListTileWidget(
                          model: e,
                        );
                      }
                      return const SizedBox();
                    }),
                    controller.pages.value.isEmpty
                        ? const Center(
                            child: CustomLoading(),
                          )
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.pages.value.length,
                            itemBuilder: (context, index) {
                              return listTile(
                                  requireAuth: false,
                                  onTap: () => Get.toNamed(Routes.PAGE,
                                      arguments:
                                          controller.pages.value[index].id,
                                      preventDuplicates: false),
                                  icon: Icons.info_outline,
                                  label: controller.pages.value[index].title!);
                            },
                          ),
                  ],
                ),
              ),
            ),
            if (controller.isLogin().isNotEmpty) ...[
              const SizedBox(height: 20),
              const LogoutButton(),
              const SizedBox(height: 40),
              InkWell(
                onTap: () {
                  delete(context, controller);
                },
                child: Container(
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.red.shade700,
                      borderRadius:
                          BorderRadius.circular(AppSizes.borderRadius)),
                  child: Center(
                    child: Text(
                      "delete account".tr,
                      style:
                          Styles.styleSemiBold14.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      );
    });
  }

  Future<dynamic> delete(BuildContext context, AccountController controller) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Form(
          key: controller.deleteFormState,
          child: AlertDialog(
            title: Text('delete account'.tr),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormFieldWidget(
                  title: 'Password'.tr,
                  maxLines: 3,
                  controller: controller.deleteAccountController,
                  action: (v) => controller.deleteAccountController.text = v,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  controller.deleteAccount(
                      password: controller.deleteAccountController.text);
                },
                child: Text(
                  'delete'.tr,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Close the pop-up
                  Navigator.of(context).pop();
                },
                child: Text('close'.tr),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget listTile({
  String? image,
  required bool requireAuth,
  IconData? icon,
  bool? isLang,
  required Function onTap,
  required String label,
}) {
  return requireAuth
      ? const SizedBox()
      : InkWell(
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          onTap: () => onTap(),
          child: Row(
            children: [
              image != null
                  ? CustomAssetsImage(
                      imagePath: image,
                      width: 20,
                    )
                  : Icon(
                      icon,
                      color: mainColor,
                    ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  label.tr,
                  style: Styles.styleSemiBold14,
                ),
              ),
              InkWell(
                overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                onTap: () => onTap,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                  ),
                ),
              )
            ],
          ),
        );
}
