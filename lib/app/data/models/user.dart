import 'dart:convert';

class User {
  final String? name;
  final String? address;
  final String? profile;
  final String? email;

  User({
    this.name,
    this.address,
    this.profile,
    this.email,
  });

  User copyWith({
    String? name,
    String? address,
    String? profile,
    String? email,
  }) {
    return User(
      name: name ?? this.name,
      address: address ?? this.address,
      profile: profile ?? this.profile,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'profile': profile,
      'email': email,
    };
  }

  factory User.fromMap(Map<dynamic, dynamic> map) {
    return User(
      name: map['name'],
      address: map['address'],
      profile: map['profile'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, address: $address, profile: $profile, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.name == name &&
        other.address == address &&
        other.profile == profile &&
        other.email == email;
  }

  @override
  int get hashCode {
    return name.hashCode ^ address.hashCode ^ profile.hashCode ^ email.hashCode;
  }
}
