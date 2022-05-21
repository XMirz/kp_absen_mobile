import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kp_mobile/app/data/models/company.dart';
import 'package:kp_mobile/app/data/models/user.dart';
import 'package:kp_mobile/app/services/dio_client.dart';

class RootServices {
  late String token;
  late Dio _client;
  RootServices(String token) {
    _client = DioClient().init(token: token);
  }

  Future<User?> getAuthUser() async {
    Response response = await _client.get('/user');
    if (response.statusCode == 200) {
      var user = User.fromJson(jsonEncode(response.data));
      return user;
    }
    return null;
  }

  Future<Company?> getInitialData() async {
    try {
      Response response = await _client.get('/configdata');
      var company = Company.fromJson(jsonEncode(response.data));
      return company;
    } on DioError catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
    return null;
  }
}
