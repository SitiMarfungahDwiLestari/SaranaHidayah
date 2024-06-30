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

  Future<void> addBook(String title, String author, int publicationYear,
      int price, String description, int categoryId, String imagePath) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    final request = http.MultipartRequest('POST', Uri.parse(url + 'book'))
      ..headers.addAll({
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      })
      ..fields.addAll({
        'title': title,
        'author': author,
        'publication_year': publicationYear.toString(),
        'price': price.toString(),
        'description': description,
        'category_id': categoryId.toString(),
      })
      ..files.add(await http.MultipartFile.fromPath('image', imagePath));

    final response = await request.send();
    final responseData = await response.stream.bytesToString();

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Book added successfully: $responseData');
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: $responseData');
      throw Exception('Failed to add book');
    }
  }

  Future<void> updateBook(int id, String title, String author,
      int publicationYear, int price, String description, int categoryId,
      [String? imagePath]) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    final request = http.MultipartRequest('POST', Uri.parse(url + 'book/$id'))
      ..headers.addAll({
        "Accept": "application/json",
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      })
      ..fields.addAll({
        '_method': 'PUT',
        'title': title,
        'author': author,
        'publication_year': publicationYear.toString(),
        'price': price.toString(),
        'description': description,
        'category_id': categoryId.toString(),
      });

    if (imagePath != null) {
      request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    }

    final response = await request.send();
    final responseData = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print('Book updated successfully: $responseData');
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: $responseData');
      throw Exception('Failed to update book');
    }
  }

  Future<void> deleteBook(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    final response = await http.delete(
      Uri.parse(url + 'book/$id'),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete book');
    }
  }
}
