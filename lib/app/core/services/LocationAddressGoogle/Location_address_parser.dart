import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

import 'LocationAddressModel.dart';

class LocationAddressParser {
  String apiKey = 'AIzaSyC0etfL3e_wWMnWUwMcv9Its5rtEjbApZ4';
  static Dio dio = Dio(BaseOptions(
      baseUrl: 'https://maps.googleapis.com/maps/api/geocode',
      followRedirects: false,
      validateStatus: (status) => true,
      headers: {
        'Accept-Language': 'en',
      }));

  Future<String> getLocation({required double lat, required double lng}) async {
    final response = await dio.get('/json', queryParameters: {
      'latlng': '$lat,$lng',
      'key': apiKey,
    });
    try {
      List<LocationAddressGoogleModel> results = [];
      results = (response.data['results'] as List)
          .map((e) => LocationAddressGoogleModel.fromJson(e))
          .toList();
      return results.first.formattedAddress!;
    } catch (e) {
      return 'Un Defined'.tr;
    }
  }

  static getAddressFromLatLng({
    double? lat,
    double? lng,
    required void Function(String) onFind,
    void Function()? unFind,
  }) async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(lat!, lng!);

      if (placeMarks.isNotEmpty) {
        final place = placeMarks.first;
        log("${place.toJson()}");

        onFind(
          "${place.street}, ${place.locality} , ${place.country}",
        );
      } else {
        unFind!();
      }
    } catch (e) {
      unFind!();
    }
  }
}
