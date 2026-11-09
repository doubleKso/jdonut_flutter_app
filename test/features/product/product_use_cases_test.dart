import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/app/bootstrap/seed_service.dart';
import 'package:jdonuts/core/data/image_url_resolver.dart';
import 'package:jdonuts/core/database/app_database.dart';
import 'package:jdonuts/core/formatting/mmk_format.dart';
import 'package:jdonuts/features/home/data/datasources/catalog_local_data_source.dart';
import 'package:jdonuts/features/member/data/member_local_data_source.dart';
import 'package:jdonuts/features/product/data/cart_repository_impl.dart';
import 'package:jdonuts/features/product/data/product_mapper.dart';
import 'package:jdonuts/features/product/data/product_repository_impl.dart';
import 'package:jdonuts/features/product/domain/usecases/product_use_cases.dart';

import '../../support/test_database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;

  setUp(() async {
    db = newTestDatabase();
    await SeedService(
      db: db,
      bundle: rootBundle,
      catalogLocal: CatalogLocalDataSource(db),
      memberLocal: MemberLocalDataSource(db),
    ).seedIfNeeded();
  });

  tearDown(() => db.close());

  test('the reference product reads exactly as the design specifies', () async {
    final product = await WatchProductUseCase(
      ProductRepositoryImpl(db, const ProductMapper(ImageUrlResolver('http://mock.test'))),
    )('p_coconut').first;

    expect(product?.code, 'JD022123');
    expect(product?.name, 'Coconut Donut');
    expect(product?.isNew, isTrue);
    expect(formatMmk(product!.priceMmk), '3,200 MMK');
    expect(formatMmk(product.totalFor(3)), '9,600 MMK');
  });

  test('an unknown product id reads as null, not an error', () async {
    final product = await WatchProductUseCase(
      ProductRepositoryImpl(db, const ProductMapper(ImageUrlResolver('http://mock.test'))),
    )('p_missing').first;

    expect(product, isNull);
  });

  test('adding to the cart accumulates quantities and updates the count', () async {
    final cart = CartRepositoryImpl(db);
    final addToCart = AddToCartUseCase(cart);

    await addToCart(const AddToCartParams(productId: 'p_coconut', quantity: 2));
    final result = await addToCart(const AddToCartParams(productId: 'p_coconut', quantity: 1));

    expect(result.dataOrNull, 3);
    expect(await cart.watchItemCount().first, 3);
  });

  test('a quantity below one is refused', () async {
    final result = await AddToCartUseCase(CartRepositoryImpl(db))(
      const AddToCartParams(productId: 'p_coconut', quantity: 0),
    );

    expect(result.isFailure, isTrue);
  });
}
