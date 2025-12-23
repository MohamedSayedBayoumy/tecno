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
    this.countryCode = "",
    this.onChanged,
    this.iconPath,
    this.label,
    this.onCountryChanged,
  });
  final TextEditingController controller;
  final String countryCode;
  final void Function(PhoneNumber)? onChanged;
  final String? iconPath, label;
  final void Function(Country)? onCountryChanged;

  border({Color? color}) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        borderSide: BorderSide(color: color ?? Colors.transparent),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (iconPath != null) ...[
              CustomAssetsImage(imagePath: iconPath!, width: 16),
              const SizedBox(width: 3),
            ],
            Text(
              "${label!.tr}:",
              style: Styles.styleBold15.copyWith(color: AppColors.grey),
            ),
          ],
        ),
        Directionality(
          textDirection:
              language() == "en" ? TextDirection.ltr : TextDirection.rtl,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
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
              controller: controller,
              onCountryChanged: onCountryChanged,
              decoration: InputDecoration(
                errorStyle: const TextStyle(
                  color: Colors.red,
                ),
                labelText: "",
                border: border(),
                enabledBorder: border(color: textFieldBackGround),
                focusedBorder: border(color: mainColor),
                errorBorder: border(color: Colors.red),
                disabledBorder: border(),
                focusedErrorBorder: border(color: Colors.red),
              ),
              initialCountryCode: countryCode.isEmpty ? "EG" : countryCode,
              initialValue: countryCode.isEmpty ? "EG" : countryCode,
              showCountryFlag: false,
              validator: (p0) {
                if (p0!.toString().isEmpty) {
                  return "validation_filed".tr;
                }
                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
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
              invalidNumberMessage: "invalid_phone".tr,
              keyboardType: TextInputType.number,
              onChanged: onChanged,
              
            ),
          ),
        ),
      ],
    );
  }
}
