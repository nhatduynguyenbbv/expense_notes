import 'dart:async';

import 'package:expense_notes/src/services/localstorage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'localstorage_keys_const.dart';

class ThemeModel extends Cubit<ThemeMode> {
  final localStorage = LocalStorageService();
  late ThemeMode _mode = ThemeMode.system;

  get mode => _mode;

  ThemeModel() : super(ThemeMode.system);

  Future<void> updateThemeMode(ThemeMode? value) async {
    _mode = value ?? ThemeMode.system;
    emit(mode);
    await localStorage.setString(themeModeKey, value.toString());
  }

  Future<void> loadThemeMode() async {
    var value = await localStorage.getString(themeModeKey);
    _mode = value != null
        ? ThemeMode.values.firstWhere((element) => element.toString() == value)
        : ThemeMode.system;
    emit(mode);
  }
}
