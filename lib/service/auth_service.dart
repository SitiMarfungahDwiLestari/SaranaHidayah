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
}
