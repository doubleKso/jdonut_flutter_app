import '../entities/product.dart';

abstract interface class ProductRepository {
  /// The product with [id], or null once the local database has no such row.
  Stream<Product?> watchProduct(String id);
}
