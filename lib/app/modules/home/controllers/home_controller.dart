import 'dart:async';
import 'dart:developer';

import 'package:customer/app/core/functions/status/success.dart';
import 'package:customer/app/data/online/auth_parser.dart';
import 'package:customer/app/data/online/data_parser.dart';
import 'package:customer/app/models/auth/profile.dart';
import 'package:customer/app/models/cart/cart_off_line_model.dart';
import 'package:customer/app/models/cart/option_selection.dart';
import 'package:customer/app/models/product/item.dart';
import 'package:customer/app/models/public/category.dart';
import 'package:customer/app/models/public/featured_categories_model.dart';
import 'package:customer/app/models/public/home_model.dart';
import 'package:customer/app/modules/cart/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../../core/services/LocationAddressGoogle/Location_address_parser.dart';
import '../../../data/local/auth_info.dart';
import '../../../data/repositories/cart/cart_repo.dart';
import '../../../models/cart/cart_options_model.dart';

class HomeController extends GetxController {
  final home = Rxn<HomeModel>();
  final featuredCategories = Rxn<FeaturedCategoriesModel>();
  final categories = <CategoryModel>[].obs;
  final loading = RxBool(true);
  final loadingLocation = RxBool(true);
  final loadMore = RxBool(false);
  final profile = Rxn<ProfileModel>();
  final address = Rxn<String>("");
  final wishList = <ItemModel>[].obs;
  ScrollController scrollController = ScrollController();
  final isLoadingMore = false.obs;
  double? lat, lng;

  Timer? debounceScroll;

  addListenerToController() {
    scrollController = ScrollController();
    scrollController.removeListener(() => handleScroll());

    scrollController.addListener(() => handleScroll());
  }

  handleScroll() {
    scrollController.addListener(() {
      if (debounceScroll?.isActive ?? false) {
        debounceScroll?.cancel();
      }
      if (isLoadingMore.value != true) {
        isLoadingMore.value = true;
      }

      debounceScroll = Timer(const Duration(milliseconds: 500), () async {
        getMoreDataListener();
      });
    });
  }

  void getMoreDataListener() {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    if (currentScroll >= (maxScroll - 10)) {
      loadMoreFeaturedCategories();
    }
  }

  @override
  void onInit() {
    getData();
    AuthParser().isAuth();
    autoLogin();
    super.onInit();
  }

  @override
  Future<void> onClose() async {
    scrollController.removeListener(() => handleScroll());
    scrollController.dispose();

    super.onClose();
  }

  void getData() async {
    addListenerToController();

    loading.value = true;
    home.value = await DataParser().getHomeData();
    featuredCategories.value = await DataParser().getFeaturedCategories();
    categories.value = await DataParser().getCategories();
    loading.value = false;

    if (AuthParser().isAuth()) {
      getWishList();
    }
    getLocation();
  }

  Future<void> loadMoreFeaturedCategories() async {
    final nextUrl = featuredCategories.value?.links?.next;
    if (nextUrl == null) return;

    isLoadingMore.value = true;

    try {
      final newData = await DataParser().getFeaturedCategories(url: nextUrl);

      final currentData = featuredCategories.value;

      final updatedItems = [...?currentData?.data, ...newData.data];
      final updatedLinks = newData.links;
      final updatedMeta = newData.meta;

      featuredCategories.value = FeaturedCategoriesModel(
          data: updatedItems, links: updatedLinks, meta: updatedMeta);
      log("sadsadsadasdsa   ");
    } catch (e) {
      print('Error loading more: $e');
    } finally {
      isLoadingMore.value = false;
    }
  }

  void autoLogin() {
    String? email = LocalAuthInfo().readEmail();
    String? password = LocalAuthInfo().readPassword();

    if (email != null && password != null) {
      AuthParser().autoLogin(email: email, password: password);
    }
  }

  void getLocation({void Function(LatLng)? callback}) async {
    loadingLocation.value = true;
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        loadingLocation.value = false;
        address.value = "";

        return;
      }
    }

    permissionGranted = await location.requestPermission();
    if (permissionGranted == PermissionStatus.granted ||
        permissionGranted == PermissionStatus.grantedLimited) {
      final userAddress = await location.getLocation();
      lat = userAddress.latitude;
      lng = userAddress.longitude;
      update();
      if (callback != null) {
        callback(LatLng(userAddress.latitude!, userAddress.longitude!));
      }
      await LocationAddressParser.getAddressFromLatLng(
        lat: lat!,
        lng: lng!,
        onFind: (text) {
          address.value = text;
          loadingLocation.value = false;
        },
        unFind: () {
          loadingLocation.value = false;
          address.value = "";
        },
      );

      loadingLocation.value = false;
    } else {
      loadingLocation.value = false;
      address.value = "";
    }
  }

  // add to cart

  void addToCart({
    required ItemModel item,
  }) {
    List<int> optionIds = [];
    List<String> names = [];
    List<String> optionNames = [];
    List<double> optionPrices = [];
    double optionsPrice = 0;
    // for (var selectedOption in selectedOptions) {
    //   optionIds.add(selectedOption.id!);
    //   names.add(selectedOption.names ?? '');
    //   optionNames.add(selectedOption.optionName ?? '');
    //   optionPrices.add(selectedOption.optionPrice ?? 0);
    //   optionsPrice += (selectedOption.optionPrice ?? 0);
    // }
    final cartOptions = CartOptions(
      optionsId: optionIds,
      attribute: Attribute(
          names: names, optionName: optionNames, optionPrice: optionPrices),
      attributePrice: optionsPrice,
      name: item.name ?? '',
      slug: item.slug ?? '',
      photo: item.photo ?? '',
      price: (item.price!.toDouble() ?? 0 + optionsPrice),
      // mainPrice: item.discountPrice!.toDouble() ?? 0,
      itemType: item.isType,
      qty: '1',
    );
    CartRepo().addToCart(itemId: item.id ?? 0, qty: 1, options: cartOptions);
    try {
      final cartCTRL = Get.find<CartController>();
      cartCTRL.getData();
    } catch (e) {}
    renderSuccess(message: 'Added Successfully'.tr);
  }

  final selectedOptions = <OptionSelection>[].obs;

  // void addToCartLocal({required ItemModel item, required int id}) {
  //   List<int> optionIds = [];
  //   List<String> names = [];
  //   List<int> optionId = [];
  //   List<String> optionNames = [];
  //   List<double> optionPrices = [];
  //   double optionsPrice = 0;
  //   for (var selectedOption in selectedOptions) {
  //     optionIds.add(selectedOption.id!);
  //     names.add(selectedOption.names ?? '');
  //     optionId.add(selectedOption.optionId??0);
  //     optionNames.add(selectedOption.optionName ?? '');
  //     optionPrices.add(selectedOption.optionPrice ?? 0);
  //     optionsPrice += (selectedOption.optionPrice ?? 0);
  //   }
  //
  //   // print("optionIds === ${optionIds}");
  //   final cartOptions = CartOptions(
  //     optionsId: optionIds,
  //     attribute: Attribute(
  //         names: names, optionName: optionNames, optionPrice: optionPrices,optionId: optionId),
  //     attributePrice: optionsPrice,
  //     name: item.name ?? '',
  //     slug: item.slug ?? '',
  //     photo: item.photo ?? '',
  //     price: (item.discountPrice ?? 0 + optionsPrice),
  //     mainPrice: item.discountPrice ?? 0,
  //     itemType: item.itemType,
  //     qty: "1",
  //   );
  //   print("cart options ${cartOptions.optionsId}");
  //   // CartRepo().addToCart(itemId: id, qty: counter.value, options: cartOptions);
  //   print("cartOptions == ${cartOptions.attribute?.names ?? "444"} ");
  //
  //   print("stock == ${item.stock ?? "444"} ");
  //   CartRepo().getOffLineCarts();
  //
  //   CartRepo().addToCartLocal(
  //     productId: id.toString(),
  //     productName: item.name ?? "",
  //     productPrice: item.discountPrice.toString() ?? "",
  //     productImage: item.image ?? "",
  //     productStock: item.stock.toString() ??"",
  //     quantity: "1",
  //     options: cartOptions,
  //   );
  //   try {
  //     final cartCTRL = Get.find<CartController>();
  //     cartCTRL.getData();
  //   } catch (e) {}
  //   // renderSuccess(message: 'Added Successfully'.tr);
  //   Get.snackbar(
  //     'Success'.tr, // Title of the snackbar
  //     'Added Successfully'.tr, // Message
  //     snackPosition: SnackPosition.TOP, // Position on the screen
  //     backgroundColor: Colors.green.withOpacity(0.8),
  //     colorText: Colors.white,
  //     duration: const Duration(seconds: 3), // Duration for the message
  //   );
  // }

  // wish list
  void addToCartLocal({required ItemModel item, required int id}) async {
    List<int> optionIds = [];
    List<String> names = [];
    List<int> optionId = [];
    List<String> optionNames = [];
    List<double> optionPrices = [];
    double optionsPrice = 0;

    for (var selectedOption in selectedOptions) {
      optionIds.add(selectedOption.id!);
      names.add(selectedOption.names ?? '');
      optionId.add(selectedOption.optionId ?? 0);
      optionNames.add(selectedOption.optionName ?? '');
      optionPrices.add(selectedOption.optionPrice ?? 0);
      optionsPrice += (selectedOption.optionPrice ?? 0);
    }

    final cartOptions = CartOptions(
      optionsId: optionIds,
      attribute: Attribute(
        names: names,
        optionName: optionNames,
        optionPrice: optionPrices,
        optionId: optionId,
      ),
      attributePrice: optionsPrice,
      name: item.name ?? '',
      slug: item.slug ?? '',
      photo: item.photo ?? '',
      price: (item.price!.toDouble() ?? 0 + optionsPrice),
      itemType: item.isType,
      qty: "1",
    );

    // Fetch the current cart items
    List<CartOffLineModel> cartItems = await CartRepo().getOffLineCarts();

    bool itemExists = false;

    // Loop through cart items
    for (var cartItem in cartItems) {
      if (cartItem.itemId == id) {
        int newQty = int.parse(cartItem.quantity.toString()) + 1;
        if (cartItem.stock! < newQty) {
          Get.snackbar(
            'Error'.tr,
            'You cannot add more than the available stock'.tr,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red.withOpacity(0.8),
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
          itemExists = true;
          break;
        } else {
          await CartRepo()
              .updateCartItemOffLine(quantity: newQty, id: cartItem.id!);
          Get.snackbar(
            'Success'.tr,
            'Added Successfully'.tr,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green.withOpacity(0.8),
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
          itemExists = true;
        }
        break;
      }
    }

    if (!itemExists) {
      CartRepo().addToCartLocal(
        productId: id.toString(),
        productName: item.name ?? "",
        productPrice: item.discountPrice?.toString() ?? "",
        productImage: item.photo ?? "",
        productStock: item.stock?.toString() ?? "",
        quantity: "1",
        options: cartOptions,
      );
      Get.snackbar(
        'Success'.tr,
        'Added Successfully'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }

    // تحديث البيانات في CartController
    try {
      final cartCTRL = Get.find<CartController>();
      cartCTRL.data.value = await CartRepo().getOffLineCarts();
    } catch (e) {
      print("Error updating cart data: $e");
    }
  }

  void addToWishList({required int id}) async {
    await DataParser().addToWishList(id: id);
    if (addedToWishList(id: id).value) {
      Get.snackbar(
        'Success'.tr, // Title of the snackbar
        'Removed from favourite'.tr, // Message
        snackPosition: SnackPosition.TOP, // Position on the screen
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 3), // Duration for the message
      );
    } else {
      Get.snackbar(
        'Success'.tr, // Title of the snackbar
        'Added to favourite'.tr, // Message
        snackPosition: SnackPosition.TOP, // Position on the screen
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 3), // Duration for the message
      );
    }
    getWishList();
  }

  RxBool addedToWishList({
    required int id,
  }) {
    final item = wishList.firstWhereOrNull((element) => element.id == id);
    return RxBool(item != null);
  }

  Future<void> getWishList() async {
    try {
      wishList.value = await DataParser().getWishList();
    } catch (e) {
      print("Error in getWishList: $e");
    }
  }

  // profile
  void getProfile() async {
    profile.value = await AuthParser().getProfile();
    try {
      final cartCTRL = Get.find<CartController>();

      cartCTRL.getData();
      getWishList();
    } catch (e) {}
  }
}
