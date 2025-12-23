import 'package:customer/app/core/constants/assets.dart';
import 'package:customer/app/core/widgets/common/custom_loading.dart';
import 'package:customer/app/core/widgets/common/custom_screen_padding.dart';
import 'package:customer/app/core/widgets/common/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:customer/app/modules/page/controllers/page_controller.dart';

import '../../item_details/widgets/app_bar_item_details.dart';

class PageView extends GetView<PageDataController> {
  const PageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScreenPadding(
      child: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          List<ConnectivityResult> connectivity,
          Widget child,
        ) {
          final bool connected =
              !connectivity.contains(ConnectivityResult.none);
          if (connected) {
            return Obx(() => controller.loading.value
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : Column(
                    children: [
                      AppBarItemDetails(),
                      const SizedBox(height: 20),
                      Center(
                          child: Text(
                        controller.page.value!.title!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                      sizer(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Html(
                              data: controller.page.value!.details!,
                              style: {
                                "body": Style(
                                  textAlign: TextAlign.center,
                                  fontSize: FontSize(16.0),
                                ),
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ));
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.asset(AppAssets.noConnection)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "check internet connection".tr,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 30),
              ],
            );
          }
        },
        child: Center(
          child: CustomLoading(),
        ),
      ),
    ));
  }
}
