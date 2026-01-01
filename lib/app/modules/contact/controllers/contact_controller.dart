import 'package:get/get.dart';

import '../../../core/enum.dart';
import '../../../data/online/end_points.dart';
import '../../../models/contact/contact_info_model.dart';
import 'package:customer/app/data/online/DioRequest.dart' as dio;

class ContactController extends GetxController {
  final contactInfo = <ContactInfoModel>[].obs;
  Status status = Status.loading;

  @override
  void onInit() {
    super.onInit();
    getContactInformation();
  }

  Future<void> getContactInformation() async {
    try {
      status = Status.loading;
      update();

      final response = await dio.getRequest(
        urlExt: EndPoints().contactInformation,
        requireToken: false,
      );

      if (response.statusCode == 200 && response.data['status'] == true) {
        final contactResponse = ContactInfoResponse.fromJson(response.data);
        contactInfo.value = contactResponse.data;
        status = Status.loaded;
      } else {
        status = Status.fail;
      }
    } catch (e) {
      print("Error getting contact information: $e");
      status = Status.fail;
    } finally {
      update();
    }
  }
}

