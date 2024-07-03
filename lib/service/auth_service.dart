import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sarana_hidayah/constant/constant.dart';
import 'package:sarana_hidayah/model/user.dart';
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
      body: jsonEncode({
        'name': name,
        'phone_number': phone,
        'address': address,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
      }),
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

  Future<Map<String, dynamic>> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    final response = await http.post(
      Uri.parse(url + 'logout'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      await preferences.remove('token');
    }

    return jsonDecode(response.body);
  }

  Future<User> fetchUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    final response = await http.get(
      Uri.parse(url + 'profile'),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print('fetchUser Response Status: ${response.statusCode}');
    print('fetchUser Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse = json.decode(response.body);
      print('Decoded Response: $decodedResponse');
      return User.fromMap(decodedResponse['data']
          ['user']); // Adjust this line to ensure the correct data mapping
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<void> updateUser(
      int id, String name, String phoneNumber, String address) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    final response = await http.put(
      Uri.parse(url + 'profile/$id'),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: json.encode({
        'name': name,
        'phoneNumber': phoneNumber,
        'address': address,
      }),
    );

    if (response.statusCode == 200) {
      print('User updated successfully');
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUser(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    final response = await http.delete(
      Uri.parse(url + 'profile/$id'),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      print('User deleted successfully');
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to delete user');
    }
  }
}
