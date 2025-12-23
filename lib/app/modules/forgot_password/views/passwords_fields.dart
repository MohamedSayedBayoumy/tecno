import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/widgets/common/custom_asset_image.dart';
import '../../../core/widgets/common/custom_screen_padding.dart';
import '../widgets/passwords_fields_widget.dart';

class PasswordsFieldsScreen extends StatelessWidget {
  const PasswordsFieldsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScreenPadding(
        horizontalPadding: 40,
        top: 100,
        bottom: 10,
        child: SingleChildScrollView(
            child: IgnorePointer(
          ignoring: false,
          child: Column(
            children: [
              CustomAssetsImage(
                imagePath: Assets.assetsImagesNewVersionEdit01,
                width: 250,
              ),
              SizedBox(height: 30),
              PasswordsFieldsWidget(),
              SizedBox(height: 20),
            ],
          ),
        )),
      ),
    );
  }
}
