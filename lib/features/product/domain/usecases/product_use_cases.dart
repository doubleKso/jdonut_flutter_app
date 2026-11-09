import 'package:app_core/app_core.dart';

import '../entities/product.dart';
import '../repositories/cart_repository.dart';
import '../repositories/product_repository.dart';

final class WatchProductUseCase implements StreamUseCase<Product?, String> {
  const WatchProductUseCase(this._repository);

  final ProductRepository _repository;

  @override
  Stream<Product?> call(String productId) => _repository.watchProduct(productId);
}

final class AddToCartParams {
  const AddToCartParams({required this.productId, required this.quantity});

  final String productId;
  final int quantity;
}

final class AddToCartUseCase implements UseCase<int, AddToCartParams> {
  const AddToCartUseCase(this._repository);

  static const int minimumQuantity = 1;

  final CartRepository _repository;

  @override
  Future<Result<int>> call(AddToCartParams params) async {
    if (params.quantity < minimumQuantity) {
      return const Result.failure(UnexpectedFailure('Quantity must be at least 1'));
    }
    return _repository.add(params.productId, params.quantity);
  }
}
