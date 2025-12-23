import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:get/get.dart';

void renderError({
  required String message,
}) {
  AlertController.show("Error".tr, message, TypeAlert.error);
}
