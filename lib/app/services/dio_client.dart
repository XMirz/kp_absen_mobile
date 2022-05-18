import 'dart:developer';

import 'package:dio/dio.dart';

class DioClient {
  Dio init({String? token}) {
    Dio _dio = new Dio();
    _dio.options.baseUrl = 'https://da74-114-125-59-5.ngrok.io/api';
    _dio.interceptors.add(DioInterceptors());
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
    return _dio;
  }
  // final dio = Dio();
  // final _baseUrl = 'https://da74-114-125-59-5.ngrok.io/api';

  // String endPoint(String route) {
  //   return '$_baseUrl$route';
  // }
}

class DioInterceptors extends Interceptor {
  @override
  Future<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('onRequest');
    // inspect(options);
    handler.next(options);
  }

  @override
  void onError(DioError dioError, ErrorInterceptorHandler handler) {
    print('onError');
    print(dioError.message);
    handler.next(dioError);
  }

  @override
  Future<dynamic> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    print('onResponse');
    // inspect(response.data);
    handler.next(response);
  }
}
