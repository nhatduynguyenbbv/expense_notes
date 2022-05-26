import 'package:expense_notes/src/models/theme_model.dart';
import 'package:expense_notes/src/widgets/drawer/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  static const routeName = '/settings';

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late bool _darkMode;

  @override
  Widget build(BuildContext context) {
    _darkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Expense Notes')),
      body: Consumer<ThemeModel>(builder: (_, model, __) {
        return Center(
          child: SwitchListTile(
            title: const Text('Dark Mode'),
            secondary: const Icon(Icons.lightbulb_outline),
            onChanged: (bool value) {
              context.read<ThemeModel>().toggleMode();
            },
            value: model.mode == ThemeMode.system && _darkMode
                ? true
                : model.mode == ThemeMode.dark,
          ),
        );
      }),
      drawer: const AppDrawer(),
    );
  }
}
