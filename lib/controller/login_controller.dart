import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarana_hidayah/service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {


  final AuthService authService = AuthService();


  Future<String> login(String email, String password) async {
    final response = await authService.login(email, password);
    if (response.containsKey('status') &&
        response['status'] == 'Login success!') {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString('token', response['access_token']);
      return 'Login successful';
    } else {
      return response['message'] ?? 'Terjadi kesalahan saat login.';
    }
  }

}
