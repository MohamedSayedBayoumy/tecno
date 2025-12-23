import 'dart:developer';

import 'package:customer/app/core/functions/public/get_lang';
import 'package:customer/app/core/functions/status/failure.dart';
import 'package:customer/app/core/functions/status/success.dart';
import 'package:customer/app/data/online/DioRequest.dart';
import 'package:customer/app/data/online/end_points.dart';
import 'package:customer/app/models/auth/profile.dart';
import 'package:customer/app/models/cart/address_model.dart';
import 'package:customer/app/models/cart/order_details_model.dart';
import 'package:customer/app/models/pages/page_model.dart';
import 'package:customer/app/models/pages/pages_model.dart';
import 'package:customer/app/models/product/item.dart';
import 'package:customer/app/models/product/offer_model.dart';
import 'package:customer/app/models/product/vendor_details_model.dart';
import 'package:customer/app/models/product/wish_list_model.dart';
import 'package:customer/app/models/public/category.dart';
import 'package:customer/app/models/public/country_model.dart';
import 'package:customer/app/models/public/featured_categories_model.dart';
import 'package:customer/app/models/public/governorate_model.dart';
import 'package:customer/app/models/public/language.dart';
import 'package:customer/app/models/public/sub_category.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../models/brands_models.dart';
import '../../models/cart/cart_options_model.dart';
import '../../models/cart/order_model.dart';
import '../../models/common_address_model.dart';
import '../../models/notifications_model.dart';
import '../../models/product/comments.dart';
import '../../models/product/item_details_model.dart';
import '../../models/public/home_model.dart';
import '../../models/search/search_model.dart';

class DataParser {
  Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> list = [];
    final response = await getRequest(urlExt: EndPoints().categories);
    list = (response.data['data'] as List)
        .map((e) => CategoryModel.fromJson(e))
        .toList();
    print(response.data);
    return list;
  }

  Future<List<SubcategoryModel>> getSubcategories(
      {required int id, String? search}) async {
    List<SubcategoryModel> list = [];
    final response =
        await getRequest(urlExt: EndPoints().subCategories, params: {
      'category_id': id,
      if (search != null) "search": search,
    });
    print(response.data);
    list = (response.data['data'] as List)
        .map((e) => SubcategoryModel.fromJson(e))
        .toList();
    return list;
  }

  // Future<ProfileModel> getProfile() async {
  //   final response =
  //   await getRequest(urlExt: EndPoints().profile, requireToken: true);
  //   return ProfileModel.fromJson(response.data);
  // }

  Future<ProfileModel?> getProfile() async {
    try {
      final response = await getRequest(
        urlExt: EndPoints().profile,
        requireToken: true,
      );

      final data = response.data;

      if (data == null || data['status'] == false || data['data'] == null) {
        final message = data?['message']?.toString().toLowerCase() ?? '';

        if (message.contains('unauthenticated')) {
          // المستخدم غير مسجل دخول
          Get.offAllNamed(Routes.SIGN_IN);
          return null;
        }

        // أي حالة تانية من رفض البيانات
        print("Unexpected error message: ${data['message']}");
        return null;
      }

      return ProfileModel.fromJson(data);
    } catch (e) {
      print("Exception during getProfile: $e");

      if (e.toString().contains('401') ||
          e.toString().toLowerCase().contains('unauthenticated')) {
        Get.offAllNamed(Routes.SIGN_IN);
      } else {
        print('Unexpected exception: $e');
      }

      return null;
    }
  }

  Future<SearchResponse> getProductsFilter(
      {required Map<String, dynamic> params}) async {
    log("message$params");
    final response = await getRequest(
      urlExt: EndPoints().subCategoryProducts,
      params: params,
    );

    final data = response.data;

    return SearchResponse.fromJson(data);
  }

  Future<List<ItemModel>> getOffers(
      {Map<String, dynamic>? params, int? page}) async {
    List<ItemModel> list = [];
    final response = await getRequest(
        urlExt: "${EndPoints().offers}?page=$page", params: params);
    list = (response.data['data']["offers"] as List)
        .map((e) => ItemModel.fromJson(e))
        .toList();

    return list;
  }

  Future<List<PagesModel>> getPages() async {
    List<LanguageModel> languages = await getLanguage();

    // Determine the current app language
    String currentLanguage =
        language().tr; // Replace with your actual method to detect app language

    // Find the corresponding language name for the current language
    String? acceptLanguage;
    for (var lang in languages) {
      if (lang.language == 'Arabic' && currentLanguage == 'ar') {
        acceptLanguage = lang.name;
        break;
      } else if (lang.language == 'English' && currentLanguage == 'en') {
        acceptLanguage = lang.name;
        break;
      }
    }

    // Default to English if no matching language is found
    acceptLanguage ??=
        languages.firstWhere((lang) => lang.language == 'English').name;

    List<PagesModel> list = [];
    final response = await getRequest(
      urlExt: EndPoints().pages,
      // headers: {"Accept-Language": acceptLanguage},
    );
    list = (response.data['data'] as List)
        .map((e) => PagesModel.fromJson(e))
        .toList();
    print(list);
    return list;
  }

  Future<PageModel> getPage({required int id}) async {
    List<LanguageModel> languages = await getLanguage();

    // Determine the current app language
    String currentLanguage =
        language().tr; // Replace with your actual method to detect app language

    // Find the corresponding language name for the current language
    String? acceptLanguage;
    for (var lang in languages) {
      if (lang.language == 'Arabic' && currentLanguage == 'ar') {
        acceptLanguage = lang.name;
        break;
      } else if (lang.language == 'English' && currentLanguage == 'en') {
        acceptLanguage = lang.name;
        break;
      }
    }

    // Default to English if no matching language is found
    acceptLanguage ??=
        languages.firstWhere((lang) => lang.language == 'English').name;

    final response = await getRequest(
      urlExt: EndPoints().page(page: id),
      // headers: {"Accept-Language": acceptLanguage},
    );
    return PageModel.fromJson(response.data['data']);
  }

  Future<ItemDetails> getProductDetails({required int id}) async {
    final response = await getRequest(urlExt: EndPoints().itemDetails, params: {
      'item_id': id,
    });
    return ItemDetails.fromJson(response.data['data']);
  }

  // Future<HomeModel> getHomeData() async {
  //   final response = await getRequest(urlExt: EndPoints().home,headers: {"Accept-Language":"1733404084JOneDGSB"});
  //   print(response.data);
  //   return HomeModel.fromJson(response.data['data']);
  // }
  Future<HomeModel> getHomeData() async {
    // Fetch the list of available languages
    List<LanguageModel> languages = await getLanguage();

    // Determine the current app language
    String currentLanguage =
        language().tr; // Replace with your actual method to detect app language

    // Find the corresponding language name for the current language
    String? acceptLanguage;
    for (var lang in languages) {
      if (lang.language == 'Arabic' && currentLanguage == 'ar') {
        acceptLanguage = lang.name;
        break;
      } else if (lang.language == 'English' && currentLanguage == 'en') {
        acceptLanguage = lang.name;
        break;
      }
    }

    // Default to English if no matching language is found
    acceptLanguage ??=
        languages.firstWhere((lang) => lang.language == 'English').name;

    // Send the request with the Accept-Language header
    final response = await getRequest(
      urlExt: EndPoints().home,
      // headers: {"Accept-Language": language() == "en" ? "English" : "Arabic"},
    );

    print(response.data);
    return HomeModel.fromJson(response.data['data']);
  }

  // Future<FeaturedCategoriesModel> getFeaturedCategories() async {
  //   final response = await getRequest(
  //     urlExt: EndPoints().featuredCategories,
  //   );
  //
  //   print(response.data);
  //   return FeaturedCategoriesModel.fromJson(response.data['data']);
  // }

  Future<FeaturedCategoriesModel> getFeaturedCategories({String? url}) async {
    final response = await getRequest(
      urlExt: url ?? EndPoints().featuredCategories,
    );

    print(response.data);
    return FeaturedCategoriesModel.fromJson(response.data['data']);
  }

  Future<BrandsResponse> getBrands(int page) async {
    final response = await getRequest(
      urlExt: "${EndPoints().brands}?page=$page",
      // headers: {
      //   'Accept-Language': language() == "en" ? "English" : "Arabic",
      // },
    );

    return BrandsResponse.fromJson(response.data);
  }

  Future<List<LanguageModel>> getLanguage() async {
    List<LanguageModel> list = [];
    final response = await getRequest(urlExt: EndPoints().language);
    list = (response.data['data'] as List)
        .map((e) => LanguageModel.fromJson(e))
        .toList();
    return list;
  }

  Future<void> addItemToCart({
    required int itemId,
    required int qty,
    required CartOptions option,
  }) async {
    final response = await postRequest(urlExt: EndPoints().addToCart, data: {
      'item_id': itemId,
      'qty': qty,
      'options': option.toJson(),
    });
  }

  Future<AddressResponse> getAddresses() async {
    final response =
        await getRequest(urlExt: EndPoints().addresses, requireToken: true);

    return AddressResponse.fromJson(response.data);
  }

  Future<CommonResponseModel> deleteAddresses(int id) async {
    final response = await deleteRequest(
      urlExt: "${EndPoints().addresses}/$id",
      requireToken: true,
    );

    return CommonResponseModel.fromJson(response.data);
  }

  Future<CommonResponseModel> addAddress(Map<String, dynamic>? data) async {
    final response = await postRequest(
      urlExt: EndPoints().addresses,
      requiredToken: true,
      data: data,
      isJson: true,
    );

    return CommonResponseModel.fromJson(response.data);
  }

  Future<CommonResponseModel> updateAddress(
      Map<String, dynamic> data, id) async {
    final response = await putRequest(
      urlExt: "${EndPoints().addresses}/$id",
      requiredToken: true,
      data: data,
    );

    return CommonResponseModel.fromJson(response.data);
  }

  Future<CommonResponseModel> setAddressDefault(id) async {
    final response = await postRequest(
      urlExt: EndPoints().setAddressDefault(id),
      requiredToken: true,
      data: {},
    );

    return CommonResponseModel.fromJson(response.data);
  }

  Future<List<GovernorateModel>> getGovernorates() async {
    List<GovernorateModel> list = [];
    final response =
        await getRequest(urlExt: EndPoints().governorates, requireToken: true);
    list = (response.data['data'] as List)
        .map((e) => GovernorateModel.fromJson(e))
        .toList();
    return list;
  }

  Future<List<CountryModel>> getCountries() async {
    List<LanguageModel> languages = await getLanguage();

    // Determine the current app language
    String currentLanguage =
        language().tr; // Replace with your actual method to detect app language

    // Find the corresponding language name for the current language
    String? acceptLanguage;
    for (var lang in languages) {
      if (lang.language == 'Arabic' && currentLanguage == 'ar') {
        acceptLanguage = lang.name;
        break;
      } else if (lang.language == 'English' && currentLanguage == 'en') {
        acceptLanguage = lang.name;
        break;
      }
    }

    // Default to English if no matching language is found
    acceptLanguage ??=
        languages.firstWhere((lang) => lang.language == 'English').name;

    List<CountryModel> list = [];
    final response = await getRequest(
      urlExt: EndPoints().countries,
      requireToken: true,
      // headers: {"Accept-Language": acceptLanguage},
    );
    list = (response.data['data'] as List)
        .map((e) => CountryModel.fromJson(e))
        .toList();
    return list;
  }

  Future<List<OrderDetailsModel>> getOrders() async {
    List<OrderDetailsModel> list = [];
    final response =
        await getRequest(urlExt: EndPoints().orders, requireToken: true);
    list = (response.data['data'] as List)
        .map((e) => OrderDetailsModel.fromJson(e))
        .toList();
    return list;
  }

  Future<CommentsResponse> rateOrder({orderId, rate, text}) async {
    final response = await postRequest(
      urlExt:
          "${EndPoints().rateOrder}?order_id=$orderId&rating=$rate&review=${text ?? ""}",
      requiredToken: true,
    );

    return CommentsResponse.fromJson(response.data);
  }

  Future<CommentsResponse> rateItem({orderId, rate, text, itemId}) async {
    final response = await postRequest(
      urlExt:
          "${EndPoints().rateItem}?order_id=$orderId&rating=$rate&review=${text ?? ""}&item_id=$itemId",
      requiredToken: true,
    );

    return CommentsResponse.fromJson(response.data);
  }

  Future<VendorDetails> getVendorDetails({required int vendorId}) async {
    final response =
        await getRequest(urlExt: EndPoints().vendorDetails, params: {
      'vendor_id': vendorId,
    });
    return VendorDetails.fromJson(response.data['data']);
  }

  Future<OrderDetailsModel> getOrderDetails({
    required int id,
  }) async {
    final response = await getRequest(
        urlExt: EndPoints().orderDetails,
        params: {'order_id': id},
        requireToken: true);
    return OrderDetailsModel.fromJson(response.data['data']);
  }

  Future<Map<String, dynamic>> cancelOrder({
    required String id,
    required String reason,
  }) async {
    final response = await postRequest(
      urlExt: "${EndPoints().cancelOrder}?order_id=$id&reason=$reason",
      requiredToken: true,
    );
    return response.data;
  }

  Future<void> addToWishList({required int id}) async {
    final response = await postRequest(
        urlExt: EndPoints().addToWishList,
        requiredToken: true,
        data: {
          'item_id': id,
        });
    print(response.data);
  }

  Future<NotificationsResponse> getNotifications(int page) async {
    final response = await getRequest(
      urlExt: "${EndPoints().notifications}?page=$page",
      requireToken: true,
    );

    return NotificationsResponse.fromJson(response.data);
  }

  Future<CommentsResponse> getUsersComments(
      {required int id, required int page}) async {
    final response = await getRequest(
      urlExt: EndPoints().comments,
      params: {
        'item_id': id,
        'page': page,
      },
    );

    return CommentsResponse.fromJson(response.data);
  }

  Future<List<ItemModel>> getWishList() async {
    List<ItemModel> list = [];
    final response =
        await getRequest(urlExt: EndPoints().wishList, requireToken: true);
    list = (response.data['data'] as List)
        .map((e) => ItemModel.fromJson(e))
        .toList();
    return list;
  }

  Future<void> placeOrder({
    required String paymentMethod,
    required AddressModel shippingInfo,
  }) async {
    try {
      final response = await postRequest(
          urlExt: EndPoints().placeOrder,
          requiredToken: true,
          data: {
            'payment_method': paymentMethod,
            'shipping_info': shippingInfo.toJson(),
          });
      if (response.data['status']) {
        Get.offAndToNamed(Routes.HOME);
        renderSuccess(message: response.data['message']);
      } else {
        renderError(message: response.data['message']);
      }
    } catch (e) {
      renderError(message: 'Something wrong happened, try again latter'.tr);
    }
  }
}
