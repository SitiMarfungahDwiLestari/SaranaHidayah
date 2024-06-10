import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarana_hidayah/service/auth_service.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthService _authService = Get.put(AuthService());

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    await _authService.login(email: email, password: password);
  }
}
