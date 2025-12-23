import 'package:customer/app/core/functions/public/get_lang';
import 'package:flutter/material.dart';

import 'colors.dart';

// import 'package:google_fonts/google_fonts.dart';

class Styles {
  final title = TextStyle(
    color: mainColor,
    fontWeight: FontWeight.bold,
    fontSize: 35,
    // overflow: TextOverflow.ellipsis,
  );

  static String get fontFamily =>
      language() == "ar" ? "ar_family" : "en_family";

  static TextStyle get styleSemiBold13 => TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily,
      );

  static TextStyle get styleExtraBold18 => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        fontFamily: fontFamily,
      );

  static TextStyle get styleExtraBold25 => TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w800,
        fontFamily: fontFamily,
      );

  static TextStyle get styleExtraBold30 => TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w800,
        fontFamily: fontFamily,
      );
  static TextStyle get styleBold20 => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
      );

  static TextStyle get styleBold18 => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
      );

  static TextStyle get styleBold15 => TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
      );

  static TextStyle get styleBold11 => TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
      );

  static TextStyle get styleSemiBold14 => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily,
      );

  static TextStyle get styleSemiBold16 => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily,
      );

  static TextStyle get styleSemiBold12 => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily,
      );

  static TextStyle get styleExtraBold10 => TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w800,
        fontFamily: fontFamily,
      );

  static TextStyle get styleExtraBold15 => TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w800,
        fontFamily: fontFamily,
      );

  static TextStyle get styleMedium13 => TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
      );
  static TextStyle get styleMedium15 => TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
      );

  static TextStyle get styleMedium18 => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
      );

  static TextStyle get styleRegular13 => TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
      );

  static TextStyle get styleRegular10 => TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
      );
  static TextStyle get styleRegular15 => TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
      );

  static TextStyle get styleRegular20 => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
      );

  static TextStyle get styleRegular25 => TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
      );

  //
  //
  //
  //
  //
  //

  //
  //

  //

  //
  //

  //
  //

  //

  //
  //

  //

  TextStyle titleCustom({required Color color}) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
      fontSize: 35,
      // overflow: TextOverflow.ellipsis,
    );
  }

  final titleWhite = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 35,
    // overflow: TextOverflow.ellipsis,
  );
  final head2Black = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 23,
    // overflow: TextOverflow.ellipsis,
  );
  final head2Grey = const TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.w500,
    fontSize: 23,
    // overflow: TextOverflow.ellipsis,
  );
  final head2Primary = TextStyle(
    color: mainColor,
    fontWeight: FontWeight.w400,
    fontSize: 23,
    // overflow: TextOverflow.ellipsis,
  );
  final head2Green = const TextStyle(
    color: Colors.green,
    fontWeight: FontWeight.w400,
    fontSize: 23,
    // overflow: TextOverflow.ellipsis,
  );
  final head2Warn = const TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.w400,
    fontSize: 23,
    // overflow: TextOverflow.ellipsis,
  );
  final head2Secondary = TextStyle(
    color: secondaryColor,
    fontWeight: FontWeight.w400,
    fontSize: 23,
    overflow: TextOverflow.ellipsis,
  );
  final subTitlePrimary = TextStyle(
    color: mainColor,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    overflow: TextOverflow.ellipsis,
  );
  final subTitleGrey = const TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    // overflow: TextOverflow.ellipsis,
  );
  final subTitleSecondary = TextStyle(
    color: secondaryColor,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    // overflow: TextOverflow.ellipsis,
  );
  final subTitleRed = const TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    // overflow: TextOverflow.ellipsis,
  );
  final subTitle = TextStyle(
    color: mainColor,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    // overflow: TextOverflow.ellipsis,
  );

  TextStyle subTitleCustomized(Color color) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
      fontSize: 18,
      overflow: TextOverflow.ellipsis,
    );
  }

  final subTitleWhite = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    // overflow: TextOverflow.ellipsis
  );
  final sectionTitle = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w700,
    fontSize: 18,
    // overflow: TextOverflow.ellipsis
  );

  final normal = const TextStyle(
    color: Colors.black,
    // fontWeight: FontWeight.w600,
    fontSize: 15,
    // overflow: TextOverflow.ellipsis
  );

  final normalOrange = const TextStyle(
    color: Colors.orange,
    // fontWeight: FontWeight.w600,
    fontSize: 14,
    // overflow: TextOverflow.ellipsis
  );
  final normalGreen = const TextStyle(
      color: Colors.green,
      // fontWeight: FontWeight.w600,
      fontSize: 14,
      overflow: TextOverflow.ellipsis);
  final normalWarn = const TextStyle(
      color: Colors.red,
      // fontWeight: FontWeight.w600,
      fontSize: 14,
      overflow: TextOverflow.ellipsis);
  final normalPrimary = TextStyle(
    color: mainColor,
    // fontWeight: FontWeight.w600,
    fontSize: 14,
    overflow: TextOverflow.ellipsis,
  );
  final hyperLink = TextStyle(
    color: mainColor,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    overflow: TextOverflow.ellipsis,
  );
  final normalSecondary = TextStyle(
    color: secondaryColor,
    // fontWeight: FontWeight.w600,
    fontSize: 14,
    overflow: TextOverflow.ellipsis,
  );
  final normalGrey = const TextStyle(
    color: Colors.grey,
    // fontWeight: FontWeight.w500,
    fontSize: 14,
    overflow: TextOverflow.ellipsis,
  );

  TextStyle normalCustom(
      {required Color color,
      TextDecoration? decoration,
      TextOverflow? overflow,
      FontWeight? weight}) {
    return TextStyle(
        color: color,
        fontSize: 14,
        overflow: overflow,
        fontWeight: weight,
        decoration: decoration);
  }

  final normalWhite = const TextStyle(
    color: Colors.white,
    // fontWeight: FontWeight.w600,
    fontSize: 14,
    // overflow: TextOverflow.ellipsis,
  );

  TextStyle smallCustomized(
      {required Color color,
      Color? decorationColor,
      FontWeight? weight,
      TextOverflow? overFlow,
      double? decorationThickness,
      TextDecoration? decoration}) {
    return TextStyle(
      color: color,
      fontWeight: weight ?? FontWeight.w600,
      fontSize: 10,
      decorationColor: decorationColor,
      overflow: overFlow,
      decoration: decoration,
      decorationThickness: decorationThickness,
      // overflow: TextOverflow.ellipsis,
    );
  }
}
