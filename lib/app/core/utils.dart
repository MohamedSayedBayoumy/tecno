import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class AppUtils {
  static String appLang = "en";

  static PageController pageController = PageController(initialPage: 0);

  static String number(number) {
    if (appLang == "ar") {
      return NumberFormat('#.##', 'ar_EG').format(number);
    } else {
      return number.toString();
    }
  }
   static bool isArabic(text) => RegExp(r'[\u0600-\u06FF]').hasMatch(text);
}
