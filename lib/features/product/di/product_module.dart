import 'package:get_it/get_it.dart';

import '../../../app/di/dependency_module.dart';
import '../data/cart_repository_impl.dart';
import '../data/product_mapper.dart';
import '../data/product_repository_impl.dart';
import '../domain/repositories/cart_repository.dart';
import '../domain/repositories/product_repository.dart';
import '../domain/usecases/product_use_cases.dart';
import '../presentation/cubit/product_detail_cubit.dart';

final class ProductModule implements DependencyModule {
  const ProductModule();

  @override
  void register(GetIt getIt) {
    getIt
      ..registerLazySingleton(() => ProductMapper(getIt()))
      ..registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(getIt(), getIt()))
      ..registerLazySingleton<CartRepository>(() => CartRepositoryImpl(getIt()))
      ..registerFactory(() => WatchProductUseCase(getIt()))
      ..registerFactory(() => AddToCartUseCase(getIt()))
      ..registerFactoryParam<ProductDetailCubit, String, void>(
        (productId, _) => ProductDetailCubit(watchProduct: getIt(), addToCart: getIt(), productId: productId),
      );
  }
}
