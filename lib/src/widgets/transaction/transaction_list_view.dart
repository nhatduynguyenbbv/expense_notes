import 'package:expense_notes/src/models/app_model.dart';
import 'package:expense_notes/src/models/transaction_model.dart';
import 'package:expense_notes/src/models/transaction_item.dart';
import 'package:expense_notes/src/utilizes/modal-bottom-sheet.dart';
import 'package:expense_notes/src/widgets/transaction/transaction_creation_form.dart';
import 'package:expense_notes/src/widgets/transaction/transaction_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionListView extends StatelessWidget {
  const TransactionListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AppModel>().setLoading(true);
    return FutureBuilder<void>(
        future: context.read<TransactionModel>().fetch(),
        builder: (context, snapshot) {
          final model = context.watch<TransactionModel>();
          context.read<AppModel>().setLoading(false);

          return Expanded(
            child: model.transactions.isNotEmpty
                ? ListView(
                    children: model.transactions
                        .map((transaction) =>
                            _transactionItemBuilder(context, transaction))
                        .toList())
                : const Center(
                    child: Text(
                      'No transactions added yet!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey),
                    ),
                  ),
          );
        });
  }

  Widget _transactionItemBuilder(BuildContext context, TransactionItem item) {
    return TransactionListItem(
        key: ObjectKey(item),
        item: item,
        onDelete: (item) async =>
            {await context.read<TransactionModel>().remove(item)},
        onEdit: (item) => showCustomModalBottomSheet(
              title: "Edit Transaction",
              context: context,
              content: TransactionCreationForm(item: item),
            ));
  }
}
