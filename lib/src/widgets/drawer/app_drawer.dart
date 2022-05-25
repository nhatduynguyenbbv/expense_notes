import 'package:expense_notes/src/screens/home.dart';
import 'package:expense_notes/src/screens/settings.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        const SizedBox(
          height: 120,
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.purple,
            ),
            child: Center(
              child: Text(
                'Expense Notes',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
        ListTile(
          title: const Align(
            alignment: Alignment.center,
            child: Text(
              'Home',
              style: TextStyle(fontSize: 16),
            ),
          ),
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const Home()));
          },
        ),
        ListTile(
          title: const Align(
            alignment: Alignment.center,
            child: Text(
              'Settings',
              style: TextStyle(fontSize: 16),
            ),
          ),
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const Settings()));
          },
        ),
      ]),
    );
  }
}
