import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/config.dart';
import '../../../core/constants/styles.dart';
import '../../../core/functions/public/get_lang';
import '../../../core/widgets/common/custom_asset_image.dart';
import '../../../models/list_tile_model.dart';
import '../../../routes/app_pages.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({super.key, required this.model});

  final ListTileModel model;

  changeLang() {
    String value = language() == 'ar' ? 'en' : 'ar';
    Get.updateLocale(Locale(value));
    GetStorage().write('lang', value);
    Get.offAllNamed(Routes.BOTTOMSHEET);
  }

  onTap() {
    if (model.path == "lang") {
      changeLang();
      return;
    }

    if (model.path == "contact") {
      // ignore: deprecated_member_use
      launch(Config.whatsappLink);
      return;
    }

    Get.toNamed(model.path);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: onTap,
      child: Row(
        children: [
          CustomAssetsImage(
            imagePath: model.image,
            width: 20,
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(model.title.tr, style: Styles.styleSemiBold14),
          ),
          InkWell(
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            onTap: onTap,
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
}
