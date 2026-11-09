import 'package:app_core/app_core.dart';
import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../domain/repositories/cart_repository.dart';

/// The persistent cart (schema v2).
final class CartRepositoryImpl implements CartRepository {
  const CartRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<Result<int>> add(String productId, int quantity) async {
    try {
      final total = await _db.transaction(() async {
        final existing = await (_db.select(_db.cartItems)
              ..where((c) => c.productId.equals(productId)))
            .getSingleOrNull();
        final next = (existing?.quantity ?? 0) + quantity;
        await _db.into(_db.cartItems).insertOnConflictUpdate(
          CartItemsCompanion.insert(productId: productId, quantity: next, updatedAt: DateTime.now()),
        );
        return next;
      });
      return Result.success(total);
    } on Exception catch (e) {
      return Result.failure(CacheFailure('Could not save the cart: $e'));
    }
  }

  @override
  Stream<int> watchItemCount() {
    final sum = _db.cartItems.quantity.sum();
    final query = _db.selectOnly(_db.cartItems)..addColumns([sum]);
    return query.watchSingle().map((row) => row.read(sum) ?? 0);
  }
}
