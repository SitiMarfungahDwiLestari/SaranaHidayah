import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sarana_hidayah/controller/auth_controller.dart';
import 'package:sarana_hidayah/controller/cart_controller.dart';

class DetailTransaksiPage extends StatelessWidget {
  final int transactionId;

  const DetailTransaksiPage({Key? key, required this.transactionId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController _authController = Get.find<AuthController>();
    final CartController cartController = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Transaksi'),
      ),
      body: Center(
        child: Container(
          height: 350,
          width: 1000,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Transaction ID: $transactionId'),
              SizedBox(height: 20),
              // Display user information
              Text('Nama: ${_authController.user.value.name}'),
              Text('Alamat: ${_authController.user.value.address ?? ''}'),
              Text('No HP: ${_authController.user.value.phoneNumber ?? ''}'),
              Text('Email: ${_authController.user.value.email}'),
              SizedBox(height: 20),
              // Display transaction details
              // Replace with your transaction details UI
              Text('Transaction Details Placeholder'),
            ],
          ),
        ),
      ),
    );
  }
}
