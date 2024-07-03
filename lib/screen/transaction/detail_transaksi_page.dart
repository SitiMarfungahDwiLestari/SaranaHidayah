import 'package:flutter/material.dart';

class DetailTransaksiPage extends StatelessWidget {
  final int transactionId;

  const DetailTransaksiPage({Key? key, required this.transactionId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implement the UI to display transaction details based on transactionId
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Transaksi #$transactionId'),
      ),
      body: Center(
        child: Text('Transaction ID: $transactionId'), // Example content
      ),
    );
  }
}
