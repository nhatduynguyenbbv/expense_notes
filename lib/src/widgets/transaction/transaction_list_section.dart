import 'package:expense_notes/src/widgets/transaction/transaction_list_view.dart';
import 'package:flutter/material.dart';

class TransactionListSection extends StatelessWidget {
  const TransactionListSection({Key? key, String? name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Transaction List',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
            ),
            TransactionListView()
          ],
        ));
  }
}
