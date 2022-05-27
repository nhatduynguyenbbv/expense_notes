import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

import 'api_service.dart';

class HttpService implements ApiService {
  final String _dbUrl =
      FirebaseDatabase.instance.app.options.databaseURL.toString();
  final String path;
  late String api;

  HttpService(this.path) {
    api = "$_dbUrl/$path";
  }

  @override
  Future<Map<String, dynamic>> get() async {
    var res = await http.get(Uri.parse("$api.json"));
    return Future.value(json.decode(res.body) as Map<String, dynamic>);
  }

  @override
  Future<Map<String, dynamic>> getById(String id) async {
    var res = await http.get(Uri.parse("$api/$id.json"));
    return Future.value(json.decode(res.body) as Map<String, dynamic>);
  }

  @override
  Future<String> add(Object? data) async {
    var res = await http.post(Uri.parse("$api.json"), body: json.encode(data));
    return Future.value(json.decode(res.body)["name"]);
  }

  @override
  Future<void> update(Object? data, String id) async {
    await http.put(Uri.parse("$api/$id.json"), body: json.encode(data));
  }

  @override
  Future<void> remove(String id) async {
    await http.delete(Uri.parse("$api/$id.json"));
  }
}
