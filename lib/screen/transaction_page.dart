import 'package:flutter/material.dart';
import 'package:sarana_hidayah/widgets/drawer_widget.dart';
import 'package:sarana_hidayah/widgets/header_widget.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HeaderWidget(title: 'Transaction'),
      drawer: DrawerWidget(),
    );
  }
}
