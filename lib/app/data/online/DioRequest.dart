import 'dart:developer';

import 'package:customer/app/config/config.dart';
import 'package:customer/app/core/functions/public/get_lang';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as Get;

import '../../routes/app_pages.dart';

class DioRequest {
  static String apiUrl = Config.baseURL;
  static Dio dio = Dio(BaseOptions(
      baseUrl: apiUrl,
      followRedirects: false,
      validateStatus: (status) => true,
      headers: {
        'Accept-Language': language() == "en" ? "English" : "Arabic",
      }));
  static Dio? dioWithToken;

  static void createDioInstance(String? token) {
    dioWithToken = Dio(BaseOptions(
      baseUrl: apiUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept-Language': language() == "en" ? "English" : "Arabic",
      },
      followRedirects: false,
      validateStatus: (status) => true,
    ));
  }
}

Future<Response> postRequest(
    {required String urlExt,
    Map<String, dynamic>? data,
    bool isJson = false,
    bool requiredToken = false}) async {
  if (requiredToken) {
    // تأكد من إضافة الـ Token إلى الـ headers
    DioRequest.dioWithToken!.options.headers.addAll(
      {"Accept-Language": language() == "en" ? "English" : "Arabic"},
    );
  } else {
    // إضافة headers في حال لم يكن الـ Token مطلوبًا
    DioRequest.dio.options.headers.addAll(
      {"Accept-Language": language() == "en" ? "English" : "Arabic"},
    );
  }
  return requiredToken == true
      ? await DioRequest.dioWithToken!.post(
          urlExt,
          data: data != null
              ? isJson
                  ? data
                  : FormData.fromMap(data)
              : null,
        )
      : await DioRequest.dio
          .post(urlExt, data: data != null ? FormData.fromMap(data) : null);
}

Future<Response> putRequest(
    {required String urlExt,
    required Map data,
    bool? form,
    bool requiredToken = false}) async {
  if (requiredToken) {
    // تأكد من إضافة الـ Token إلى الـ headers
    DioRequest.dioWithToken!.options.headers.addAll(
      {"Accept-Language": language() == "en" ? "English" : "Arabic"},
    );
  } else {
    // إضافة headers في حال لم يكن الـ Token مطلوبًا
    DioRequest.dio.options.headers.addAll(
      {"Accept-Language": language() == "en" ? "English" : "Arabic"},
    );
  }
  return requiredToken
      ? await DioRequest.dioWithToken!.put(
          urlExt,
          data: form ?? false ? FormData.fromMap({...data}) : data,
        )
      : await DioRequest.dio.put(urlExt, data: data);
}

Future<Response> getRequest({
  required String urlExt,
  bool requireToken = false,
  Map<String, dynamic>? params,
  bool handleSignIn = false,
}) async {
  try {
    if (requireToken) {
      // تأكد من إضافة الـ Token إلى الـ headers
      DioRequest.dioWithToken!.options.headers.addAll(
        {"Accept-Language": language() == "en" ? "English" : "Arabic"},
      );
    } else {
      // إضافة headers في حال لم يكن الـ Token مطلوبًا
      DioRequest.dio.options.headers.addAll(
        {"Accept-Language": language() == "en" ? "English" : "Arabic"},
      );
    }

    return requireToken
        ? await DioRequest.dioWithToken!.get(
            urlExt,
            queryParameters: params,
          )
        : await DioRequest.dio.get(
            urlExt,
            queryParameters: params,
          );
  } catch (e) {
    return Future.error(e);
  }
}

Future<Response> deleteRequest(
    {required String urlExt,
    bool requireToken = false,
    bool handleSignIn = false}) async {
  if (requireToken) {
    // تأكد من إضافة الـ Token إلى الـ headers
    DioRequest.dioWithToken!.options.headers.addAll(
      {"Accept-Language": language() == "en" ? "English" : "Arabic"},
    );
  } else {
    // إضافة headers في حال لم يكن الـ Token مطلوبًا
    DioRequest.dio.options.headers.addAll(
      {"Accept-Language": language() == "en" ? "English" : "Arabic"},
    );
  }
  if (requireToken) {
    try {
      DioRequest.dioWithToken;
    } catch (e) {
      if (handleSignIn) {
        Get.Get.toNamed(Routes.SIGN_IN);
      } else {}
    }
  }
  return await DioRequest.dioWithToken!.delete(urlExt);
}
