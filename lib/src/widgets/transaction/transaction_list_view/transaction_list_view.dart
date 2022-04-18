import 'package:expense_notes/src/models/transaction_item.dart';
import 'package:expense_notes/src/widgets/transaction/transaction_list_view/transaction_list_item.dart';
import 'package:flutter/material.dart';

class TransactionListView extends StatelessWidget {
  const TransactionListView(
      {Key? key,
      this.items = const [
        TransactionItem(100, 'Buy new shoe'),
        TransactionItem(110, 'Spend Electric Bill'),
        TransactionItem(5, 'Breakfast'),
        TransactionItem(10, 'Music'),
        TransactionItem(57, 'Taxi'),
        TransactionItem(100, 'Buy new shoe'),
        TransactionItem(110, 'Spend Electric Bill'),
        TransactionItem(5, 'Breakfast'),
        TransactionItem(10, 'Music'),
        TransactionItem(57, 'Taxi'),
        TransactionItem(100, 'Buy new shoe'),
        TransactionItem(110, 'Spend Electric Bill'),
        TransactionItem(5, 'Breakfast'),
        TransactionItem(10, 'Music'),
        TransactionItem(57, 'Taxi')
      ]})
      : super(key: key);

  final List<TransactionItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Align(
        alignment: Alignment.centerLeft,
        child: Text('Transaction List',
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      Expanded(
        flex: 1,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) =>
                _transactionItemBuilder(items, index)),
      )
    ]);
  }

  Widget _transactionItemBuilder(List<TransactionItem> items, int index) {
    final item = items[index];
    return TransactionListItem(item: item);
  }
}
