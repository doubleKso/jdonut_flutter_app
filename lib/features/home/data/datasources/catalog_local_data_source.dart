import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../models/catalog_dto.dart';

/// A section row with its products in display order (empty when none).
typedef SectionWithProducts = ({HomeSectionRow section, List<ProductRow> products});

/// Drift reads and writes for the public catalogue.
final class CatalogLocalDataSource {
  const CatalogLocalDataSource(this._db);

  final AppDatabase _db;

  Stream<List<BannerRow>> watchBanners() =>
      (_db.select(_db.banners)..orderBy([(b) => OrderingTerm.asc(b.sortOrder)])).watch();

  Stream<List<ShopRow>> watchShops() =>
      (_db.select(_db.shops)..orderBy([(s) => OrderingTerm.asc(s.sortOrder)])).watch();

  /// Sections with their products. A left join keeps a section that has no
  /// products, so the UI can show that section's own empty state.
  Stream<List<SectionWithProducts>> watchSections() {
    final query = _db.select(_db.homeSections).join([
      leftOuterJoin(_db.homeSectionItems, _db.homeSectionItems.sectionId.equalsExp(_db.homeSections.id)),
      leftOuterJoin(_db.products, _db.products.id.equalsExp(_db.homeSectionItems.productId)),
    ])
      ..orderBy([
        OrderingTerm.asc(_db.homeSections.sortOrder),
        OrderingTerm.asc(_db.homeSectionItems.sortOrder),
      ]);
    return query.watch().map(_groupBySection);
  }

  List<SectionWithProducts> _groupBySection(List<TypedResult> rows) {
    final sections = <String, SectionWithProducts>{};
    for (final row in rows) {
      final section = row.readTable(_db.homeSections);
      final entry = sections.putIfAbsent(section.id, () => (section: section, products: <ProductRow>[]));
      final product = row.readTableOrNull(_db.products);
      if (product != null) entry.products.add(product);
    }
    return sections.values.toList(growable: false);
  }

  /// Writes a whole catalogue in one transaction. Banners, sections and shops
  /// are replaced (the server is authoritative); products are upserted so a
  /// product still in someone's cart is never deleted.
  Future<void> writeCatalog(CatalogDto catalog) => _db.transaction(() async {
    await _db.batch((batch) {
      batch
        ..insertAllOnConflictUpdate(_db.products, catalog.products.map((p) => p.toCompanion()))
        ..deleteAll(_db.banners)
        ..deleteAll(_db.homeSectionItems)
        ..deleteAll(_db.homeSections)
        ..deleteAll(_db.shops)
        ..insertAll(_db.banners, catalog.banners.map((b) => b.toCompanion()))
        ..insertAll(_db.homeSections, catalog.sections.map((s) => s.toCompanion()))
        ..insertAll(_db.homeSectionItems, catalog.sections.expand((s) => s.itemCompanions()))
        ..insertAll(_db.shops, catalog.shops.map((s) => s.toCompanion()));
    });
  });
}
