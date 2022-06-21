import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kp_mobile/app/data/models/configuration.dart';
import 'package:kp_mobile/app/data/models/presence.dart';
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
  Future<Presence?> checkIn({
    required double metersDistance,
    required Map<String, dynamic> currentLocation,
    required String type,
    required String description,
  }) async {
    final data = {
      "distance": metersDistance.roundToDouble(),
      "location": currentLocation,
      "type": type,
      "description": description,
    };
    try {
      Response response = await _client.post('/presence', data: data);
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

  Future<Presence?> checkOut({
    required double metersDistance,
    required Map<String, dynamic> currentLocation,
    required int id,
  }) async {
    final data = {
      "inArea": metersDistance < 100 ? true : false,
      "distance": metersDistance.roundToDouble(),
      "location": currentLocation,
    };
    try {
      // If id is null, so its a new presence for today, and if its not, its an checkout request
      Response response = await _client.patch('/presence/$id', data: data);
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
    try {
      Response response = await _client.delete('/sanctum');
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> updatePassword(Map<dynamic, dynamic> data) async {
    try {
      Response response = await _client.patch('/user/password', data: data);
      if (response.statusCode == 200) {
        print(response.data);
        if (response.data['status'] == "success") {
          return true;
        }
      }
    } on DioError catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
    return false;
  }
}
