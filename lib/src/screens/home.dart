import 'package:expense_notes/src/utilizes/modal-bottom-sheet.dart';
import 'package:expense_notes/src/widgets/chart/chart_section.dart';
import 'package:expense_notes/src/widgets/drawer/app_drawer.dart';
import 'package:expense_notes/src/widgets/transaction/transaction_creation_form.dart';
import 'package:expense_notes/src/widgets/transaction/transaction_list_section.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expense Notes'), actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(textStyle: const TextStyle(fontSize: 18)),
          onPressed: () => _onButtonPressed(context),
          child: const Text('ADD', style: TextStyle(color: Colors.white)),
        ),
      ]),
      body: Column(children: const [
        Expanded(child: ChartSection(), flex: 1),
        Expanded(child: TransactionListSection(), flex: 2)
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onButtonPressed(context),
        child: const Icon(Icons.add),
      ),
      drawer: const AppDrawer(),
    );
  }

  Future _onButtonPressed(context) async {
    return showCustomModalBottomSheet(
      title: "Add Transaction",
      context: context,
      content: const TransactionCreationForm(),
    );
  }
}
