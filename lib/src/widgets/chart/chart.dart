import 'package:expense_notes/src/models/transaction.dart';
import 'package:expense_notes/src/models/transaction_data.dart';
import 'package:expense_notes/src/models/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TransactionModel>();
    final weekDays = [
      DateFormat("EEE").format(DateTime.now().add(const Duration(days: -6))),
      DateFormat("EEE").format(DateTime.now().add(const Duration(days: -5))),
      DateFormat("EEE").format(DateTime.now().add(const Duration(days: -4))),
      DateFormat("EEE").format(DateTime.now().add(const Duration(days: -3))),
      DateFormat("EEE").format(DateTime.now().add(const Duration(days: -2))),
      DateFormat("EEE").format(DateTime.now().add(const Duration(days: -1))),
      DateFormat("EEE").format(DateTime.now()),
    ];
    final transactionsByDays =
        _groupTransactionsByDate(model.transactions.toList());

    final barGroups = weekDays.map((day) {
      var trans = transactionsByDays
          .where((tran) => day == DateFormat("EEE").format(tran.date));

      return BarChartGroupData(
          x: trans.isEmpty
              ? weekDays.indexOf(day)
              : weekDays.indexOf(DateFormat("EEE").format(trans.first.date)),
          barRods: [
            BarChartRodData(
                toY: trans.isEmpty ? 0 : trans.first.cost.toDouble(),
                width: 10,
                color: Colors.amber)
          ]);
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: model.transactions.toList().isNotEmpty
          ? Column(
              children: <Widget>[
                Text(
                  "Transactions for the last 7 days",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BarChart(
                      BarChartData(
                        borderData: FlBorderData(
                          show: false,
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (double value, TitleMeta meta) =>
                                  Text(
                                weekDays[value.toInt()],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (double value, TitleMeta meta) =>
                                Text(
                              "\$${value.toString()}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          )),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        barGroups: barGroups,
                        gridData: FlGridData(show: false),
                        alignment: BarChartAlignment.spaceAround,
                      ),
                    ),
                  ),
                )
              ],
            )
          : const Center(
              child: Text('My Chart',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
    );
  }

  List<TransactionData> _groupTransactionsByDate(
      List<TransactionItem> transactions) {
    const dateFormat = 'dd-MM-yyyy';

    return transactions
        .where((element) =>
            element.date
                .compareTo(DateTime.now().add(const Duration(days: -7))) >
            0)
        .fold({}, (previousValue, element) {
          Map val = previousValue as Map;
          String date = DateFormat(dateFormat).format(element.date);
          if (!val.containsKey(date)) {
            val[date] = [];
          }
          val[date]?.add(element);
          return val;
        })
        .entries
        .map((entry) => TransactionData(
            DateFormat(dateFormat).parse(entry.key),
            entry.value
                .map((e) => e.cost)
                .reduce((value, element) => value + element)))
        .toList();
  }
}
