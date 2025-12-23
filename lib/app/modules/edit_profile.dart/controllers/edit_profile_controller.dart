import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import '../../../core/enum.dart';
import '../../../core/functions/status/success.dart';
import '../../../data/local/auth_info.dart';
import '../../../data/online/auth_parser.dart';
import '../../../models/auth/profile.dart';
import '../../account/controllers/account_controller.dart';
import '../../home/controllers/home_controller.dart';

class EditProfileController extends GetxController {
  ProfileModel? profile;
  final formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  PhoneNumber? phoneNumber;
  String countryCode = "EG";
  String digitalCode = "+20";
  TextEditingController phoneNameController = TextEditingController(text: "");
  TextEditingController emailNameController = TextEditingController();

  Status status = Status.loading;
  Status statusUpdateProfile = Status.loaded;

  void getProfile() async {
    try {
      status = Status.loading;
      update();
      profile = await AuthParser().getProfile();
      firstNameController.text = profile!.data!.firstName ?? "";
      lastNameController.text = profile!.data!.lastName ?? "";
      emailNameController.text = profile!.data!.email ?? "";
      try {
        phoneNumber = PhoneNumber.parse(profile!.data!.phone.toString());
        phoneNameController.text = phoneNumber!.nsn;
        digitalCode = "+${phoneNumber!.countryCode}";
        countryCode =
            phoneNumber!.isoCode.toString().split(".").last.toString();
        update();
      } on PhoneNumberException catch (_) {
        phoneNameController.text = profile!.data!.phone.toString();
      }

      status = Status.loaded;
    } catch (e) {
      status = Status.fail;
      renderFailedStatus();
      Get.back();
    }
    update();
  }

  updateProfile() async {
    if (formKey.currentState!.validate()) {
      try {
        statusUpdateProfile = Status.loading;
        update();
        final profile = await AuthParser().updateProfile({
          'first_name': firstNameController.text,
          'last_name': lastNameController.text,
          'phone': phoneNameController.text.isNotEmpty
              ? "$digitalCode${phoneNameController.text}"
              : "",
          'email': emailNameController.text,
        });
        Get.find<HomeController>().profile.value = profile;
        Get.find<AccountController>().update();

        final password = LocalAuthInfo().readPassword();
        Get.back();

        LocalAuthInfo()
            .saveInfo(email: emailNameController.text, password: password!);
        statusUpdateProfile = Status.loaded;
        renderSuccess();
      } catch (e) {
        statusUpdateProfile = Status.fail;
        renderFailedStatus();
      }
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }
}
