import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future<String?> getString(key) async {
    Future<SharedPreferences> _preferences = SharedPreferences.getInstance();
    final SharedPreferences preferences = await _preferences;
    String? res = preferences.getString("$key");
    return res;
  }

  Future<Object?> getJson(key) async {
    Future<SharedPreferences> _preferences = SharedPreferences.getInstance();
    final SharedPreferences preferences = await _preferences;

    String? jsonString = preferences.getString("$key");
    var res = jsonString != null ? jsonDecode(jsonString) : null;

    return res;
  }

  Future<bool> setJson(key, Object value) async {
    Future<SharedPreferences> _preferences = SharedPreferences.getInstance();
    final SharedPreferences preferences = await _preferences;
    var valString = jsonEncode(value);
    return preferences.setString("$key", valString);
  }

  Future<bool> setString(key, String val) async {
    Future<SharedPreferences> _preferences = SharedPreferences.getInstance();
    final SharedPreferences preferences = await _preferences;
    var res = preferences.setString("$key", val);
    return res;
  }

  Future clear() async {
    Future<SharedPreferences> _preferences = SharedPreferences.getInstance();
    final SharedPreferences preferences = await _preferences;
    preferences.clear();
  }
}
