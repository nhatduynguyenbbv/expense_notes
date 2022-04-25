import 'package:expense_notes/src/models/transaction.dart';
import 'package:expense_notes/src/models/transaction_item.dart';
import 'package:expense_notes/src/widgets/transaction/transaction_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionListView extends StatelessWidget {
  const TransactionListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TransactionModel>();
    return Expanded(
      child: model.transactions.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: model.transactions.length,
              itemBuilder: (BuildContext context, int index) =>
                  _transactionItemBuilder(context, model.transactions, index))
          : const Center(
              child: Text('No transactions added yet!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.grey))),
    );
  }

  Widget _transactionItemBuilder(
      BuildContext context, List<TransactionItem> items, int index) {
    final item = items[index];
    return TransactionListItem(
        key: ObjectKey(item),
        item: item,
        onDelete: (item) => {context.read<TransactionModel>().remove(item)});
  }
}
