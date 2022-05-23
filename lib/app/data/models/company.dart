import 'dart:convert';

class Company {
  final String? location;
  final String? longitude;
  final String? latitude;
  final String? today;
  final String? postalcode;
  Company({
    this.location,
    this.longitude,
    this.latitude,
    this.today,
    this.postalcode,
  });

  Company copyWith({
    String? location,
    String? longitude,
    String? latitude,
    String? today,
    String? postalcode,
  }) {
    return Company(
      location: location ?? this.location,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      today: today ?? this.today,
      postalcode: postalcode ?? this.postalcode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'longitude': longitude,
      'latitude': latitude,
      'today': today,
      'postalcode': postalcode,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      location: map['location'],
      longitude: map['longitude'],
      latitude: map['latitude'],
      today: map['today'],
      postalcode: map['postalcode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Company.fromJson(String source) =>
      Company.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Company(location: $location, longitude: $longitude, latitude: $latitude, today: $today, postalcode: $postalcode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Company &&
        other.location == location &&
        other.longitude == longitude &&
        other.latitude == latitude &&
        other.today == today &&
        other.postalcode == postalcode;
  }

  @override
  int get hashCode {
    return location.hashCode ^
        longitude.hashCode ^
        latitude.hashCode ^
        today.hashCode ^
        postalcode.hashCode;
  }
}
