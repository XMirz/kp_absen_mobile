import 'package:dio/dio.dart';

class DioClient {
  Dio init({String? token}) {
    Dio dio = Dio();
    dio.options.baseUrl = 'http://192.168.52.109:3000/api';
    dio.interceptors.add(DioInterceptors());
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
    return dio;
  }
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
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('onError');
    print(err.message);
    handler.next(err);
  }

  @override
  Future<dynamic> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    print('onResponse');
    // inspect(response.data);
    handler.next(response);
  }
}
