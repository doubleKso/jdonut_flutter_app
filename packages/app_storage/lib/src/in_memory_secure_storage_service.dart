import 'secure_storage_service.dart';

/// [SecureStorageService] kept in memory — for tests and previews.
final class InMemorySecureStorageService implements SecureStorageService {
  final Map<String, String> _values = {};

  @override
  Future<String?> read(String key) async => _values[key];

  @override
  Future<void> write(String key, String value) async => _values[key] = value;

  @override
  Future<void> delete(String key) async => _values.remove(key);
}
