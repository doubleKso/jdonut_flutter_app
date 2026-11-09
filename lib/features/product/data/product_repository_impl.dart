import '../../../core/database/app_database.dart';
import '../domain/entities/product.dart';
import '../domain/repositories/product_repository.dart';
import 'product_mapper.dart';

/// Reads products from the local database only — offline by construction.
final class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl(this._db, this._mapper);

  final AppDatabase _db;
  final ProductMapper _mapper;

  @override
  Stream<Product?> watchProduct(String id) {
    final query = _db.select(_db.products)..where((p) => p.id.equals(id));
    return query.watchSingleOrNull().map((row) => row == null ? null : _mapper.fromRow(row));
  }
}
