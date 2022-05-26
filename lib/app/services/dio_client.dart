import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:kp_mobile/app/routes/app_pages.dart';
import 'package:kp_mobile/app/services/storage_service.dart';

class DioClient {
  late StorageService _service;
  Dio init({String? token}) {
    Dio dio = Dio();
    dio.options.baseUrl = 'http://192.168.45.109:3000/api';
    dio.options.contentType = Headers.jsonContentType;
    dio.options.headers['accept'] = 'application/json';
    dio.interceptors.add(DioInterceptors());
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
    _service = Get.find<StorageService>();
    return dio;
  }
}

class DioInterceptors extends Interceptor {
  @override
  Future<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('onRequest');
    inspect(options);
    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('onError');
    print(err);
    // throw to login if token is wrong
    if (err.response?.statusCode == 401) {
      print('Token expired');

      Get.offAndToNamed(Routes.LOGIN);
      return;
    }
    handler.next(err);
  }

  @override
  Future<dynamic> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    print('onResponse');
    inspect(response);
    handler.next(response);
  }
}
