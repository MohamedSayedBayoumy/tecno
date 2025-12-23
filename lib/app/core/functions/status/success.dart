import 'package:customer/app/core/constants/colors.dart';
import 'package:customer/app/core/functions/status/failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/utils.dart';

import '../../constants/styles.dart';

void renderSuccess({
  String? message,
}) {
  Fluttertoast.showToast(
      msg: message ?? "mission_done".tr,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

void renderFailedStatus({
  String? message,
}) {
  Fluttertoast.showToast(
      msg: message ?? "error".tr,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 6,
      backgroundColor: Colors.red.shade400,
      textColor: Colors.white,
      fontSize: 16.0);
}
