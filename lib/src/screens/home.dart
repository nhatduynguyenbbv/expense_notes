import 'package:expense_notes/src/widgets/chart/chart_section.dart';
import 'package:expense_notes/src/widgets/transaction/transaction_list_section.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expense Notes')),
      body: ListView(
        children: const [ChartSection(), TransactionListSection()],
      ),
    );
  }
}
