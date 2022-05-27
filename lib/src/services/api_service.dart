import 'package:firebase_database/firebase_database.dart';

class ApiService {
  final FirebaseDatabase _db = FirebaseDatabase.instance;
  final String path;
  late DatabaseReference ref;

  ApiService(this.path) {
    ref = _db.ref(path);
  }

  Future<DataSnapshot> get() {
    return ref.get();
  }

  Stream<DatabaseEvent> stream() {
    return ref.onValue;
  }

  Future<DataSnapshot> getById(String id) {
    return ref.child(id).get();
  }

  Future<void> remove(String id) {
    return ref.child(id).remove();
  }

  Future<String> add(Object? data) async {
    var docRef = ref.push();
    await docRef.set(data);

    return Future.value(docRef.key);
  }

  Future<void> update(dynamic data, String id) {
    return ref.child(id).update(data);
  }
}
