import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

import 'api_service.dart';

class HttpService implements ApiService {
  final String _dbUrl =
      FirebaseDatabase.instance.app.options.databaseURL.toString();
  final String path;
  late String api;
  final String token = '';

  HttpService(this.path) {
    api = "$_dbUrl/$path";
  }

  @override
  Future<List<MapEntry<String, Object?>>> get() async {
    var res = await http.get(Uri.parse("$api.json"), headers: _setHeaders());
    var data = json.decode(res.body) as Map<String, Object?>;
    return Future.value(data.entries.toList());
  }

  @override
  Future<Map<String, Object?>> getById(String id) async {
    var res =
        await http.get(Uri.parse("$api/$id.json"), headers: _setHeaders());
    return Future.value(json.decode(res.body) as Map<String, Object?>);
  }

  @override
  Future<String> add(Object? data) async {
    var res = await http.post(Uri.parse("$api.json"),
        body: json.encode(data), headers: _setHeaders());
    return Future.value(json.decode(res.body)["name"]);
  }

  @override
  Future<void> update(Object? data, String id) async {
    await http.put(Uri.parse("$api/$id.json"),
        body: json.encode(data), headers: _setHeaders());
  }

  @override
  Future<void> remove(String id) async {
    await http.delete(Uri.parse("$api/$id.json"), headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
}
