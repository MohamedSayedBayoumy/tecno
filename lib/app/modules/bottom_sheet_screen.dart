import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constants/app_assets.dart';
import '../core/utils.dart';
import '../core/widgets/common/custom_asset_image.dart';
import '../data/local/auth_info.dart';
import 'account/views/account_view.dart';
import 'categories/views/categories_view.dart';
import 'home/controllers/home_controller.dart';
import 'home/views/home_view.dart';
import 'invoice/invoice_screen.dart';
import 'offers/views/offers_view.dart';
import 'order_module/orders/views/orders_view.dart';

class BottomSheetScreen extends StatefulWidget {
  const BottomSheetScreen({super.key});

  @override
  State<BottomSheetScreen> createState() => _BottomSheetScreenState();
}

class _BottomSheetScreenState extends State<BottomSheetScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: PageView(
          controller: AppUtils.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const HomeView(),
            if ((LocalAuthInfo().readEmail() ?? "").isNotEmpty) ...[
              const OrdersView(),
              const InvoiceScreen(),
            ],

            // const OffersView(),
            const CategoriesView(),
            const AccountView()
          ],
        ),
      ),
      bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) {
              final homeController = Get.find<HomeController>();
              if (homeController.loading.value == false) {
                AppUtils.pageController.jumpToPage(value);
                currentIndex = value;
                setState(() {});
              }
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: const Color(0xFF1C1C3A),
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.normal),
            selectedIconTheme: const IconThemeData(color: Color(0xFF1C1C3A)),
            items: [
              BottomNavigationBarItem(
                icon: const CustomAssetsImage(
                  imagePath: Assets.assetsImagesNewVersionHome2,
                  width: 25,
                  imageColor: Color(0xff838383),
                ),
                activeIcon: const CustomAssetsImage(
                  imagePath: Assets.assetsImagesNewVersionHome2,
                  width: 25,
                  imageColor: Color(0xFF1C1C3A),
                ),
                label: "Home".tr,
              ),
              if ((LocalAuthInfo().readEmail() ?? "").isNotEmpty) ...[
                BottomNavigationBarItem(
                  icon: const CustomAssetsImage(
                    imagePath: Assets.assetsImagesNewVersionHugeiconsDateTime,
                    width: 25,
                  ),
                  activeIcon: const CustomAssetsImage(
                    imagePath: Assets.assetsImagesNewVersionHugeiconsDateTime,
                    width: 25,
                    imageColor: Color(0xFF1C1C3A),
                  ),
                  label: "my_orders".tr,
                ),
                BottomNavigationBarItem(
                  icon: const CustomAssetsImage(
                    imagePath: "assets/images/invoice.png",
                    width: 25,
                    imageColor: Color(0xff838383),
                  ),
                  activeIcon: const CustomAssetsImage(
                    imagePath: "assets/images/invoice.png",
                    width: 25,
                    imageColor: Color(0xFF1C1C3A),
                  ),
                  label: 'Invoices'.tr,
                ),
              ],

              // BottomNavigationBarItem(
              //   icon: const CustomAssetsImage(
              //     imagePath: Assets.assetsImagesNewVersionHotDeal,
              //     width: 25,
              //     imageColor: Color(0xff838383),
              //   ),
              //   activeIcon: const CustomAssetsImage(
              //     imagePath: Assets.assetsImagesNewVersionHotSale,
              //     width: 25,
              //     imageColor: Color(0xFF1C1C3A),
              //   ),
              //   label: 'Offers'.tr,
              // ),
              BottomNavigationBarItem(
                icon: const CustomAssetsImage(
                  imagePath: Assets.assetsImagesNewVersionCategories,
                  width: 25,
                ),
                activeIcon: const CustomAssetsImage(
                  imagePath: Assets.assetsImagesNewVersionCategory,
                  width: 25,
                  imageColor: Color(0xFF1C1C3A),
                ),
                label: 'Categories'.tr,
              ),
              BottomNavigationBarItem(
                icon: const CustomAssetsImage(
                  imagePath: Assets.assetsImagesNewVersionWeuiSettingOutlined,
                  width: 25,
                ),
                activeIcon: const CustomAssetsImage(
                  imagePath: Assets.assetsImagesNewVersionWeuiSettingOutlined,
                  width: 25,
                  imageColor: Color(0xFF1C1C3A),
                ),
                label: 'setting'.tr,
              ),
            ],
          )),
    );
  }
}
