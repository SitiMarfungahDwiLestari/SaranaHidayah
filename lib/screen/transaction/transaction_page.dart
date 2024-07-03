import 'package:flutter/material.dart';
import 'package:sarana_hidayah/widgets/drawer_widget.dart';
import 'package:sarana_hidayah/widgets/header_widget.dart';

class TransactionPage extends StatefulWidget {
  final bool isAdmin;

  const TransactionPage({super.key, required this.isAdmin});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderWidget(title: 'Transaction', isAdmin: widget.isAdmin),
      drawer: DrawerWidget(isAdmin: widget.isAdmin),
    );
  }
}
