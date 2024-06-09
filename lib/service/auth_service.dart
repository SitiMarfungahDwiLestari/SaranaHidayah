import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sarana_hidayah/constant/constant.dart';

class AuthService extends GetxController {
  Future register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      var data = jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
      });

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
      // Proses gagal karena error
      print(e.toString());
    }
  }
}
