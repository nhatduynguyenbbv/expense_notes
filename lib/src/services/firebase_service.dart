import 'dart:async';

import 'package:expense_notes/src/services/api_service.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService implements ApiService {
  final FirebaseDatabase _db = FirebaseDatabase.instance;
  final String path;
  late DatabaseReference ref;

  FirebaseService(this.path) {
    ref = _db.ref(path);
  }

  @override
  Future<List<MapEntry<String, Object?>>> get() async {
    var res = await ref.get();
    var data = res.children
        .map((e) => MapEntry<String, Object?>(e.key.toString(), e.value));

    return Future.value(data.toList());
  }

  @override
  Future<Map<String, Object?>> getById(String id) {
    return ref.child(id).get() as Future<Map<String, dynamic>>;
  }

  @override
  Future<void> remove(String id) {
    return ref.child(id).remove();
  }

  @override
  Future<String> add(Object? data) async {
    var docRef = ref.push();
    await docRef.set(data);

    return Future.value(docRef.key);
  }

  @override
  Future<void> update(dynamic data, String id) {
    return ref.child(id).update(data);
  }
}
