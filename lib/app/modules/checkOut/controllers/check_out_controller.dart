import 'dart:developer';

import 'package:customer/app/core/functions/status/failure.dart';
import 'package:customer/app/core/functions/status/success.dart';
import 'package:customer/app/data/online/DioRequest.dart';
import 'package:customer/app/data/online/data_parser.dart';
import 'package:customer/app/data/online/end_points.dart';
import 'package:customer/app/models/auth/profile.dart';
import 'package:customer/app/models/cart/address_model.dart';
import 'package:customer/app/models/cart/cart_off_line_model.dart';
import 'package:customer/app/models/cart/payment_method.dart';
import 'package:customer/app/models/public/country_model.dart';
import 'package:customer/app/models/public/governorate_model.dart';
import 'package:customer/app/modules/cart/controllers/cart_controller.dart';
import 'package:customer/app/modules/checkOut/widgets/web_view_screen.dart';
import 'package:customer/app/modules/home/controllers/home_controller.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/repositories/cart/cart_repo.dart';
import '../../../models/order/place _order.dart';

class CheckOutController extends GetxController {
  static final cartCTRL = Get.find<CartController>();
  static final homeCTRL = Get.find<HomeController>();
  // static final addressCTRL = Get.find<AddressesController>();

  final cartData = <CartOffLineModel>[].obs;
  final formatter = DateFormat('yyyy-MM-dd');
  final paymentMethod = "".obs;
  final isLoading = false.obs;
  final governorate = <GovernorateModel>[].obs;
  final countries = <CountryModel>[].obs;
  final address = Rxn<AddressModel>();
  final profile = Rxn<ProfileModel>();
  List<AddressModel> addresses = <AddressModel>[].obs;
  final paymentMethods = <PaymentMethod>[].obs;

  final shipFormState = GlobalKey<FormState>();
  final billFormState = GlobalKey<FormState>();

  final shipAddress1Controller = TextEditingController(text: "");
  final shipAddress2Controller = TextEditingController(text: "");
  final shipZipController = TextEditingController(text: "");
  final shipCityController = TextEditingController(text: "");
  final shipCountryController = TextEditingController(text: "");
  final shipCompanyController = TextEditingController(text: "");

  final selectedGovernorateId = ''.obs;
  final selectedCountryId = ''.obs;

  final RxDouble selectedGovernorateValue = 0.0.obs;
  final selectedCountryValue = ''.obs;

  final billAddress1Controller = TextEditingController();
  final billAddress2Controller = TextEditingController();
  final billZipController = TextEditingController();
  final billCityController = TextEditingController();
  final billCountryController = TextEditingController();
  final billCompanyController = TextEditingController();
  String shippingInfo = "";
  @override
  Future<void> onInit() async {
    getData();

    super.onInit();
  }

  RxBool loading = true.obs;
  RxBool haveMissingAddressData = false.obs;

  updateCart() async {
    loading.value = true;
    await getProfile();
    loading.value = false;
  }

  void getData() async {
    loading.value = true;
    await getProfile();
    await getGovernorate();

    cartData.value = await CartRepo().getOffLineCarts();
    await getPaymentMethods();
    loading.value = false;
  }

  Future<void> getGovernorate() async {
    if (profile.value!.data!.shipCity!.isNotEmpty) {
      governorate.value = await DataParser().getGovernorates();

      Get.find<HomeController>().getProfile();

      if (profile.value!.data!.addressData != null) {
        final getShipFee = governorate.value.where((e) =>
            e.id ==
            int.parse(profile.value!.data!.addressData!.cityId.toString()));

        selectedGovernorateValue.value =
            double.parse(getShipFee.first.shippingPrice!);
      }
    }
  }

  Future<void> getProfile() async {
    profile.value = await DataParser().getProfile();

    if (profile.value!.data!.addressData == null) {
      haveMissingAddressData.value = true;
      shippingInfo = "";
    } else {
      haveMissingAddressData.value = false;

      shippingInfo = profile.value!.data!.addressData!.address;
    }

    update();
  }

  Future<List<PaymentMethod>> getPaymentMethods() async {
    final response = await getRequest(
      urlExt: EndPoints().paymentMethods,
      requireToken: true,
    );

    final list = (response.data['data'] as List)
        .map((e) => PaymentMethod.fromJson(e))
        .toList();

    // عيّنهم أولاً في المتغير الـ Rx
    paymentMethods.assignAll(list);

    // ثم اختار أول واحدة تلقائيًا
    if (paymentMethods.isNotEmpty && paymentMethod.value.isEmpty) {
      selectPaymentMethod(paymentMethods.first.id.toString());
    }

    return list;
  }

  void selectPaymentMethod(String methodId) {
    paymentMethod.value = methodId; // Update the reactive value
    print(paymentMethod.value);
  }

  double calculateTotalPrice({required List<CartOffLineModel> data}) {
    double total = 0.0; // Initialize total to 0.0

    for (var cartItem in cartData.value) {
      total += double.parse(cartItem.price!) *
          cartItem.quantity!; // Add the item's total price to the total
    }
    return total; // Return the total price
  }

  void handleAddress() async {
    // addresses = await DataParser().getAddresses();
    if (addresses.isNotEmpty) {
      address.value = addresses.first;
    } else {
      address.value = AddressModel(
        shipAddress1: homeCTRL.address.value,
        lat: homeCTRL.lat,
        lng: homeCTRL.lng,
      );
    }
    // address.value = AddressModel(
    //   shipAddress1: homeCTRL.address.value,
    //   lat: homeCTRL.lat,
    //   lng: homeCTRL.lng,
    // );
  }

  // Future<void> placeOrder({
  //   required String paymentMethodId,
  //   required List<CartOffLineModel> cart,
  //   required BuildContext context,
  // }) async {
  //   try {
  //     print(cart.first.options?.optionsId?.first);
  //     // Transform cart into the required format
  //     final cartData = cart.map((item) {
  //       return {
  //         "item_id": item.itemId,
  //         "qty": item.quantity,
  //         "discount_price": item.price,
  //         "whole_sale_pric": 0,
  //         "options": {
  //           "attribute_id": item.options?.optionsId?.first,
  //           "option_id": item.options?.attribute?.optionId?.first,
  //           "price": item.options?.attribute?.optionPrice?.first,
  //           "wholesale_price": 0,
  //         }
  //       };
  //     }).toList();
  //
  //     // Prepare the final data object
  //     final data = {
  //       "payment_method_id": paymentMethodId,
  //       "cart": cartData,
  //     };
  //     print(data);
  //
  //     // Navigator.push(
  //     //   context,
  //     //   MaterialPageRoute(
  //     //     builder: (context) => WebViewScreen(
  //     //       url: 'https://accept.paymob.com/api/acceptance/iframes/880679?payment_token==ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SjFjMlZ5WDJsa0lqb3hPRFkzTWpNekxDSmhiVzkxYm5SZlkyVnVkSE1pT2pFNE1EQXdMQ0pqZFhKeVpXNWplU0k2SWtWSFVDSXNJbWx1ZEdWbmNtRjBhVzl1WDJsa0lqbzBPRGMxTVRRd0xDSnZjbVJsY2w5cFpDSTZNamN3TURVMk16UXlMQ0ppYVd4c2FXNW5YMlJoZEdFaU9uc2labWx5YzNSZmJtRnRaU0k2SW1GaVlXNXZkV0lpTENKc1lYTjBYMjVoYldVaU9pSXVJaXdpYzNSeVpXVjBJam9pVGtFaUxDSmlkV2xzWkdsdVp5STZJazVCSWl3aVpteHZiM0lpT2lKT1FTSXNJbUZ3WVhKMGJXVnVkQ0k2SWs1Qklpd2lZMmwwZVNJNklrNUJJaXdpYzNSaGRHVWlPaUpPUVNJc0ltTnZkVzUwY25raU9pSk9RU0lzSW1WdFlXbHNJam9pWVdKaGJtOTFZbTVsYzNObGJURXhOVUJuYldGcGJDNWpiMjBpTENKd2FHOXVaVjl1ZFcxaVpYSWlPaUl3TVRJeE1UUTJOalEwTXlJc0luQnZjM1JoYkY5amIyUmxJam9pVGtFaUxDSmxlSFJ5WVY5a1pYTmpjbWx3ZEdsdmJpSTZJazVCSW4wc0lteHZZMnRmYjNKa1pYSmZkMmhsYmw5d1lXbGtJanAwY25WbExDSmxlSFJ5WVNJNmUzMHNJbk5wYm1kc1pWOXdZWGx0Wlc1MFgyRjBkR1Z0Y0hRaU9tWmhiSE5sTENKbGVIQWlPakUzTXpNd05ETXlPVGdzSW5CdGExOXBjQ0k2SWpFMk5TNHlNamN1TVRReExqRTBNaUo5Lm9XM0RQVjI4SmlmTGl6QUl0UzFna0F6X250Q1p1ZGc1SDRIeXJpMGlPMWg5bXVocWM0S1FGMExKdlFPSGNXeWMyM0dONHJDMEU2dEQzeXY1aXduZmhB==',
  //     //     ),
  //     //   ),
  //     // );
  //
  //     // Uncomment and send the POST request
  //     final response = await postRequest(
  //         urlExt: EndPoints().placeOrder,
  //         requiredToken: true,
  //         data: data);
  //
  //
  //     if (response.data['status']) {
  //       Get.offAndToNamed(Routes.HOME);
  //       renderSuccess(message: response.data['message']);
  //     } else {
  //       renderError(message: response.data['message']);
  //     }
  //   } catch (e) {
  //     renderError(message: 'Something wrong happened, try again later'.tr);
  //   }
  // }

// last function
  // Future<void> placeOrder({
  //   required String paymentMethodId,
  //   required List<CartOffLineModel> cart,
  //   required BuildContext context,
  // }) async {
  //   try {
  //     isLoading.value = true; // ⬅️ Start loading
  //
  //     if (paymentMethodId.isNotEmpty) {
  //       final cartData = cart.map((item) {
  //         return
  //           item.variantId == 0?{
  //           "item_id": item.itemId,
  //           "qty": item.quantity,
  //         }:{
  //             "item_id": item.itemId,
  //             "variant_id": item.variantId,
  //             "qty": item.quantity,
  //           };
  //       }).toList();
  //
  //       final data = {
  //         "payment_method_id": paymentMethodId,
  //         "cart": cartData,
  //       };
  //       print(data);
  //
  //       final response = await postRequest(
  //         urlExt: EndPoints().placeOrder,
  //         requiredToken: true,
  //         data: data,
  //       );
  //
  //       final placeOrderResponse = PlaceOrder.fromJson(response.data);
  //       if (placeOrderResponse.status == true) {
  //         CartRepo().clearCartTable();
  //
  //         // التأكد من أن `paymentUrl` ليست null قبل استخدامها
  //         if (placeOrderResponse.data?.paymentUrl != null && placeOrderResponse.data?.paymentUrl != "") {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => WebViewScreen(
  //                 url: placeOrderResponse.data?.paymentUrl ?? "", // استخدام القيمة الافتراضية إذا كانت null
  //               ),
  //             ),
  //           ).then((value) {
  //             Get.offAndToNamed(Routes.HOME);
  //           });
  //         } else {
  //           Get.offAndToNamed(Routes.HOME);
  //           renderSuccess(message: placeOrderResponse.message ?? 'Order placed successfully.');
  //         }
  //       } else {
  //         renderError(message: placeOrderResponse.message ?? 'Order failed.');
  //       }
  //     } else {
  //       Get.snackbar(
  //         'Error'.tr,
  //         'Please choose the payment method that suits you'.tr,
  //         snackPosition: SnackPosition.TOP,
  //         backgroundColor: Colors.red.withOpacity(0.8),
  //         colorText: Colors.white,
  //         duration: const Duration(seconds: 3),
  //       );
  //     }
  //   } catch (e) {
  //     print("error in place order :: $e");
  //   } finally {
  //     isLoading.value = false; // ⬅️ Stop loading
  //   }
  // }

  Future<void> placeOrder({
    required String paymentMethodId,
    required List<CartOffLineModel> cart,
    required BuildContext context,
  }) async {
    try {
      isLoading.value = true;

      if (paymentMethodId.isNotEmpty) {
        final cartDetails = await CartRepo().getOffLineCarts();

        final dataConvert = cartDetails.map((item) {
          return item.variantId == 0
              ? {
                  "item_id": item.itemId,
                  "qty": item.quantity,
                }
              : {
                  "item_id": item.itemId,
                  "variant_id": item.variantId,
                  "qty": item.quantity,
                };
        }).toList();

        final data = {
          "payment_method_id": paymentMethodId,
          "cart": dataConvert,
        };
        log(">>>>>>> aaaaaaaa $data");

        final response = await postRequest(
            urlExt: EndPoints().placeOrder,
            requiredToken: true,
            data: data,
            isJson: true);
        log(">>>>>>>asdsdsadas ${response.data}");

        final placeOrderResponse = PlaceOrder.fromJson(response.data);

        if (placeOrderResponse.status == true) {
          // 🟢 Clear cart table
          await CartRepo().clearCartTable();

          // 🟢 Re-fetch or validate that cart is empty
          final List<CartOffLineModel> updatedCart =
              await CartRepo().getOffLineCarts();
          if (updatedCart.isEmpty) {
            print("✅ Cart is now empty after placing order.");
          } else {
            print(
                "❌ Cart is not empty: ${updatedCart.length} items remaining.");
          }

          // ✅ Handle payment redirection or success message
          if (placeOrderResponse.data?.paymentUrl != null &&
              placeOrderResponse.data?.paymentUrl != "") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebViewScreen(
                  url: placeOrderResponse.data?.paymentUrl ?? "",
                ),
              ),
            ).then((value) {
              Get.offAllNamed(Routes.BOTTOMSHEET);
            });
          } else {
            Get.offAllNamed(Routes.BOTTOMSHEET);
            renderSuccess(
                message:
                    placeOrderResponse.message ?? 'Order placed successfully.');
          }

          // 🔄 تحديث الكارت من الكنترولر إذا كان مستخدم
          try {
            final cartCTRL = Get.find<CartController>();
            cartCTRL.getData(); // هذا يعيد تحميل البيانات في واجهة المستخدم
          } catch (_) {}
        } else {
          renderError(message: placeOrderResponse.message ?? 'Order failed.');
        }
      } else {
        Get.snackbar(
          'Error'.tr,
          'Please choose the payment method that suits you'.tr,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      print("error in place order :: $e");
      Get.snackbar(
        'Error'.tr,
        "error".tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
