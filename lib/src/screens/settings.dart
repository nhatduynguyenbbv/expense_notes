import 'package:expense_notes/src/widgets/drawer/app_drawer.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expense Notes')),
      body: const Center(
        child: Text(
          'Settings here',
          style: TextStyle(fontSize: 24),
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
