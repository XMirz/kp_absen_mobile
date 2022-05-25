import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:kp_mobile/app/data/models/presence.dart';

class Configuration {
  final String? location;
  final String? longitude;
  final String? latitude;
  final String? today;
  final int? postalcode;
  final bool? eligible;
  final Map<String, dynamic>? todayPresence;
  Configuration({
    this.location,
    this.longitude,
    this.latitude,
    this.today,
    this.postalcode,
    this.eligible,
    this.todayPresence,
  });

  Configuration copyWith({
    String? location,
    String? longitude,
    String? latitude,
    String? today,
    int? postalcode,
    bool? eligible,
    Map<String, dynamic>? todayPresence,
  }) {
    return Configuration(
      location: location ?? this.location,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      today: today ?? this.today,
      postalcode: postalcode ?? this.postalcode,
      eligible: eligible ?? this.eligible,
      todayPresence: todayPresence ?? this.todayPresence,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'longitude': longitude,
      'latitude': latitude,
      'today': today,
      'postalcode': postalcode,
      'eligible': eligible,
      'todayPresence': todayPresence,
    };
  }

  factory Configuration.fromMap(Map<String, dynamic> map) {
    return Configuration(
      location: map['location'],
      longitude: map['longitude'],
      latitude: map['latitude'],
      today: map['today'],
      postalcode: map['postalcode']?.toInt(),
      eligible: map['eligible'],
      todayPresence: map['todayPresence'] != null
          ? Map<String, dynamic>.from(map['todayPresence'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Configuration.fromJson(String source) =>
      Configuration.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Configuration(location: $location, longitude: $longitude, latitude: $latitude, today: $today, postalcode: $postalcode, eligible: $eligible, todayPresence: $todayPresence)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Configuration &&
        other.location == location &&
        other.longitude == longitude &&
        other.latitude == latitude &&
        other.today == today &&
        other.postalcode == postalcode &&
        other.eligible == eligible &&
        mapEquals(other.todayPresence, todayPresence);
  }

  @override
  int get hashCode {
    return location.hashCode ^
        longitude.hashCode ^
        latitude.hashCode ^
        today.hashCode ^
        postalcode.hashCode ^
        eligible.hashCode ^
        todayPresence.hashCode;
  }
}