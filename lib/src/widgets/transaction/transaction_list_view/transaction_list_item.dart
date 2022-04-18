import 'package:expense_notes/src/models/transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({Key? key, required this.item}) : super(key: key);

  final TransactionItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('\$${item.cost.toString()}',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(item.name)
        ],
      ),
    ));
  }
}
