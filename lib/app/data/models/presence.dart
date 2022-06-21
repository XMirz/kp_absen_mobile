import 'dart:convert';

import 'package:flutter/foundation.dart';

class Presence {
  int? id;
  String? type;
  String? description;
  Map<String, double>? checkInLocation;
  Map<String, double>? checkOutLocation;
  DateTime? checkInTime;
  DateTime? checkOutTime;
  double? checkInDistance;
  double? checkOutDistance;
  Presence({
    this.id,
    this.type,
    this.description,
    this.checkInLocation,
    this.checkOutLocation,
    this.checkInTime,
    this.checkOutTime,
    this.checkInDistance,
    this.checkOutDistance,
  });

  Presence copyWith({
    int? id,
    String? type,
    String? description,
    Map<String, double>? checkInLocation,
    Map<String, double>? checkOutLocation,
    DateTime? checkInTime,
    DateTime? checkOutTime,
    double? checkInDistance,
    double? checkOutDistance,
  }) {
    return Presence(
      id: id ?? this.id,
      type: type ?? this.type,
      description: description ?? this.description,
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
      'type': type,
      'description': description,
      'checkInLocation': checkInLocation,
      'checkOutLocation': checkOutLocation,
      'checkInTime': checkInTime?.millisecondsSinceEpoch,
      'checkOutTime': checkOutTime?.millisecondsSinceEpoch,
      'checkInDistance': checkInDistance,
      'checkOutDistance': checkOutDistance,
    };
  }

  factory Presence.fromMap(Map<String, dynamic> map) {
    // inspect(map);
    return Presence(
      id: map['id']?.toInt(),
      type: map['type'],
      description: map['description'],
      checkInLocation:
          Map<String, double>.from(jsonDecode(map['checkInLocation'])),
      checkOutLocation: map['checkOutLocation'] != null
          ? Map<String, double>.from(jsonDecode(map['checkOutLocation']))
          : null,
      checkInTime: map['checkInTime'] != null
          ? DateTime.parse(map['checkInTime'])
          : null,
      checkOutTime: map['checkOutTime'] != null
          ? DateTime.parse(map['checkOutTime'])
          : null,
      checkInDistance: map['checkInDistance'] != null
          ? double.tryParse(map['checkInDistance'])
          : null,
      checkOutDistance: map['checkOutDistance'] != null
          ? double.tryParse(map['checkOutDistance'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Presence.fromJson(String source) =>
      Presence.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Presence(id: $id, type: $type, checkInLocation: $checkInLocation, checkOutLocation: $checkOutLocation, checkInTime: $checkInTime, checkOutTime: $checkOutTime, checkInDistance: $checkInDistance, checkOutDistance: $checkOutDistance)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Presence &&
        other.id == id &&
        other.type == type &&
        other.description == description &&
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
        type.hashCode ^
        description.hashCode ^
        checkInLocation.hashCode ^
        checkOutLocation.hashCode ^
        checkInTime.hashCode ^
        checkOutTime.hashCode ^
        checkInDistance.hashCode ^
        checkOutDistance.hashCode;
  }
}
