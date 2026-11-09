import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';

/// Accounts the fake auth repository has created, in the local database.
final class UserLocalDataSource {
  const UserLocalDataSource(this._db);

  final AppDatabase _db;

  Future<UserRow?> find(String phone) =>
      (_db.select(_db.users)..where((u) => u.phone.equals(phone))).getSingleOrNull();

  /// True when [phone] finished registering.
  Future<bool> isRegistered(String phone) async => (await find(phone))?.isComplete ?? false;

  Future<void> saveName(String phone, String firstName, String? lastName) =>
      _db.into(_db.users).insert(
        UsersCompanion.insert(
          phone: phone,
          firstName: Value(firstName),
          lastName: Value(lastName),
          createdAt: DateTime.now(),
        ),
        onConflict: DoUpdate(
          (_) => UsersCompanion(firstName: Value(firstName), lastName: Value(lastName)),
        ),
      );

  Future<void> complete(String phone, DateTime dateOfBirth) =>
      (_db.update(_db.users)..where((u) => u.phone.equals(phone))).write(
        UsersCompanion(dateOfBirth: Value(dateOfBirth), isComplete: const Value(true)),
      );
}
