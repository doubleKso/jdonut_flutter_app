import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables.dart';

part 'app_database.g.dart';

/// The local database: the single source of truth the UI reads.
///
/// Schema history (each version's migration lives in [migration]):
///   1 — catalogue, home sections, shops, member, challenges, users, meta
///   2 — cart items (persistent cart)
@DriftDatabase(
  tables: [
    Products,
    Banners,
    HomeSections,
    HomeSectionItems,
    Shops,
    Members,
    Challenges,
    Users,
    AppMeta,
    CartItems,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openDefault());

  static const String fileName = 'jdonuts';

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) await m.createTable(cartItems);
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  static QueryExecutor _openDefault() => driftDatabase(name: fileName);
}
