import 'package:flutter/material.dart';

class AppThemeData {
  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.purpleAccent,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Colors.purpleAccent,
      onPrimary: Colors.white,
      onSurface: Colors.black,
    ),
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
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.purpleAccent),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: Colors.purple,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(
      primary: Colors.purple,
      onPrimary: Colors.white,
      onSurface: Colors.black,
    ),
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
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.purple),
      ),
    ),
  );
}
