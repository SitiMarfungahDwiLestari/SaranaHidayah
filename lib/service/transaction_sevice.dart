import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sarana_hidayah/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionService {
  Future<List<dynamic>> fetchTransactions() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    final response = await http.get(
      Uri.parse(url + 'transaction'),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse = json.decode(response.body);
      return decodedResponse['data'];
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  Future<dynamic> fetchTransactionById(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    final response = await http.get(
      Uri.parse(url + 'transaction/$id'),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse = json.decode(response.body);
      return decodedResponse['data'];
    } else {
      throw Exception('Failed to load transaction');
    }
  }

  Future<void> createTransaction(String paymentProofPath) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    var request =
        http.MultipartRequest('POST', Uri.parse(url + 'transactions'));
    request.headers.addAll({
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });

    request.files.add(
        await http.MultipartFile.fromPath('payment_proof', paymentProofPath));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 201) {
      throw Exception('Failed to create transaction');
    }
  }

  Future<void> updateTransaction(int id, String trackingNumber) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    final response = await http.put(
      Uri.parse(url + 'transaction/$id'),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: json.encode({
        'tracking_number': trackingNumber,
      }),
    );

    if (response.statusCode != 200) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to update transaction');
    }
  }

  Future<void> deleteTransaction(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    final response = await http.delete(
      Uri.parse(url + 'transaction/$id'),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to delete transaction');
    }
  }
}
