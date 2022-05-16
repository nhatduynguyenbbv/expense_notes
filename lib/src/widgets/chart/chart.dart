import 'package:expense_notes/src/models/transaction.dart';
import 'package:expense_notes/src/models/transaction_data.dart';
import 'package:expense_notes/src/models/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TransactionModel>();
    final transactions = model.transactions.toList();
    transactions.sort((a, b) => a.date.compareTo(b.date));

    final transactionsByDays = _calculateTransactions(7, transactions);

    List<charts.Series<TransactionData, String>> series = [
      charts.Series(
          id: "Transactions",
          data: transactionsByDays,
          domainFn: (TransactionData item, _) =>
              DateFormat('EEE').format(item.date),
          measureFn: (TransactionData item, _) => item.cost,
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault)
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: transactions.isNotEmpty
          ? Column(
              children: <Widget>[
                Text(
                  "Transactions for the last 7 days",
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

  List<TransactionData> _calculateTransactions(
      int days, List<TransactionItem> transactions) {
    return transactions
        .fold({}, (previousValue, element) {
          Map val = previousValue as Map;
          String date = DateFormat('dd-MM-yyyy').format(element.date);
          if (!val.containsKey(date)) {
            val[date] = [];
          }
          val[date]?.add(element);
          return val;
        })
        .entries
        .map((entry) => TransactionData(
            DateFormat('dd-MM-yyyy').parse(entry.key),
            entry.value
                .map((e) => e.cost)
                .reduce((value, element) => value + element)))
        .take(days)
        .toList();
  }
}
