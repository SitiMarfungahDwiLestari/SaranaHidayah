class User {
  final String name;
  final String email;
  final String password;
  final String? confirmPassword;

  User({
    required this.name,
    required this.email,
    required this.password,
    this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      if (confirmPassword != null) 'password_confirmation': confirmPassword,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      confirmPassword: json['password_confirmation'],
    );
  }
}
