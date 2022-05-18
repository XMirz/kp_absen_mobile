import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kp_mobile/app/data/models/user.dart';
import 'package:kp_mobile/app/services/dio_client.dart';

class RootServices {
  late String token;
  late Dio _client;
  RootServices(String token) {
    _client = DioClient().init(token: token);
  }

  Future<User?> getAuthUser() async {
    Response response = await _client.get(
      '/user',
    );
    if (response.statusCode == 200) {
      try {
        var user = User.fromJson(jsonEncode(response.data));
        return user;
      } catch (e) {
        print(e);
      }
      // return user;
    }
    return null;
  }
}
