import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constants/app_assets.dart';
import '../core/services/firebase_messaging.dart';
import '../core/widgets/common/custom_asset_image.dart';
import '../routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Future.delayed(
          const Duration(seconds: 3),
          () {
            FirebaseNotificationServices.getFcmToken(
              (p0) {
                print("message>> $p0");
              },
            );
            route();
          },
        );
      },
    );
  }

  route() async {
    final message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      log("Redirect App From Splash \n ${message.toMap()}");
      print("Redirect App From Splash \n ${message.toMap()}");
      FirebaseNotificationServices.redirect(
        page: message.toMap()["data"]["direct"],
        id: message.toMap()["data"]["direct_id"],
      );
    } else {
      Get.offAllNamed(Routes.BOTTOMSHEET);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeIn(
          duration: const Duration(seconds: 2),
          child: const CustomAssetsImage(
            imagePath: Assets.assetsImagesNewVersionEdit01,
            width: 200,
            height: 100,
          ),
        ),
      ),
    );
  }
}
