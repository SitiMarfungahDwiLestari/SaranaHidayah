import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sarana_hidayah/constant/constant.dart';
import 'package:sarana_hidayah/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxController {
  late User user;
  Future<Map<String, dynamic>> register(
      String name,
      String? phone,
      String? address,
      String email,
      String password,
      String confirmPassword) async {
    Map<String, dynamic> body = {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
    };

    if (phone != null && phone.isNotEmpty) {
      body['phone_number'] = phone;
    }

    if (address != null && address.isNotEmpty) {
      body['address'] = address;
    }

    final response = await http.post(
      Uri.parse(url + 'register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 201 || response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 422) {
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      String errorMessage = 'Registration error';

      if (errorResponse.containsKey('errors') &&
          errorResponse['errors'].containsKey('email')) {
        errorMessage = errorResponse['errors']['email'][0];
      }

      return {'error': true, 'message': errorMessage};
    } else {
      throw Exception('Failed to register: ${response.statusCode}');
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

    print('Updating user: $id, $name, $phoneNumber, $address');

    final response = await http.put(
      Uri.parse(
          url + 'profile/$id'), // Adjust the endpoint according to your API
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'phone_number': phoneNumber,
        'address': address,
      }),
    );

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      // Update local user data
      user.name = name;
      user.phoneNumber = phoneNumber;
      user.address = address;
    } else {
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUser(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    final response = await http.delete(
      Uri.parse(url + 'profile/delete'),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        'id': id,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      print('User deleted successfully');
    } else {
      throw Exception('Failed to delete user');
    }
  }
}
