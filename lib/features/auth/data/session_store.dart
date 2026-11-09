import 'dart:async';
import 'dart:convert';

import 'package:app_storage/app_storage.dart';

import '../domain/entities/auth_entities.dart';

/// Keeps the signed-in session in secure storage and announces changes.
final class SessionStore {
  SessionStore(this._storage);

  static const String storageKey = 'auth_session';

  final SecureStorageService _storage;
  final StreamController<AuthSession?> _changes = StreamController<AuthSession?>.broadcast();

  Stream<AuthSession?> get changes => _changes.stream;

  Future<AuthSession?> read() async {
    final raw = await _storage.read(storageKey);
    if (raw == null) return null;
    try {
      return _decode(jsonDecode(raw) as Map<String, dynamic>);
    } on FormatException {
      await _storage.delete(storageKey);
      return null;
    }
  }

  Future<void> save(AuthSession session) async {
    await _storage.write(storageKey, jsonEncode(_encode(session)));
    _changes.add(session);
  }

  Future<void> clear() async {
    await _storage.delete(storageKey);
    _changes.add(null);
  }

  static Map<String, Object> _encode(AuthSession s) => {
    'phone': s.phone,
    'displayName': s.displayName,
    'token': s.token,
    'createdAt': s.createdAt.toIso8601String(),
  };

  static AuthSession _decode(Map<String, dynamic> json) => AuthSession(
    phone: json['phone'] as String,
    displayName: json['displayName'] as String? ?? '',
    token: json['token'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
  );
}
