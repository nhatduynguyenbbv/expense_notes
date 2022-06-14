import 'package:expense_notes/src/models/theme_model.dart';
import 'package:expense_notes/src/screens/sign_in.dart';
import 'package:expense_notes/src/services/auth_service.dart';
import 'package:expense_notes/src/widgets/drawer/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  static const routeName = '/settings';

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final List<ThemeMode> themeModes = ThemeMode.values;
  final Map<ThemeMode, String> themeModeLabels = {
    ThemeMode.dark: 'Dark',
    ThemeMode.light: 'Light',
    ThemeMode.system: 'System'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expense Notes')),
      body: BlocBuilder<ThemeModel, ThemeMode>(builder: (_, mode) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ListTile(
              title: Text(
                'General Setting',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 8, right: 8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.light_outlined),
                              SizedBox(width: 8),
                              Text("Theme Mode"),
                            ],
                          ),
                          DropdownButton<ThemeMode>(
                            value: mode,
                            items: themeModes
                                .map((value) => DropdownMenuItem<ThemeMode>(
                                      value: value,
                                      child: Text(
                                          themeModeLabels[value].toString()),
                                    ))
                                .toList(),
                            onChanged: (ThemeMode? value) async {
                              await BlocProvider.of<ThemeModel>(context)
                                  .updateThemeMode(value);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text("Sign Out"),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () async {
                      await BlocProvider.of<AuthService>(context).signOut();
                    },
                  ),
                ],
              ),
            )
          ],
        );
      }),
      drawer: const AppDrawer(),
    );
  }
}
