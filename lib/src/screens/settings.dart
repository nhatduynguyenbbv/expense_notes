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
      body: Consumer<ThemeModel>(builder: (_, model, __) {
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
                  child: Row(
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
                        value: model.mode,
                        items: themeModes
                            .map((value) => DropdownMenuItem<ThemeMode>(
                                  value: value,
                                  child:
                                      Text(themeModeLabels[value].toString()),
                                ))
                            .toList(),
                        onChanged: (ThemeMode? value) async {
                          await model.updateThemeMode(value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
      drawer: const AppDrawer(),
    );
  }
}
