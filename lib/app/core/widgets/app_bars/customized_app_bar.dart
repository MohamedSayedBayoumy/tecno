import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:customer/app/core/constants/assets.dart';
import 'package:customer/app/core/constants/styles.dart';
import 'package:customer/app/core/widgets/common/sizer.dart';
import 'package:customer/app/core/widgets/inputs/custom_text_form_field.dart';
import 'package:customer/app/core/widgets/labels/label_style.dart';
import 'package:customer/app/modules/home/controllers/home_controller.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';

class customizedAppbar extends StatelessWidget implements PreferredSizeWidget {
  bool? automaticallyImplyLeading;
  String label;
  Widget? bottom;
  Function(String)? onSearch;
  final controller = Get.find<HomeController>();

  customizedAppbar(
      {this.automaticallyImplyLeading,
      required this.label,
      this.bottom,
      this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            // statusBarBrightness: Brightness.light,
            statusBarColor: Colors.white
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          automaticallyImplyLeading: automaticallyImplyLeading ?? true,
          iconTheme: IconThemeData(color: mainColor),
          centerTitle: true,
          title: SizedBox(
              height: kTextTabBarHeight * .70,
              child: CustomTextFormFieldWidget(
                prefix: const Icon(Icons.search),
                label: 'Search'.tr,
                onTap: () => Get.toNamed(Routes.SEARCH),
                action: (v) {
                  if (onSearch != null) {
                    onSearch!(v);
                  } else {
                    Get.toNamed(Routes.SEARCH,arguments: controller.categories);
                  }
                },
              )),
          elevation: 0,
          bottom: null,
          actions: [
            IconButton(
              icon:  Icon(Icons.qr_code_scanner, color: mainColor),
              onPressed: () async {
                // هنا بنعمل سكان للباركود
               
              },
            ),
            SizedBox(width: 10),
          ],

          // actions: [
          //
          //   InkWell(
          //     onTap: () => Get.toNamed(Routes.HOME),
          //     child: SizedBox(
          //         height: kTextTabBarHeight,
          //         child: Image.asset(
          //           Assets.logo,
          //           fit: BoxFit.cover,
          //         )),
          //   ),
          //   SizedBox(width: 10),
          // ],
          shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50))),
        ),
        // Obx(
        //   () => Row(
        //     children: [
        //       const Icon(
        //         Icons.location_on_rounded,
        //         color: Colors.black,
        //       ),
        //       Expanded(
        //         child: RichText(
        //             maxLines: 1,
        //             text: TextSpan(children: [
        //               TextSpan(
        //                 text: 'Deliver to '.tr,
        //                 style: styles().normalGrey,
        //               ),
        //               TextSpan(
        //                 text: controller.address.value ?? 'Un defined'.tr,
        //                 style: styles().normal,
        //               ),
        //             ])),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight * 2);
}
Future<String?> scanBarcode() async {
  try {
    var result = await BarcodeScanner.scan();
    return result.rawContent; // ده اللي بيرجعلك البركود
  } catch (e) {
    print("Barcode scan error: $e");
    return null;
  }
}
