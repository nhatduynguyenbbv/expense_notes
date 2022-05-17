import 'package:expense_notes/src/models/transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionDetail extends StatelessWidget {
  final TransactionItem item;

  const TransactionDetail({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: Center(child: Text("This is ${item.name}")),
    );
  }
}
