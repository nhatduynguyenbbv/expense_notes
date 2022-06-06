import 'package:expense_notes/src/screens/home.dart';
import 'package:expense_notes/src/screens/settings.dart';
import 'package:expense_notes/src/services/auth_service.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;

    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: Text(
                'Hello, ${currentUser?.email}',
                style: const TextStyle(fontSize: 20, color: Colors.white),
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
                Navigator.pushReplacementNamed(context, Home.routeName);
              }),
          ListTile(
            title: const Align(
              alignment: Alignment.center,
              child: Text(
                'Settings',
                style: TextStyle(fontSize: 16),
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, Settings.routeName);
            },
          ),
        ],
      ),
    );
  }
}
