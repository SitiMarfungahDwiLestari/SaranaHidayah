import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarana_hidayah/model/user.dart';
import 'package:sarana_hidayah/service/auth_service.dart';

class RegisterController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final AuthService _authService = Get.put(AuthService());

  void register() async {
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Password and confirm password do not match');
      return;
    }

    User user = User(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: password,
      confirmPassword: confirmPassword,
    );

    await _authService.register(user: user);
  }
}