import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:kp_mobile/app/routes/app_pages.dart';
import 'package:kp_mobile/app/services/storage_service.dart';

class DioClient {
  Dio init({String? token}) {
    Dio dio = Dio();
    dio.options.baseUrl = 'http://kp-absensi.herokuapp.com/api';
    dio.options.contentType = Headers.jsonContentType;
    dio.options.headers['accept'] = 'application/json';
    dio.interceptors.add(DioInterceptors());
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
    return dio;
  }
}

class DioInterceptors extends Interceptor {
  final StorageService _service = Get.find<StorageService>();
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
    print(err);
    // throw to login if token is wrong
    if (err.response?.statusCode == 401) {
      print('Token expired');
      _service.deleteAuthToken();
      Get.offAndToNamed(Routes.LOGIN);
      return;
    }
    handler.next(err);
  }

  @override
  Future<dynamic> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    print('onResponse');
    // inspect(response);
    handler.next(response);
  }
}
