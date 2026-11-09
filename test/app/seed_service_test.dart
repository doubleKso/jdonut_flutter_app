import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/app/bootstrap/seed_service.dart';
import 'package:jdonuts/core/database/app_database.dart';
import 'package:jdonuts/features/home/data/datasources/catalog_local_data_source.dart';
import 'package:jdonuts/features/member/data/member_local_data_source.dart';

import '../support/test_database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late SeedService seed;

  setUp(() {
    db = newTestDatabase();
    seed = SeedService(
      db: db,
      bundle: rootBundle,
      catalogLocal: CatalogLocalDataSource(db),
      memberLocal: MemberLocalDataSource(db),
    );
  });

  tearDown(() => db.close());

  test('first launch imports the bundled catalogue, member and challenges', () async {
    await seed.seedIfNeeded();

    expect(await db.select(db.products).get(), hasLength(13));
    expect(await db.select(db.banners).get(), hasLength(3));
    expect(await db.select(db.homeSections).get(), hasLength(3));
    expect(await db.select(db.shops).get(), hasLength(4));
    expect((await db.select(db.members).getSingle()).totalPoints, 680000);
    expect(await db.select(db.challenges).get(), hasLength(6));
  });

  test('a second launch does not import again', () async {
    await seed.seedIfNeeded();
    await (db.delete(db.shops)..where((s) => s.id.equals('s_bahan'))).go();

    await seed.seedIfNeeded();

    expect(await db.select(db.shops).get(), hasLength(3));
  });

  test('home sections keep their products in display order', () async {
    await seed.seedIfNeeded();

    final sections = await CatalogLocalDataSource(db).watchSections().first;
    final popular = sections.firstWhere((s) => s.section.id == 'popular');

    expect(popular.products.map((p) => p.id), [
      'p_strawberry_choc',
      'p_dalgona',
      'p_coconut',
      'p_grape',
      'p_matcha',
    ]);
  });
}
