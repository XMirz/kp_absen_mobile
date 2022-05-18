import 'package:dio/dio.dart';
import 'package:kp_mobile/app/services/dio_client.dart';

class AuthService {
  final Dio _client = DioClient().init();

  Future<String?> getAuthToken(Map<String, String> data) async {
    try {
      Response response = await _client.post('/sanctum/token', data: data);
      if (response.statusCode == 200) {
        var token = response.data['token'];
        return token;
      }
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }
}
