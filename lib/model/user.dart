class User {
  int id;
  String name;
  String? phoneNumber;
  String? address;
  String email;
  bool isAdmin;

  User({
    required this.id,
    required this.name,
    this.phoneNumber,
    this.address,
    required this.email,
    required this.isAdmin,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      phoneNumber: map['phone_number'],
      address: map['address'],
      email: map['email'] ?? '',
      isAdmin: map['is_admin'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone_number': phoneNumber,
      'address': address,
      'email': email,
      'is_admin': isAdmin,
    };
  }
}
