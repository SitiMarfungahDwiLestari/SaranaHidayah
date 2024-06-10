import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sarana_hidayah/constant/constant.dart';
import 'package:sarana_hidayah/model/user.dart';
import 'package:sarana_hidayah/screen/home_page.dart';

class AuthService extends GetxController {
  Future register({required User user}) async {
    try {
      var data = jsonEncode(user.toJson());

      var response = await http.post(
        Uri.parse(url + 'register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 201) {
        // Proses berhasil
        var responseData = json.decode(response.body);
        debugPrint(responseData.toString());
      } else {
        // Proses gagal
        var responseData = json.decode(response.body);
        debugPrint(responseData.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      var data = jsonEncode({
        'email': email,
        'password': password,
      });

      var response = await http.post(
        Uri.parse(url + 'login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: data,
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 201) {
        // Proses berhasil
        var responseData = json.decode(response.body);
        debugPrint(responseData.toString());
        Get.offAll(() => HomePage());
      } else {
        // Proses gagal
        var responseData = json.decode(response.body);
        debugPrint(responseData.toString());
        Get.snackbar('Error', responseData['message'] ?? 'Login failed');
      }
    } catch (e) {
      // Proses gagal karena error
      print(e.toString());
      Get.snackbar('Error', 'An error occurred');
    }
  }
}
