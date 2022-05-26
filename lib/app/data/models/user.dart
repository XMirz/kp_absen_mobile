import 'dart:convert';

class User {
  final String? name;
  final String? nip;
  final String? gender;
  final String? address;
  final DateTime? birthDate;
  final String? profile;
  final String? role;
  final String? email;

  User({
    this.name,
    this.nip,
    this.gender,
    this.address,
    this.birthDate,
    this.profile,
    this.role,
    this.email,
  });

  User copyWith({
    String? name,
    String? nip,
    String? gender,
    String? address,
    DateTime? birthDate,
    String? profile,
    String? role,
    String? email,
  }) {
    return User(
      name: name ?? this.name,
      nip: nip ?? this.nip,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      birthDate: birthDate ?? this.birthDate,
      profile: profile ?? this.profile,
      role: role ?? this.role,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'nip': nip,
      'gender': gender,
      'address': address,
      'birthDate': birthDate?.millisecondsSinceEpoch,
      'profile': profile,
      'role': role,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      nip: map['nip'],
      gender: map['gender'],
      address: map['address'],
      birthDate:
          map['birthDate'] != null ? DateTime.parse(map['birthDate']) : null,
      profile: map['profile'],
      role: map['role'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, nip: $nip, gender: $gender, address: $address, birthDate: $birthDate, profile: $profile, role: $role, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.name == name &&
        other.nip == nip &&
        other.gender == gender &&
        other.address == address &&
        other.birthDate == birthDate &&
        other.profile == profile &&
        other.role == role &&
        other.email == email;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        nip.hashCode ^
        gender.hashCode ^
        address.hashCode ^
        birthDate.hashCode ^
        profile.hashCode ^
        role.hashCode ^
        email.hashCode;
  }
}
