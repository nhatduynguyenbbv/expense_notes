import 'package:expense_notes/src/services/firebase_service.dart';
import 'package:expense_notes/src/services/http_service.dart';

enum DataProvider { http, firebase }

abstract class ApiService {
  factory ApiService(DataProvider? type, String path) {
    switch (type) {
      case DataProvider.firebase:
        return FirebaseService(path);
      case DataProvider.http:
        return HttpService(path);
      default:
        return HttpService(path);
    }
  }

  Future<List<MapEntry<String, Object?>>> get();

  Future<Map<String, Object?>> getById(String id);

  Future<String> add(Object? data);

  Future<void> update(Object? data, String id);

  Future<void> remove(String id);
}
