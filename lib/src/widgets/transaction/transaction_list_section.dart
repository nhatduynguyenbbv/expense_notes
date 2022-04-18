import 'package:expense_notes/src/widgets/transaction/transaction_list_view/transaction_list_view.dart';
import 'package:flutter/material.dart';

class TransactionListSection extends StatelessWidget {
  const TransactionListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.orange,
        padding: const EdgeInsets.all(16),
        child: const TransactionListView());
  }
}
