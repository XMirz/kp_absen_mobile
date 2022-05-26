import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:kp_mobile/app/data/models/configuration.dart';
import 'package:kp_mobile/app/data/models/presence.dart';
import 'package:kp_mobile/app/data/models/user.dart';
import 'package:kp_mobile/app/services/dio_client.dart';
import 'package:kp_mobile/app/services/storage_service.dart';

class RootServices {
  late String token;
  late Dio _client;
  late StorageService _storageService;
  RootServices(String token) {
    _client = DioClient().init(token: token);
    _storageService = Get.find<StorageService>();
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
      var configuration = Configuration.fromJson(jsonEncode(response.data));
      return configuration;
    } on DioError catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
    return null;
  }

// If id is null, so its a checkIn
  Future<Presence?> checkInOut(
      {required double metersDistance,
      required Map<String, dynamic> currentLocation,
      int? id}) async {
    final data = {
      "inArea": metersDistance < 100 ? true : false,
      "distance": metersDistance.roundToDouble(),
      "location": currentLocation,
    };
    try {
      // If id is null, so its a new presence for today, and if its not, its an checkout request
      Response response = id == null
          ? await _client.post('/presence', data: data)
          : await _client.patch('/presence/$id', data: data);
      ;
      if (response.data['todayPresence'] != null) {
        var todayPresence =
            Presence.fromJson(jsonEncode(response.data['todayPresence']));
        return todayPresence;
      }
    } on DioError catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool> logout() async {
    Response response = await _client.delete('/sanctum');
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
