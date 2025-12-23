import 'package:customer/app/data/online/data_parser.dart';
import 'package:customer/app/models/product/item.dart';
import 'package:get/get.dart';

class ItemFiltersController extends GetxController {
  Map<String, dynamic> filters;
  ItemFiltersController(this.filters);
  final items = <ItemModel>[].obs;
  final loading = RxBool(false);
  final loadingSearch = RxBool(false);
  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  void getProducts() async {
    loading.value = true;
    final data = await DataParser().getProductsFilter(params: filters);

    items.value = data.data.products;
    
    loading.value = false;
  }

  void search(v) async {
    loadingSearch.value = true;
    final data = await DataParser().getProductsFilter(params: {
      'key': v,
      ...filters,
    });
    items.value = data.data.products;
    loadingSearch.value = false;
  }
}
