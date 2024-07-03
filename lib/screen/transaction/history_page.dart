import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sarana_hidayah/controller/auth_controller.dart';
import 'package:sarana_hidayah/screen/transaction/detail_transaksi_page.dart';
import 'package:sarana_hidayah/service/transaction_sevice.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final AuthController _authController = AuthController();
  final TransactionService _transactionService = TransactionService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History Transaksi"),
      ),
      body: Container(
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
        child: FutureBuilder(
          future: _transactionService.fetchTransactions(),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No transactions found.'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  var transaction = snapshot.data![index];
                  bool orderStatus = transaction['order_status'];

                  // Parse and format the created_at date
                  DateTime createdAt =
                      DateTime.parse(transaction['created_at']);
                  String formattedDate =
                      DateFormat('dd-MM-yyyy').format(createdAt);

                  return GestureDetector(
                    onTap: () {
                      Get.to(DetailTransaksiPage(transactionId: transaction['id']));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tanggal: $formattedDate'),
                                SizedBox(height: 5),
                                Text(orderStatus
                                    ? 'Status: Pesanan Diterima'
                                    : 'Status: Menunggu Konfirmasi'),
                                SizedBox(height: 5),
                                Text('Total Price: ${transaction['total_price']}'),
                                SizedBox(height: 5),
                                Text('Nomor Resi: ${transaction['tracking_number'] ?? "-"}'),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: orderStatus
                                ? null
                                : () async {
                                    try {
                                      await _transactionService.updateOrderStatus(
                                          transaction['id'],
                                          '12345678'); // Example tracking number
                                      setState(() {
                                        transaction['order_status'] = true;
                                      });
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            'Failed to update order status: $e'),
                                      ));
                                    }
                                  },
                            child: Text(orderStatus ? 'Diterima' : 'Pesanan Diterima'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
