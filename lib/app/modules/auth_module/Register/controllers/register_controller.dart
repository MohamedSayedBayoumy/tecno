import 'dart:io';

import 'package:customer/app/data/online/DioRequest.dart';
import 'package:customer/app/data/online/end_points.dart';
import 'package:customer/app/data/online/state_handler.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:dio/dio.dart' as dioData;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart' as getData;
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/enum.dart';
import '../../../../core/services/compse_files.dart';
import '../../../../core/services/firebase_messaging.dart';
import '../../../../core/services/pick_image_file_services.dart';
import '../../../../data/local/auth_info.dart';
import '../models/branch_model.dart';

class RegisterController extends getData.GetxController {
  final formKey = GlobalKey<FormState>();
  String? fName,
      lName,
      email,
      phone,
      password,
      passwordConfirmation,
      countryCode,
      address ;

  TextEditingController phoneController = TextEditingController();
  TextEditingController businessNumberController = TextEditingController();
  TextEditingController taxNumberController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  PickedImageFile? commercialRegisterImage;
  PickedImageFile? taxNumberImage;
  PickedImageFile? addressImage;

  Status status = Status.loaded;
  Status branchesStatus = Status.loading;
  String? errorMessage;

  bool obscure = false;
  void toggleObscure() {
    obscure = !obscure;
    update();
  }

  void register() async {
    if (formKey.currentState!.validate()) {
      status = Status.loading;
      update();

      FirebaseNotificationServices.getFcmToken(
        (p0) async {
          // Build files list only for selected images to avoid errors.
          final List<dioData.MultipartFile> files = [];
          if (commercialRegisterImage != null) {
            final compressedFile = await UniversalCompressor()
                .compress(File(commercialRegisterImage!.path));
            files.add(
              await dioData.MultipartFile.fromFile(
                compressedFile.file.path,
                filename: compressedFile.file.name,
              ),
            );
          }
          if (taxNumberImage != null) {
            final compressedFile = await UniversalCompressor()
                .compress(File(commercialRegisterImage!.path));
            files.add(
              await dioData.MultipartFile.fromFile(
                compressedFile.file.path,
                filename: compressedFile.file.name,
              ),
            );
          }

          if (addressImage != null) {
            final compressedFile =
                await UniversalCompressor().compress(File(addressImage!.path));
            files.add(
              await dioData.MultipartFile.fromFile(
                compressedFile.file.path,
                filename: compressedFile.file.name,
              ),
            );
          }

          final Map<String, dynamic> data = {
            if (files.isNotEmpty) 'files': files,
            "first_name": fName,
            "last_name": lName,
            'email': email,
            "phone":
                int.parse("${countryCode ?? "+20"}${phoneController.text}"),
            'password': password,
            'password_confirmation': passwordConfirmation,
            'business_name': businessNameController.text,
            'address': address,
            'branch_id': selectedBranch?.id,
            'business_registeration_number': businessNumberController.text,
            'tax_id': taxNumberController.text,
            'fcm_token': p0,
          };

          final response = await postRequest(
            urlExt: EndPoints().register,
            data: data,
            isJson: false,
          );
          print(response);
          if (response.data['status']) {
            status = Status.loaded;
            update();
            LocalAuthInfo().saveInfo(
              email: email ?? '',
              password: password ?? '',
            );
            AppPages.routes();
            try {
              // areYouSure(Get.context!, () {
              //   Get.offAndToNamed(Routes.SIGN_IN);
              // }, 'تأكيد'.tr, "تم ارسال بريد الكتروني اليك لتأكيد حسابك",false);
              // controller.getProfile();
              getData.Get.offAndToNamed(Routes.SIGN_IN);
            } catch (e) {}
            status = Status.loaded;
            update();
          } else {
            status = Status.fail;
            update();
            areYouSure(getData.Get.context!, () => getData.Get.back(),
                'Failed'.tr, response.data['message'], true);
          }
        },
      );
    }
  }

  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void onInit() {
    super.onInit();
    getBranches();
  }

  BranchesResponse? branchesResponse;
  BranchRegisterModel? selectedBranch;

  getBranches() async {
    try {
      branchesStatus = Status.loading;
      update();
      final response = await getRequest(urlExt: EndPoints().branches);
      print(response.data);

      if (response.data['status']) {
        branchesResponse = BranchesResponse.fromJson(response.data);
        branchesStatus = Status.loaded;
        update();
      } else {
        branchesStatus = Status.fail;
        update();
        areYouSure(getData.Get.context!, () => getData.Get.back(), 'Failed'.tr,
            response.data['message'], true);
      }
    } on dioData.DioException catch (e) {
      print(e.response?.data);
      branchesStatus = Status.fail;

      update();
    }
  }
}
