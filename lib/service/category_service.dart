import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sarana_hidayah/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryService {
  Future<List<dynamic>> fetchCategories() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    final response = await http.get(
      Uri.parse(url + 'category'),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse = json.decode(response.body);
      return decodedResponse['data']['categories'];
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<void> addCategory(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    final response = await http.post(
      Uri.parse(url + 'category'),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: json.encode({
        'name': name,
      }),
    );

    final Map<String, dynamic> decodedResponse = json.decode(response.body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Category added successfully: ${decodedResponse['data']}');
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to add category');
    }
  }

  Future<void> updateCategory(int id, String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    final response = await http.put(
      Uri.parse(url + 'category/$id'),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: json.encode({
        'name': name,
      }),
    );

    if (response.statusCode == 200) {
      print('Category updated successfully');
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to updated category');
    }
  }

  Future<void> deleteCategory(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    final response = await http.delete(
      Uri.parse(url + 'category/$id'),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      print('Category deleted successfully');
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to delete category');
    }
  }
}
