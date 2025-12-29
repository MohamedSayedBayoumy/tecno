// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:intl_phone_field/countries.dart';
// import 'package:intl_phone_field/country_picker_dialog.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:intl_phone_field/phone_number.dart';

// import '../../constants/colors.dart';
// import '../../constants/sizes.dart';
// import '../../constants/styles.dart';
// import '../../functions/public/get_lang';
// import '../common/custom_asset_image.dart';

// class CustomPhoneFiledWidget extends StatelessWidget {
//   const CustomPhoneFiledWidget({
//     super.key,
//     required this.controller,
//     this.countryCode = "",
//     this.onChanged,
//     this.iconPath,
//     this.label,
//     this.onCountryChanged,
//   });
//   final TextEditingController controller;
//   final String countryCode;
//   final void Function(PhoneNumber)? onChanged;
//   final String? iconPath, label;
//   final void Function(Country)? onCountryChanged;

//   border({Color? color}) => OutlineInputBorder(
//         borderRadius: BorderRadius.circular(AppSizes.borderRadius),
//         borderSide: BorderSide(color: color ?? Colors.transparent),
//       );

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             if (iconPath != null) ...[
//               CustomAssetsImage(imagePath: iconPath!, width: 16),
//               const SizedBox(width: 3),
//             ],
//             Text(
//               "${label!.tr}:",
//               style: Styles.styleBold15.copyWith(color: AppColors.grey),
//             ),
//           ],
//         ),
//         Directionality(
//           textDirection:
//               language() == "en" ? TextDirection.ltr : TextDirection.rtl,
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.transparent,
//               borderRadius: BorderRadius.circular(AppSizes.borderRadius),
//               boxShadow: const [
//                 BoxShadow(
//                   color: Color(0xfffafafa),
//                   blurRadius: 10,
//                   offset: Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: IntlPhoneField(
//               controller: controller,
//               onCountryChanged: onCountryChanged,
//               decoration: InputDecoration(
//                 errorStyle: const TextStyle(
//                   color: Colors.red,
//                 ),
//                 labelText: "",
//                 border: border(),
//                 enabledBorder: border(color: textFieldBackGround),
//                 focusedBorder: border(color: mainColor),
//                 errorBorder: border(color: Colors.red),
//                 disabledBorder: border(),
//                 focusedErrorBorder: border(color: Colors.red),
//               ),
//               initialCountryCode: countryCode.isEmpty ? "SA" : countryCode,
//               initialValue: countryCode.isEmpty ? "SA" : countryCode,
//               showCountryFlag: false,
//               validator: (p0) {
//                 if (p0!.toString().isEmpty) {
//                   return "validation_filed".tr;
//                 }
//                 return null;
//               },
//               inputFormatters: [
//                 FilteringTextInputFormatter.digitsOnly,
//                 FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//               ],
//               pickerDialogStyle: PickerDialogStyle(
//                 countryCodeStyle: Styles.styleBold15.copyWith(
//                   fontFamily: "en_family",
//                 ),
//                 countryNameStyle: Styles.styleBold15.copyWith(
//                   fontFamily: "en_family",
//                 ),
//               ),
//               dropdownTextStyle: Styles.styleBold15.copyWith(
//                 fontFamily: "en_family",
//                 color: Colors.black,
//               ),
//               invalidNumberMessage: "invalid_phone".tr,
//               keyboardType: TextInputType.number,
//               onChanged: onChanged,

//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';
import '../../constants/styles.dart';
import '../../functions/public/get_lang';
import '../common/custom_asset_image.dart';

class CustomPhoneFiledWidget extends StatelessWidget {
  const CustomPhoneFiledWidget({
    super.key,
    required this.controller,
    this.countryCode = "SA",
    this.onChanged,
    this.iconPath,
    this.label,
    this.onCountryChanged,
    this.textInputAction,
  });

  final TextEditingController controller;
  final String countryCode;
  final void Function(PhoneNumber)? onChanged;
  final String? iconPath, label;
  final void Function(Country)? onCountryChanged;
  final TextInputAction? textInputAction;

  OutlineInputBorder border({Color? color}) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        borderSide: BorderSide(color: color ?? Colors.transparent),
      );

  /// ✅ Saudi phone validation
  String? _saudiPhoneValidator(PhoneNumber? phone) {
    if (phone == null || phone.number.isEmpty) {
      return "validation_filed".tr;
    }

    // تأكيد إن الدولة السعودية
    if (phone.countryISOCode != 'SA') {
      return "only_saudi_numbers".tr;
    }

    final number = phone.number;

    // لازم يبدأ بـ 5 وطوله 9 أرقام
    final saudiRegex = RegExp(r'^5\d{8}$');

    if (!saudiRegex.hasMatch(number)) {
      return "invalid_saudi_phone".tr;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (iconPath != null) ...[
              CustomAssetsImage(imagePath: iconPath!, width: 16),
              const SizedBox(width: 4),
            ],
            Text(
              "${label?.tr ?? ""}:",
              style: Styles.styleBold15.copyWith(color: AppColors.grey),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Directionality(
          textDirection:
              language() == "en" ? TextDirection.ltr : TextDirection.rtl,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.borderRadius),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xfffafafa),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: IntlPhoneField(
              textInputAction: textInputAction,
              controller: controller,
              initialCountryCode: countryCode,
              showCountryFlag: false,
              keyboardType: TextInputType.number,
              onCountryChanged: onCountryChanged,
              onChanged: onChanged,
              validator: _saudiPhoneValidator,
              invalidNumberMessage: "invalid_saudi_phone".tr,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                labelText: "",
                errorStyle: const TextStyle(color: Colors.red),
                border: border(),
                enabledBorder: border(color: textFieldBackGround),
                focusedBorder: border(color: mainColor),
                errorBorder: border(color: Colors.red),
                focusedErrorBorder: border(color: Colors.red),
                disabledBorder: border(),
              ),
              pickerDialogStyle: PickerDialogStyle(
                countryCodeStyle: Styles.styleBold15.copyWith(
                  fontFamily: "en_family",
                ),
                countryNameStyle: Styles.styleBold15.copyWith(
                  fontFamily: "en_family",
                ),
              ),
              dropdownTextStyle: Styles.styleBold15.copyWith(
                fontFamily: "en_family",
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
