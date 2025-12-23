import 'package:get/get.dart';
import 'ar.dart';
import 'en.dart';
class translationMap extends Translations {
  Map<String, Map<String, String>> get keys=>{
    'en':en,
    'ar':ar
  };
}