import 'dart:convert';

import 'package:flutter/foundation.dart';

class Presence {
  int? id;
  bool? inArea;
  Map<String, double>? checkInLocation;
  Map<String, double>? checkOutLocation;
  DateTime? checkInTime;
  DateTime? checkOutTime;
  double? checkInDistance;
  double? checkOutDistance;
  Presence({
    this.id,
    this.inArea,
    this.checkInLocation,
    this.checkOutLocation,
    this.checkInTime,
    this.checkOutTime,
    this.checkInDistance,
    this.checkOutDistance,
  });

  Presence copyWith({
    int? id,
    bool? inArea,
    Map<String, double>? checkInLocation,
    Map<String, double>? checkOutLocation,
    DateTime? checkInTime,
    DateTime? checkOutTime,
    double? checkInDistance,
    double? checkOutDistance,
  }) {
    return Presence(
      id: id ?? this.id,
      inArea: inArea ?? this.inArea,
      checkInLocation: checkInLocation ?? this.checkInLocation,
      checkOutLocation: checkOutLocation ?? this.checkOutLocation,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      checkInDistance: checkInDistance ?? this.checkInDistance,
      checkOutDistance: checkOutDistance ?? this.checkOutDistance,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'inArea': inArea,
      'checkInLocation': checkInLocation,
      'checkOutLocation': checkOutLocation,
      'checkInTime': checkInTime?.millisecondsSinceEpoch,
      'checkOutTime': checkOutTime?.millisecondsSinceEpoch,
      'checkInDistance': checkInDistance,
      'checkOutDistance': checkOutDistance,
    };
  }

  factory Presence.fromMap(Map<String, dynamic> map) {
    return Presence(
      id: map['id']?.toInt(),
      inArea: map['inArea'],
      checkInLocation:
          Map<String, double>.from(jsonDecode(map['checkInLocation'])),
      checkOutLocation:
          Map<String, double>.from(jsonDecode(map['checkOutLocation'])),
      checkInTime: map['checkInTime'] != null
          ? DateTime.parse(map['checkInTime'])
          : null,
      checkOutTime: map['checkOutTime'] != null
          ? DateTime.parse(map['checkOutTime'])
          : null,
      checkInDistance: map['checkInDistance']?.toDouble(),
      checkOutDistance: map['checkOutDistance']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Presence.fromJson(String source) =>
      Presence.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Presence(id: $id, inArea: $inArea, checkInLocation: $checkInLocation, checkOutLocation: $checkOutLocation, checkInTime: $checkInTime, checkOutTime: $checkOutTime, checkInDistance: $checkInDistance, checkOutDistance: $checkOutDistance)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Presence &&
        other.id == id &&
        other.inArea == inArea &&
        mapEquals(other.checkInLocation, checkInLocation) &&
        mapEquals(other.checkOutLocation, checkOutLocation) &&
        other.checkInTime == checkInTime &&
        other.checkOutTime == checkOutTime &&
        other.checkInDistance == checkInDistance &&
        other.checkOutDistance == checkOutDistance;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        inArea.hashCode ^
        checkInLocation.hashCode ^
        checkOutLocation.hashCode ^
        checkInTime.hashCode ^
        checkOutTime.hashCode ^
        checkInDistance.hashCode ^
        checkOutDistance.hashCode;
  }
}
