import 'package:app_core/app_core.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/app/bootstrap/seed_service.dart';
import 'package:jdonuts/core/data/image_url_resolver.dart';
import 'package:jdonuts/core/database/app_database.dart';
import 'package:jdonuts/features/home/data/datasources/catalog_local_data_source.dart';
import 'package:jdonuts/features/home/data/datasources/catalog_remote_data_source.dart';
import 'package:jdonuts/features/home/data/repositories/home_repository_impl.dart';
import 'package:jdonuts/features/member/data/member_local_data_source.dart';
import 'package:jdonuts/features/product/data/product_mapper.dart';

import '../../../support/stub_http_adapter.dart';
import '../../../support/test_database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const baseUrl = 'http://mock.test';
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

  HomeRepositoryImpl repositoryWith(StubHttpAdapter adapter) {
    final dio = Dio(BaseOptions(baseUrl: baseUrl))..httpClientAdapter = adapter;
    const urls = ImageUrlResolver(baseUrl);
    return HomeRepositoryImpl(
      local: CatalogLocalDataSource(db),
      remote: CatalogRemoteDataSource(dio),
      productMapper: const ProductMapper(urls),
      urls: urls,
    );
  }

  test('reads come from the local database, with image URLs on the API host', () async {
    final banners = await repositoryWith(StubHttpAdapter(offline: true)).watchBanners().first;

    expect(banners.first.title, 'We are now at Central Boulevard');
    expect(banners.first.image.url, '$baseUrl/v1/images/banner_new_shop.png');
    expect(banners.first.image.asset, 'assets/images/banner_new_shop.png');
  });

  test('a refresh writes the server catalogue and the watches emit it', () async {
    final adapter = StubHttpAdapter(
      responses: {
        CatalogRemoteDataSource.productsPath: envelope([
          {'id': 'p_new', 'code': 'JD099', 'name': 'Server Donut', 'priceMmk': 1000},
        ]),
        CatalogRemoteDataSource.bannersPath: envelope([
          {'id': 'b_server', 'title': 'From the server', 'themeKey': 'sky'},
        ]),
        CatalogRemoteDataSource.sectionsPath: envelope([
          {'id': 'popular', 'title': 'Popular', 'layout': 'tall', 'productIds': ['p_new']},
        ]),
        CatalogRemoteDataSource.shopsPath: envelope([]),
      },
    );
    final repository = repositoryWith(adapter);

    final result = await repository.refresh();

    expect(result.isSuccess, isTrue);
    expect((await repository.watchBanners().first).single.title, 'From the server');
    expect((await repository.watchSections().first).single.products.single.name, 'Server Donut');
    expect(await repository.watchShops().first, isEmpty);
  });

  test('offline, a refresh fails with a network failure and keeps the saved data', () async {
    final repository = repositoryWith(StubHttpAdapter(offline: true));

    final result = await repository.refresh();

    expect(result.failureOrNull, isA<NetworkFailure>());
    expect(await repository.watchBanners().first, hasLength(3));
  });

  test('an error envelope becomes a server failure', () async {
    final adapter = StubHttpAdapter(
      responses: {
        for (final path in [
          CatalogRemoteDataSource.productsPath,
          CatalogRemoteDataSource.bannersPath,
          CatalogRemoteDataSource.sectionsPath,
          CatalogRemoteDataSource.shopsPath,
        ])
          path: {
            'data': null,
            'error': {'code': 'maintenance', 'message': 'Back soon'},
            'meta': {},
          },
      },
    );

    final result = await repositoryWith(adapter).refresh();

    expect(result.failureOrNull, const ServerFailure('Back soon'));
  });
}
