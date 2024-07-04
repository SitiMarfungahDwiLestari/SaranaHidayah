import 'package:get/get.dart';
import 'package:sarana_hidayah/model/transaction.dart';
import 'package:sarana_hidayah/service/transaction_sevice.dart';

class TransactionController extends GetxController {
  final TransactionService transactionService = TransactionService();

  var transactions = <Transaction>[].obs;
  var transaction = Transaction().obs;

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    try {
      List<dynamic> transactionData =
          await transactionService.fetchTransactions();
      print('Fetched transactions: $transactionData');
      List<Transaction> transactionList =
          transactionData.map((json) => Transaction.fromMap(json)).toList();
      transactions.value = transactionList;
      print('Transaction list: $transactionList');
    } catch (e) {
      print('Error fetching transactions: $e');
      throw Exception('Failed to fetch transactions');
    }
  }

  Future<void> fetchTransactionById(int id) async {
    try {
      var transactionData = await transactionService.fetchTransactionById(id);
      transaction.value = Transaction.fromMap(transactionData);
    } catch (e) {
      print(e);
      throw Exception('Failed to fetch transaction');
    }
  }

  Future<void> createTransaction(String paymentProofPath) async {
    try {
      await transactionService.createTransaction(paymentProofPath);
      await fetchTransactions();
    } catch (e) {
      print(e);
      throw Exception('Failed to create transaction');
    }
  }

  Future<void> updateTransaction(int id, String trackingNumber) async {
    try {
      await transactionService.updateTransaction(id, trackingNumber);
      await fetchTransactions();
    } catch (e) {
      print(e);
      throw Exception('Failed to update transaction');
    }
  }

  Future<void> deleteTransaction(int id) async {
    try {
      await transactionService.deleteTransaction(id);
      await fetchTransactions();
    } catch (e) {
      print(e);
      throw Exception('Failed to delete transaction');
    }
  }
}
