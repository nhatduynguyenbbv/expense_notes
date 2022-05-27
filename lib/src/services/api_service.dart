abstract class ApiService {
  Future<Map<String, dynamic>> get();

  Future<Map<String, dynamic>> getById(String id);

  Future<String> add(Object? data);

  Future<void> update(Object? data, String id);

  Future<void> remove(String id);
}
