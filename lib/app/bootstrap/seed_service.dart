import 'package:flutter/services.dart';

import '../../core/database/app_database.dart';
import '../../features/home/data/datasources/catalog_local_data_source.dart';
import '../../features/home/data/datasources/catalog_seed_data_source.dart';
import '../../features/member/data/member_local_data_source.dart';

/// Imports the bundled JSON into the database on first launch, so the app
/// works fully offline from the very first open.
///
/// Bump [seedVersion] when the bundled data changes; the next launch then
/// re-imports it (the server's newer data still wins on the next refresh).
final class SeedService {
  SeedService({
    required this._db,
    required this._bundle,
    required this._catalogLocal,
    required this._memberLocal,
  });

  static const int seedVersion = 1;
  static const String versionKey = 'seed_version';

  final AppDatabase _db;
  final AssetBundle _bundle;
  final CatalogLocalDataSource _catalogLocal;
  final MemberLocalDataSource _memberLocal;

  Future<void> seedIfNeeded() async {
    if (await _importedVersion() >= seedVersion) return;
    final catalog = await CatalogSeedDataSource(_bundle).load();
    final member = await MemberLocalDataSource.loadSeed(_bundle);
    await _db.transaction(() async {
      await _catalogLocal.writeCatalog(catalog);
      await _memberLocal.writeSeed(member);
      await _db.into(_db.appMeta).insertOnConflictUpdate(
        AppMetaCompanion.insert(key: versionKey, value: '$seedVersion'),
      );
    });
  }

  Future<int> _importedVersion() async {
    final row = await (_db.select(_db.appMeta)..where((m) => m.key.equals(versionKey)))
        .getSingleOrNull();
    return int.tryParse(row?.value ?? '') ?? 0;
  }
}
