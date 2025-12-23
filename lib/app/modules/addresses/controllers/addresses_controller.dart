import 'dart:developer';

import 'package:customer/app/modules/checkOut/controllers/check_out_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../core/enum.dart';
import '../../../core/widgets/common/sizer.dart';
import '../../../data/online/data_parser.dart';
import '../../../models/cart/address_model.dart';
import '../../../models/common_address_model.dart';
import '../../../models/public/governorate_model.dart';
import '../../home/controllers/home_controller.dart';

class AddressesController extends GetxController {
  AddressResponse? addressResponse;
  AddressData? selectedAddress;
  CommonResponseModel? commonResponseModel;
  List<GovernorateModel> governorate = <GovernorateModel>[];

  int selectedGovernorateId = 0;

  final fromFiled = GlobalKey<FormState>();

  TextEditingController areaController = TextEditingController();
  TextEditingController buildController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  TextEditingController searchController = TextEditingController();

  Status status = Status.loading;
  Status statusGovernorate = Status.loading;
  Status addressStatus = Status.loaded;
  Status locationStatus = Status.loaded;
  Status updateMap = Status.loaded;

  GoogleMapController? mapController;
  LatLng? latLong;
  Set<Marker> markers = {};

  @override
  void onInit() {
    getAddresses();
    getGovernorate();
    super.onInit();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;

    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (latLong != null) {
          navigationToNewLocation(latLong!);
          return;
        }
        if (selectedAddress != null) {
          newLocation();
        } else {
          getMyLocation();
        }
      },
    );
  }

  navigationToNewLocation(LatLng latLong) {
    mapController!.animateCamera(
      CameraUpdate.newLatLngZoom(
        latLong,
        16.0,
      ),
    );
    markers = {};
    markers.add(
      Marker(
        markerId: const MarkerId("selected_marker"),
        position: latLong,
        infoWindow: InfoWindow(title: searchController.text),
      ),
    );
    update();
  }

  newLocation() {
    if (mapController == null) return;

    final lat = selectedAddress?.lat;
    final lng = selectedAddress?.long;
    if (lat != null && lng != null) {
      navigationToNewLocation(
        selectedAddress == null
            ? const LatLng(30.0444, 31.2357)
            : LatLng(lat, lng),
      );
    }
  }

  getMyLocation() {
    final homeController = Get.find<HomeController>();

    if (homeController.address.value!.isNotEmpty) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(homeController.lat!, homeController.lng!),
          16.0,
        ),
      );
      markers = {};
      markers.add(
        Marker(
          markerId: const MarkerId("selected_marker"),
          position: LatLng(homeController.lat!, homeController.lng!),
          infoWindow: const InfoWindow(title: "Selected Address"),
        ),
      );
      update();
    } else {
      homeController.getLocation(
        callback: (p0) {
          mapController!.animateCamera(CameraUpdate.newLatLngZoom(p0, 16.0));
          markers = {};
          markers.add(
            Marker(
              markerId: const MarkerId("selected_marker"),
              position: p0,
              infoWindow: const InfoWindow(title: "Selected Address"),
            ),
          );
        },
      );
      update();
    }
  }

  selectLocation(Prediction prediction) {
    latLong = LatLng(
      double.tryParse(prediction.lat!)!,
      double.tryParse(prediction.lng!)!,
    );
    markers = {};
    mapController!.animateCamera(CameraUpdate.zoomTo(5));
    update();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(
            latLong!,
            16.0,
          ),
        );
        markers = {};
        markers.add(
          Marker(
            markerId: const MarkerId("selected_marker"),
            position: latLong!,
            infoWindow: InfoWindow(title: prediction.description),
          ),
        );
        locationStatus = Status.loaded;
        update();
      },
    );
  }

  itemClickOnSearchMap(Prediction prediction) {
    locationStatus = Status.loading;

    update();
    searchController.text = prediction.description ?? "";
    searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: prediction.description?.length ?? 0));
  }

  void getGovernorate() async {
    try {
      statusGovernorate = Status.loading;
      latLong = null;
      markers = {};
      searchController.clear();
      update();
      governorate = await DataParser().getGovernorates();
      statusGovernorate = Status.loaded;
      clear();
      if (selectedAddress != null) {
        areaController.text = selectedAddress!.area;
        buildController.text = selectedAddress!.building;
        homeController.text = selectedAddress!.flat;
        floorController.text = selectedAddress!.floor;
        phoneNumberController.text =
            selectedAddress!.additionalPhone.toString();

        if (selectedAddress!.cityId != null) {
          final governorateModel = governorate
              .where((e) => e.id == selectedAddress!.cityId)
              .toList();

          if (governorateModel.isNotEmpty) {
            cityController.text = governorateModel.first.name!;
          }
        }
      }
      update();
    } catch (e) {
      statusGovernorate = Status.fail;
      update();
    }
  }

  clear() {
    areaController.clear();
    buildController.clear();
    homeController.clear();
    floorController.clear();
    phoneNumberController.clear();
    // cityController.clear();
  }

  bool showEdit = true;
  Future<void> getAddresses() async {
    status = Status.loading;
    selectedAddress = null;
    addressResponse = null;
    update();

    try {
      addressResponse = await DataParser().getAddresses();
      status = Status.loaded;
      log("message>>${Get.arguments}");
      if (Get.arguments != null) {
        showEdit = false;
      }
      update();
    } catch (e) {
      status = Status.fail;
      update();
    }
  }

  deleteAddress(int id) async {
    status = Status.loading;
    selectedAddress = null;
    commonResponseModel = null;
    update();

    try {
      commonResponseModel = await DataParser().deleteAddresses(id);
      if (commonResponseModel!.status == true) {
        await getAddresses();
        if (addressResponse!.data.isEmpty) {
          handleCheckoutController("delete");
        }

        Get.snackbar(
          'Success'.tr,
          commonResponseModel!.message!,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      } else {
        status = Status.fail;
        update();
        final text = commonResponseModel!.message!.isEmpty
            ? 'error_message'.tr
            : commonResponseModel?.message;
        failed(text);
      }
    } catch (e) {
      status = Status.fail;
      update();
      failed('error_message'.tr);
    }
  }

  addNewAddress() async {
    try {
      if (fromFiled.currentState!.validate()) {
        addressStatus = Status.loading;
        commonResponseModel = null;

        update();

        final data = {
          "building": buildController.text,
          "flat": homeController.text,
          "floor": floorController.text,
          "additional_phone": phoneNumberController.text,
          "is_default": false,
          "country_id": selectedGovernorateId,
          "area": areaController.text,
          if (latLong != null) ...{
            "lat": latLong!.latitude,
            "long": latLong!.longitude,
          },
        };

        log("message $data");

        commonResponseModel = await DataParser().addAddress(data);

        if (commonResponseModel!.status == true) {
          getAddresses();
          Get.back();
          addressStatus = Status.loaded;
          update();
          Get.snackbar(
            'Success'.tr,
            commonResponseModel!.message!,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green.withOpacity(0.8),
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
        } else {
          final text = commonResponseModel!.message!.isEmpty
              ? 'error_message'.tr
              : commonResponseModel?.message;
          failed(text);
        }
      }
    } catch (e) {
      failed('error_message'.tr);
    }
  }

  updateAddress() async {
    try {
      if (fromFiled.currentState!.validate()) {
        addressStatus = Status.loading;
        commonResponseModel = null;

        update();

        final data = {
          "building": buildController.text,
          "flat": homeController.text,
          "floor": floorController.text,
          "additional_phone": phoneNumberController.text,
          "is_default": selectedAddress!.isDefault,
          "country_id": selectedGovernorateId,
          "area": areaController.text,
          if (latLong != null ||
              (selectedAddress!.lat != null &&
                  selectedAddress!.long != null)) ...{
            "lat": latLong == null ? selectedAddress!.lat : latLong!.latitude,
            "long":
                latLong == null ? selectedAddress!.long : latLong!.longitude,
          },
        };

        commonResponseModel =
            await DataParser().updateAddress(data, selectedAddress!.id);

        if (commonResponseModel!.status == true) {
          Get.back();
          addressStatus = Status.loaded;
          update();
          Get.snackbar(
            'Success'.tr,
            commonResponseModel!.message!,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green.withOpacity(0.8),
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
          getAddresses();
        } else {
          final text = commonResponseModel!.message!.isEmpty
              ? 'error_message'.tr
              : commonResponseModel?.message;
          failed(text);
        }
      }
    } catch (e) {
      log('message$e');
      failed('error_message'.tr);
    }
  }

  failed(error) {
    addressStatus = Status.fail;
    update();

    Get.snackbar(
      'Error'.tr,
      error!,
      snackPosition: SnackPosition.TOP, // Position on the screen
      backgroundColor: Colors.red.withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 3), // Duration for the message
    );
  }

  updateCamera(BuildContext context) {
    updateMap = Status.loading;
    areaController.text = searchController.text;
    update();
    Navigator.of(context).pop();
    Get.back();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        updateMap = Status.loaded;
        update();
      },
    );
  }

  Future<dynamic> confirmation(BuildContext context, String address) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text('confirm'.tr),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                borderRadius: BorderRadius.circular(6),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.close,
                    color: mainColor,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "do_you_use_location".tr,
                textAlign: TextAlign.center,
                style: Styles.styleBold18,
              ),
              sizer(),
              Text(
                address,
                textAlign: TextAlign.center,
                style: Styles.styleMedium15,
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                updateCamera(context);
              },
              child: Text(
                'yes'.tr,
                style: const TextStyle(color: Colors.green),
              ),
            ),
            TextButton(
              onPressed: () {
                latLong = null;
                searchController.clear();
                update();
                Navigator.of(context).pop();
                Get.back();
              },
              child: Text(
                'no'.tr,
                style: TextStyle(color: mainColor),
              ),
            ),
          ],
        );
      },
    );
  }

  setAddressDefault(int itemId) async {
    try {
      status = Status.loading;
      update();

      final result = await DataParser().setAddressDefault(itemId);

      if (result.status == true) {
        Get.find<HomeController>().getProfile();
        handleCheckoutController("default");

        Get.snackbar(
          'Success'.tr,
          result.message!,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        getAddresses();
      } else {
        status = Status.loaded;
        update();
        Get.snackbar(
          'Error'.tr,
          result.message!,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      status = Status.loaded;
      update();
      Get.snackbar(
        'Error'.tr,
        'error_message'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  handleCheckoutController(String action) {
    if (Get.arguments != null) {
      Get.find<CheckOutController>().updateCart();
      log("update");

      if (action == "default") {
        Get.back(result: true);
      }
    }
  }
}
