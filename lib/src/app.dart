import 'package:expense_notes/src/models/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/theme_model.dart';
import 'models/transaction_model.dart';
import 'screens/home.dart';
import 'screens/settings.dart';
import 'screens/transaction_detail.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TransactionModel()),
          ChangeNotifierProvider(create: (context) => ThemeModel())
        ],
        child: Consumer<ThemeModel>(builder: (_, model, __) {
          return MaterialApp(
            title: 'Expense Notes',
            themeMode: model.mode,
            theme: AppThemeData.lightTheme,
            darkTheme: AppThemeData.darkTheme,
            routes: {
              Home.routeName: (context) => const Home(),
              Settings.routeName: (context) => const Settings(),
              TransactionDetail.routeName: (context) =>
                  const TransactionDetail()
            },
            home: const Home(),
          );
        }));
  }
}
