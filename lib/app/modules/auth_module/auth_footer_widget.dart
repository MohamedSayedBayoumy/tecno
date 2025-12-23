import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/styles.dart';
import '../../core/widgets/common/custom_screen_padding.dart';
import '../../core/widgets/common/custom_underline_text.dart';
import '../../routes/app_pages.dart';

class AuthFooterWidget extends StatelessWidget {
  const AuthFooterWidget({
    super.key,
    required this.isLogin,
  });

  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return CustomScreenPadding(
      horizontalPadding: 40,
      addSafe: false,
      child: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.center,
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                text: "${"Don't have account?".tr} ",
                style: Styles.styleBold11.copyWith(color: Colors.black),
              ),
              TextSpan(
                  text: (!isLogin ? 'Login' : 'Register').tr,
                  style: Styles.styleBold11.copyWith(color: AppColors.purple),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => isLogin
                        ? Get.offNamed(Routes.REGISTER)
                        : Get.offNamed(Routes.SIGN_IN))
            ])),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: AppColors.grey,
                  thickness: .5,
                ),
              ),
              const SizedBox(width: 20),
              Text(
                "or".tr,
                style: Styles.styleBold11.copyWith(color: AppColors.grey),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Divider(
                  color: AppColors.grey,
                  thickness: .5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          CustomUnderlineText(
            offset: const Offset(0, 0),
            textWidget: Text(
              "as_guest".tr,
              style: Styles.styleBold11.copyWith(color: Colors.black),
            ),
            onTap: () {
              Get.offAllNamed(Routes.BOTTOMSHEET);
            },
          ),
        ],
      ),
    );
  }
}
