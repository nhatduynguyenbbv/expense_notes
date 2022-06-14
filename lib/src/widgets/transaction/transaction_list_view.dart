import 'package:expense_notes/src/models/app_model.dart';
import 'package:expense_notes/src/models/transaction_model.dart';
import 'package:expense_notes/src/models/transaction_item.dart';
import 'package:expense_notes/src/utilizes/modal-bottom-sheet.dart';
import 'package:expense_notes/src/widgets/transaction/transaction_creation_form.dart';
import 'package:expense_notes/src/widgets/transaction/transaction_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionListView extends StatelessWidget {
  const TransactionListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: BlocProvider.of<TransactionModel>(context).fetch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            BlocProvider.of<AppModel>(context).setLoading(false);
          } else {
            BlocProvider.of<AppModel>(context).setLoading(true);
          }

          return BlocBuilder<TransactionModel, List<TransactionItem>>(
            builder: (context, transactions) => Expanded(
              child: transactions.isNotEmpty
                  ? ListView(
                      children: transactions
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
            ),
          );
        });
  }

  Widget _transactionItemBuilder(BuildContext context, TransactionItem item) {
    return TransactionListItem(
        key: Key(item.id.toString()),
        item: item,
        onDelete: (item) async =>
            {await BlocProvider.of<TransactionModel>(context).remove(item)},
        onEdit: (item) => showCustomModalBottomSheet(
              title: "Edit Transaction",
              context: context,
              content: TransactionCreationForm(item: item),
            ));
  }
}
