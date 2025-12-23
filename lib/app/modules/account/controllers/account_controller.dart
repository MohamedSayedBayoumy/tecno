import 'package:customer/app/core/constants/app_assets.dart';
import 'package:customer/app/data/online/DioRequest.dart';
import 'package:customer/app/data/online/auth_parser.dart';
import 'package:customer/app/data/online/data_parser.dart';
import 'package:customer/app/data/online/end_points.dart';
import 'package:customer/app/models/pages/pages_model.dart';
import 'package:customer/app/modules/home/controllers/home_controller.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/enum.dart';
import '../../../data/local/auth_info.dart';
import '../../../models/auth/profile.dart';
import '../../../models/list_tile_model.dart';

class AccountController extends GetxController {
  final homeCTRL = Get.find<HomeController>();
  final deleteFormState = GlobalKey<FormState>();
  final pages = <PagesModel>[].obs;

  Status status = Status.loading;

  ProfileModel? profileModel;

  String get userName => LocalAuthInfo().readEmail().toString();

  final deleteAccountController = TextEditingController();
  @override
  void onInit() {
    getPages();
    AuthParser().isAuth();
    super.onInit();
  }

  String isLogin() => LocalAuthInfo().readEmail() ?? "";

  void logout() {
    LocalAuthInfo().removeInfo();
    // AuthParser();
    DioRequest.dioWithToken = null;
    update();
    homeCTRL.profile.value = null;
    Get.offAllNamed(Routes.BOTTOMSHEET);
  }

  void getPages() async {
    pages.value = await DataParser().getPages();
  }

  List<ListTileModel> setting() => [
        // ListTileModel(
        //   isLogin().isNotEmpty,
        //   title: "Orders",
        //   path: Routes.ORDERS,
        //   image: Assets.assetsImagesNewVersionFrame,
        // ),
        ListTileModel(isLogin().isNotEmpty,
            title: 'My Addresses',
            path: Routes.ADDADDRESSES,
            // path: Routes.address,

            image: Assets.assetsImagesNewVersionBasilMapLocationSolid),
        // ListTileModel(isLogin().isNotEmpty,
        //     title: 'Payment',
        //     path: Routes.payments,
        //     image: Assets.assetsImagesNewVersionSolarCardOutline),
        ListTileModel(true,
            title: 'Language',
            path: "lang",
            image: Assets.assetsImagesNewVersionIconoirLanguage),
        // ListTileModel(isLogin().isNotEmpty,
        //     title: 'Security Settings',
        //     path: Routes.resetPassword,
        //     image: Assets.assetsImagesNewVersionMingcuteSafeShield2Fill),
        ListTileModel(isLogin().isNotEmpty,
            title: "Wishlist",
            path: Routes.WISHLIST,
            image: Assets
                .assetsImagesNewVersionStreamlineUltimateRatingStarRibbon),
        ListTileModel(
          isLogin().isNotEmpty,
          title: "Reviews",
          path: Routes.REVIEWS,
          image: Assets.assetsImagesNewVersionFrame,
        ),
        ListTileModel(
          isLogin().isNotEmpty,
          title: 'notification',
          path: Routes.notification,
          image: Assets.assetsImagesNewVersionBell,
        ),
      ];

  // void deleteAccount({
  //   required String password,
  //
  // })async{
  //   if(deleteFormState.currentState!.validate()){
  //     final response = await postRequest(
  //         urlExt: EndPoints().deleteAccount,
  //         data: {
  //           "password":password,
  //         },
  //         requiredToken: true);
  //     print(response.data);
  //     LocalAuthInfo().removeInfo();
  //     homeCTRL.profile.value = null;
  //     Get.offAllNamed(Routes.HOME);
  //     Get.snackbar(
  //       'Success'.tr,
  //       'delete account success'.tr,
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.green.withOpacity(0.8),
  //       colorText: Colors.white,
  //       duration: const Duration(seconds: 3),
  //     );
  //   }
  // }

  void deleteAccount({
    required String password,
  }) async {
    if (deleteFormState.currentState!.validate()) {
      try {
        final response = await postRequest(
          urlExt: EndPoints().deleteAccount,
          data: {
            "password": password,
          },
          requiredToken: true,
        );

        print("Status code: ${response.statusCode}");
        print("Response data: ${response.data}");
        print("Success field type: ${response.data['status'].runtimeType}");

        if (response.statusCode == 200 &&
            response.data['status'].toString() == 'true') {
          // حذف البيانات محليًا
          LocalAuthInfo().removeInfo();
          homeCTRL.profile.value = null;

          // إغلاق أي حوار مفتوح
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }

          // عرض رسالة نجاح
          Get.snackbar(
            'Success'.tr,
            'delete account success'.tr,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.8),
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );

          // انتظر شوية ثم انتقل للـ Home
          await Future.delayed(const Duration(seconds: 2));
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.snackbar(
            'Error'.tr,
            response.data['message'] ?? 'Incorrect password'.tr,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.8),
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
        }
      } catch (e) {
        Get.snackbar(
          'Error'.tr,
          'Something went wrong. Please try again'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    }
  }
}
