import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarana_hidayah/controller/auth_controller.dart';
import 'package:sarana_hidayah/controller/transaction_controller.dart';

class DetailTransaksiPage extends StatelessWidget {
  final int transactionId;

  const DetailTransaksiPage({Key? key, required this.transactionId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController _authController = Get.find<AuthController>();
    final TransactionController _transactionController =
        Get.find<TransactionController>();

    // Fetch the transaction details
    _transactionController.fetchTransactionById(transactionId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Transaksi'),
      ),
      body: Center(
        child: Obx(() {
          if (_transactionController.transaction.value.id == null) {
            return CircularProgressIndicator();
          } else {
            return Container(
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
                  Text(
                      'No HP: ${_authController.user.value.phoneNumber ?? ''}'),
                  Text('Email: ${_authController.user.value.email}'),
                  SizedBox(height: 20),
                  // Display transaction details
                  Text(
                      'Total Price: ${_transactionController.transaction.value.totalPrice}'),
                  // Text('Order Status: ${_transactionController.transaction.value.orderStatus ? "Completed" : "Pending"}'),
                  Text(
                      'Tracking Number: ${_transactionController.transaction.value.trackingNumber ?? "N/A"}'),
                  Text(
                      'Payment Proof: ${_transactionController.transaction.value.paymentProof ?? "N/A"}'),
                  SizedBox(height: 20),
                  Text('Items:'),
                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: _transactionController
                  //             .transaction.value.items?.length ??
                  //         0,
                  //     itemBuilder: (context, index) {
                  //       var item = _transactionController
                  //           .transaction.value.items![index];
                  //       return ListTile(
                  //         title: Text('${item.bookTitle} (x${item.count})'),
                  //         subtitle: Text('Price: ${item.bookPrice}'),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
