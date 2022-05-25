import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kp_mobile/app/data/models/configuration.dart';
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

  Future<Configuration?> getInitialData() async {
    try {
      Response response = await _client.get('/configdata');
      // Map<String, dynamic> data = jsonDecode(jsonEncode(response.data));
      // Location? checkInLocation;
      // Location? checkOutLocation;
      // Map<String, dynamic>? todayPresenceMap = data['todayPresence'];
      // Presence? todayPresence;
      // if (todayPresenceMap != null) {
      //   checkInLocation = todayPresenceMap['checkInLocation'] != null
      //       ? Location.fromMap(todayPresenceMap['checkInLocation'])
      //       : null;
      //   checkOutLocation = todayPresenceMap['checkOutLocation'] != null
      //       ? Location.fromMap(todayPresenceMap['checkOutLocation'])
      //       : null;
      //   todayPresence.copyWith()
      // }

      // inspect(data);
      var configuration = Configuration.fromJson(jsonEncode(response.data));
      return configuration;
    } on DioError catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
    return null;
  }
}
