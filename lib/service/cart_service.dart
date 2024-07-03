import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sarana_hidayah/constant/constant.dart';

class CartService {
  Future<List<dynamic>> fetchCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(url + 'cart'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load cart items');
    }
  }

  Future<void> addToCart(int bookId, int count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.post(
      Uri.parse(url + 'cart'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: {
        'book_id': bookId.toString(),
        'count': count.toString(),
      },
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add item to cart');
    }
  }

  Future<void> updateCartItem(int cartId, int count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.put(
      Uri.parse(url + 'cart/$cartId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: {
        'count': count.toString(),
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update item quantity');
    }
  }

  Future<void> deleteCartItem(int cartId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.delete(
      Uri.parse(url + 'cart/$cartId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete item from cart');
    }
  }
}
