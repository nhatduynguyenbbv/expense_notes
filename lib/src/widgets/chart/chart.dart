import 'package:expense_notes/src/models/transaction_model.dart';
import 'package:expense_notes/src/models/transaction_data.dart';
import 'package:expense_notes/src/models/transaction_item.dart';
import 'package:expense_notes/src/utilizes/date.util.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = BlocProvider.of<TransactionModel>(context, listen: true);
    final today = DateTime.now();
    final weekDays = [
      today.add(const Duration(days: -6)).toDateString("EEE"),
      today.add(const Duration(days: -5)).toDateString("EEE"),
      today.add(const Duration(days: -4)).toDateString("EEE"),
      today.add(const Duration(days: -3)).toDateString("EEE"),
      today.add(const Duration(days: -2)).toDateString("EEE"),
      today.add(const Duration(days: -1)).toDateString("EEE"),
      today.toDateString("EEE")
    ];
    final transactionsByDays =
        _groupTransactionsByDate(model.transactions.toList());

    final barGroups = weekDays.map((day) {
      var tranIdx = transactionsByDays
          .indexWhere((tran) => day == tran.date.toDateString("EEE"));

      return BarChartGroupData(
          x: tranIdx < 0
              ? weekDays.indexOf(day)
              : weekDays.indexOf(
                  transactionsByDays[tranIdx].date.toDateString("EEE")),
          barRods: [
            BarChartRodData(
                toY: tranIdx < 0
                    ? 0.toDouble()
                    : transactionsByDays[tranIdx].cost.toDouble(),
                width: 10,
                color: Colors.amber)
          ]);
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: model.transactions.isNotEmpty
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
                            showTitles:
                                transactionsByDays.isEmpty ? false : true,
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
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black)),
            ),
    );
  }

  List<TransactionData> _groupTransactionsByDate(
      List<TransactionItem> transactions) {
    const dateFormat = 'dd-MM-yyyy';
    const lastDays = -7;

    return transactions
        .where((element) =>
            element.date
                .compareTo(DateTime.now().add(const Duration(days: lastDays))) >
            0)
        .fold({}, (previousValue, element) {
          Map val = previousValue as Map;
          String date = element.date.toDateString(dateFormat);
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
