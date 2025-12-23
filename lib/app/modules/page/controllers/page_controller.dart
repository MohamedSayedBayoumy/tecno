import 'package:customer/app/data/online/DioRequest.dart';
import 'package:customer/app/data/online/data_parser.dart';
import 'package:customer/app/data/online/end_points.dart';
import 'package:customer/app/models/pages/page_model.dart';
import 'package:customer/app/models/product/offer_model.dart';
import 'package:get/get.dart';

class PageDataController extends GetxController {
  int id;

  PageDataController({required this.id});
  final page = Rxn<PageModel>();
  final loading = RxBool(false);
  @override
  void onInit() {
    getPage();
    super.onInit();
  }

  void getPage() async {
    loading.value = true;
    page.value = await DataParser().getPage(id: id);
    print(id);
    print(page.value?.details??"");
    loading.value = false;
  }
}
