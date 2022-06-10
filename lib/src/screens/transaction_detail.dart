import 'package:expense_notes/src/models/transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionDetail extends StatelessWidget {
  static const routeName = '/transaction-detail';

  const TransactionDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as TransactionItem;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: Center(child: Text("This is ${item.name}")),
    );
  }
}
