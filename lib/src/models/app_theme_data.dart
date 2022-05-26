import 'package:flutter/material.dart';

class AppThemeData {
  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.purpleAccent,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.purpleAccent),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.purpleAccent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Colors.purpleAccent,
        onPrimary: Colors.black,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: Colors.purple,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: Colors.purple),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.purple,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Colors.purple,
        onPrimary: Colors.black,
      ),
    ),
  );
}
