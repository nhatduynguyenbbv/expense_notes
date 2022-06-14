import 'package:expense_notes/src/models/app_model.dart';
import 'package:expense_notes/src/models/app_theme_data.dart';
import 'package:expense_notes/src/screens/sign_in.dart';
import 'package:expense_notes/src/screens/sign_up.dart';
import 'package:expense_notes/src/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'models/theme_model.dart';
import 'models/transaction_model.dart';
import 'screens/home.dart';
import 'screens/settings.dart';
import 'screens/transaction_detail.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => TransactionModel(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => AppModel(false),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => ThemeModel(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => AuthService(),
        ),
      ],
      child: BlocBuilder<AuthService, User?>(
        builder: (context, user) {
          return FutureBuilder(
            future: BlocProvider.of<ThemeModel>(context).loadThemeMode(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return MaterialApp(
                  title: 'Expense Notes',
                  themeMode:
                      BlocProvider.of<ThemeModel>(context, listen: true).mode,
                  theme: AppThemeData.lightTheme,
                  darkTheme: AppThemeData.darkTheme,
                  routes: {
                    Settings.routeName: (context) => const Settings(),
                    TransactionDetail.routeName: (context) =>
                        const TransactionDetail(),
                    SignUp.routeName: (context) => const SignUp(),
                  },
                  home:
                      BlocProvider.of<AuthService>(context).currentUser != null
                          ? const Home()
                          : const SignIn(),
                );
              }

              // Slash
              return Container(color: Colors.white);
            },
          );
        },
      ),
    );
  }
}
