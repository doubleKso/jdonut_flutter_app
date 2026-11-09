import 'package:app_core/app_core.dart';

abstract interface class CartRepository {
  /// Adds [quantity] of [productId]; returns that product's new quantity.
  Future<Result<int>> add(String productId, int quantity);

  /// Total number of items in the cart.
  Stream<int> watchItemCount();
}
