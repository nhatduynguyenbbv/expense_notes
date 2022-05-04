import 'package:expense_notes/src/models/transaction.dart';
import 'package:expense_notes/src/models/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TransactionModel>();
    final transactions = model.transactions.toList();
    transactions.sort((a, b) => a.date.compareTo(b.date));

    List<charts.Series<TransactionItem, String>> series = [
      charts.Series(
          id: "Transactions",
          data: transactions,
          domainFn: (TransactionItem item, _) =>
              '${item.date.month.toString()}/${item.date.year.toString()}',
          measureFn: (TransactionItem item, _) => item.cost,
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault)
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: transactions.isNotEmpty
          ? Column(
              children: <Widget>[
                Text(
                  "Transactions by Month",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Expanded(
                  child: charts.BarChart(series, animate: true),
                )
              ],
            )
          : const Center(
              child: Text('My Chart',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
    );
  }
}
