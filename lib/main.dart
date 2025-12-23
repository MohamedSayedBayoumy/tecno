
import 'package:customer/app/data/local/local_data_base.dart';
import 'package:customer/app/data/online/DioRequest.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/Language/trannslation.dart';
import 'app/config/config.dart';
import 'app/core/constants/colors.dart';
import 'app/core/functions/public/get_lang';
import 'package:firebase_core/firebase_core.dart';

import 'app/core/services/firebase_messaging.dart';
import 'app/core/services/notification_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseNotificationServices.initFirebaseMessagingListener();
  await NotificationService.init();

  await GetStorage.init();
  final db = LocalDataBase();
  await db.db;
  final storage = GetStorage();
  final token = (storage.read('token') ?? "");
  if (token.toString().isNotEmpty) {
    DioRequest.createDioInstance(token);
  }
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(
    DevicePreview(
      enabled:
          false, // false => remove device preview , true => add device preview
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: Config.appName,
      theme: ThemeData(
          fontFamily: language() == 'ar' ? "ar_family" : "en_family",
          colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
          useMaterial3: false,
          scaffoldBackgroundColor: const Color(0xffffffff)),
      locale: Locale(language()),
      translations: translationMap(),
      textDirection: language() == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      getPages: AppPages.routes(),
      initialRoute: Routes.splash,
    );
  }
}