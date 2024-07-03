import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sarana_hidayah/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxController {
  Future<Map<String, dynamic>> register(
      String name,
      String phone,
      String address,
      String email,
      String password,
      String confirmPassword) async {
    final response = await http.post(
      Uri.parse(url + 'register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: {
        'name': name,
        'phone_number': phone,
        'address': address,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
      },
    );
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(url + 'login'),
      body: {'email': email, 'password': password},
      headers: {"Accept": "application/json"},
    );
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');
    return jsonDecode(response.body);
  }

  Future<void> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('token');
  }
}
