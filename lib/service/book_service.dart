import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sarana_hidayah/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookService {
  Future<List<dynamic>> fetchBooks() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    final response = await http.get(
      Uri.parse(url + 'book'),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeResponse = json.decode(response.body);
      return decodeResponse['data']['books'];
    } else {
      throw Exception('Failed to load books');
    }
  }
}
