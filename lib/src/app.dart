import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/transaction.dart';
import 'screens/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TransactionModel())
      ],
      child: MaterialApp(
          title: 'Expense Notes',
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          home: const Home()),
    );
  }
}
