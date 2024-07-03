import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sarana_hidayah/controller/auth_controller.dart';
import 'package:sarana_hidayah/controller/cart_controller.dart';
import 'package:sarana_hidayah/screen/home_page.dart';
import 'package:sarana_hidayah/service/transaction_sevice.dart';
import 'dart:io';

class TransactionPage extends StatefulWidget {
  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final AuthController _authController = Get.find<AuthController>();
  final CartController cartController = Get.put(CartController());
  final TransactionService transactionService = TransactionService();
  final formatCurrency = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );
  File? _image;

  @override
  void initState() {
    super.initState();
    // Add any necessary initialization if needed
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _checkout() async {
    if (_image == null) {
      // Show an error if no image is selected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please upload a payment proof')),
      );
      return;
    }

    try {
      await transactionService.createTransaction(_image!.path);

      // Clear the cart after successful checkout
      cartController.clearCart();

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Checkout successful')),
      );

      Future.delayed(Duration(seconds: 2), () {
        Get.to(HomePage());
      });
      // Navigate back or to another page if necessary
    } catch (e) {
      // Show an error message if checkout fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Checkout failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 12,
                            ),
                            SizedBox(width: 20),
                            Text(
                              'Customer Information',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Obx(() {
                          String nama = _authController.user.value.name;
                          String alamat =
                              _authController.user.value.address ?? '';
                          String phoneNumber =
                              _authController.user.value.phoneNumber ?? '';
                          String email = _authController.user.value.email;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nama : $nama',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Alamat : $alamat',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'No HP : $phoneNumber',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Email : $email',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Stack(
                children: [
                  Container(
                    height: 350, // Adjust the height as needed
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Transaction Details',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'No',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Title',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Count',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Price',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Total Price',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Divider(thickness: 1),
                          // Example transaction data
                          Obx(() {
                            if (_authController.user.value.name.isEmpty) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            // Replace with your transaction data
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: cartController.cartItems.length,
                              itemBuilder: (context, index) {
                                var item = cartController.cartItems[index];
                                int count = item['count'] is String
                                    ? int.parse(item['count'])
                                    : item['count'];
                                int price = item['book']['price'] is String
                                    ? double.parse(item['book']['price'])
                                        .toInt()
                                    : item['book']['price'];
                                int totalItemPrice = count * price;

                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${index + 1}',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        item['book']['title'],
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        '$count',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        '${formatCurrency.format(price)}',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        '${formatCurrency.format(totalItemPrice)}',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Obx(() {
                      double totalPrice =
                          cartController.cartItems.fold(0.0, (sum, item) {
                        int count = item['count'] is String
                            ? int.parse(item['count'])
                            : item['count'];
                        int price = item['book']['price'] is String
                            ? double.parse(item['book']['price']).toInt()
                            : item['book']['price'];
                        return sum + (count * price).toDouble();
                      });

                      return Text(
                        'Total Price: ${formatCurrency.format(totalPrice)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Upload Photo'),
              ),
              const SizedBox(height: 20),
              if (_image != null)
                Container(
                  margin: EdgeInsets.all(10.0),
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(
                      _image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _checkout,
                child: Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
