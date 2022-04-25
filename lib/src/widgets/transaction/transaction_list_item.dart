import 'dart:developer' as dev;
import 'dart:math';
import 'package:expense_notes/src/models/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem(
      {Key? key, required this.item, required this.onDelete})
      : super(key: key);

  final TransactionItem item;

  final void Function(TransactionItem item) onDelete;

  @override
  Widget build(BuildContext context) {
    final randomColor = _randomColor() ?? Colors.red;
    dev.log('reloading' + item.name);

    return Card(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: randomColor, width: 2)),
                  child: Text('\$${item.cost.toString()}',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: randomColor)),
                ),
                Container(
                  height: 48,
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(DateFormat('MMM d, yyyy').format(item.date),
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey))
                    ],
                  ),
                )
              ],
            ),
          ),
          IconButton(
            onPressed: () => onDelete(item),
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
    ));
  }

  Color? _randomColor() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)]
        [Random().nextInt(9) * 100];
  }
}
