import 'dart:convert';

class User {
  final int id;
  final String name;
  final String phoneNumber;
  final String address;
  final String email;
  final bool isAdmin;
  User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.email,
    required this.isAdmin,
  });

  User copyWith({
    int? id,
    String? name,
    String? phoneNumber,
    String? address,
    String? email,
    bool? isAdmin,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      email: email ?? this.email,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'address': address,
      'email': email,
      'isAdmin': isAdmin,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      address: map['address'] as String,
      email: map['email'] as String,
      isAdmin: map['isAdmin'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, phoneNumber: $phoneNumber, address: $address, email: $email, isAdmin: $isAdmin)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.phoneNumber == phoneNumber &&
        other.address == address &&
        other.email == email &&
        other.isAdmin == isAdmin;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phoneNumber.hashCode ^
        address.hashCode ^
        email.hashCode ^
        isAdmin.hashCode;
  }
}
