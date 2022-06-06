import 'package:expense_notes/src/models/app_model.dart';
import 'package:expense_notes/src/models/app_theme_data.dart';
import 'package:expense_notes/src/screens/sign_in.dart';
import 'package:expense_notes/src/screens/sign_up.dart';
import 'package:expense_notes/src/services/auth_service.dart';
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
        ChangeNotifierProvider(
          create: (context) => TransactionModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthService(),
        ),
      ],
      builder: (context, child) => FutureBuilder(
        future: context.read<ThemeModel>().loadThemeMode(),
        builder: (context, snapshot) =>
            Consumer2<AuthService, ThemeModel>(builder: (_, auth, theme, __) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Expense Notes',
              themeMode: theme.mode,
              theme: AppThemeData.lightTheme,
              darkTheme: AppThemeData.darkTheme,
              routes: {
                Settings.routeName: (context) => const Settings(),
                TransactionDetail.routeName: (context) =>
                    const TransactionDetail(),
                SignUp.routeName: (context) => const SignUp(),
              },
              home: auth.currentUser != null ? const Home() : const SignIn(),
            );
          }

          // Slash
          return Container(color: Colors.white);
        }),
      ),
    );
  }
}
