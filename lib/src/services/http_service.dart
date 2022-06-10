import 'dart:convert';

import 'package:expense_notes/src/services/auth_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

import 'api_service.dart';

class HttpService implements ApiService {
  final String _dbUrl =
      FirebaseDatabase.instance.app.options.databaseURL.toString();
  final String path;
  late String api;
  final AuthService authService = AuthService();

  HttpService(this.path) {
    api = "$_dbUrl/$path";
  }

  @override
  Future<List<MapEntry<String, Object?>>> get() async {
    final token = await authService.getToken();
    var res = await http.get(Uri.parse("$api.json?auth=$token"));
    var data = json.decode(res.body) as Map<String, Object?>;
    return Future.value(data.entries.toList());
  }

  @override
  Future<Map<String, Object?>> getById(String id) async {
    final token = await authService.getToken();
    var res = await http.get(Uri.parse("$api/$id.json?auth=$token"));
    return Future.value(json.decode(res.body) as Map<String, Object?>);
  }

  @override
  Future<String> add(Object? data) async {
    final token = await authService.getToken();
    var res = await http.post(Uri.parse("$api.json?auth=$token"),
        body: json.encode(data));
    return Future.value(json.decode(res.body)["name"]);
  }

  @override
  Future<void> update(Object? data, String id) async {
    final token = await authService.getToken();
    await http.put(Uri.parse("$api/$id.json?auth=$token"),
        body: json.encode(data));
  }

  @override
  Future<void> remove(String id) async {
    final token = await authService.getToken();
    await http.delete(Uri.parse("$api/$id.json?auth=$token"));
  }
}
