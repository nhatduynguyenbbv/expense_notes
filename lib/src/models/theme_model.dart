import 'dart:async';

import 'package:expense_notes/src/services/localstorage_service.dart';
import 'package:flutter/material.dart';

import 'localstorage_keys_const.dart';

class ThemeModel with ChangeNotifier {
  final localStorage = LocalStorageService();
  late ThemeMode _mode;
  ThemeMode get mode => _mode;
  ThemeModel({ThemeMode mode = ThemeMode.system}) : _mode = mode;

  Future<void> updateThemeMode(ThemeMode? value) async {
    _mode = value ?? ThemeMode.system;

    notifyListeners();
    await localStorage.setString(themeModeKey, value.toString());
  }

  Future<void> loadThemeMode() async {
    var localStorage = LocalStorageService();
    var value = await localStorage.getString(themeModeKey);
    _mode = value != null
        ? ThemeMode.values.firstWhere((element) => element.toString() == value)
        : ThemeMode.system;
    notifyListeners();
  }
}
