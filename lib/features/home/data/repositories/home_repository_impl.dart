import 'package:app_core/app_core.dart';
import 'package:dio/dio.dart';

import '../../../../core/data/image_url_resolver.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/domain/image_ref.dart';
import '../../../product/data/product_mapper.dart';
import '../../domain/entities/home_entities.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/catalog_local_data_source.dart';
import '../datasources/catalog_remote_data_source.dart';

/// Offline-first: every read is a database watch; [refresh] is the only
/// thing that touches the network, and it writes into the database.
final class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl({
    required this._local,
    required this._remote,
    required this._productMapper,
    required this._urls,
  });

  final CatalogLocalDataSource _local;
  final CatalogRemoteDataSource _remote;
  final ProductMapper _productMapper;
  final ImageUrlResolver _urls;

  @override
  Stream<List<HomeBanner>> watchBanners() =>
      _local.watchBanners().map((rows) => rows.map(_banner).toList(growable: false));

  @override
  Stream<List<Shop>> watchShops() =>
      _local.watchShops().map((rows) => rows.map(_shop).toList(growable: false));

  @override
  Stream<List<HomeSection>> watchSections() =>
      _local.watchSections().map((rows) => rows.map(_section).toList(growable: false));

  @override
  Future<Result<void>> refresh() async {
    try {
      await _local.writeCatalog(await _remote.fetchCatalog());
      return const Result.success(null);
    } on DioException catch (e) {
      return Result.failure(_networkFailure(e));
    } on ApiErrorException catch (e) {
      return Result.failure(ServerFailure(e.error.message));
    } on TypeError catch (e) {
      return Result.failure(ParsingFailure('Catalogue payload was malformed: $e'));
    } on Exception catch (e) {
      return Result.failure(CacheFailure('Could not save the catalogue: $e'));
    }
  }

  Failure _networkFailure(DioException e) => e.response == null
      ? NetworkFailure(e.message ?? e.type.name)
      : ServerFailure(e.message ?? 'HTTP error', statusCode: e.response?.statusCode);

  HomeBanner _banner(BannerRow row) => HomeBanner(
    id: row.id,
    title: row.title,
    badge: row.badge,
    theme: BannerTheme.fromKey(row.themeKey),
    image: _image(row.imageUrl, row.imageAsset),
  );

  Shop _shop(ShopRow row) => Shop(
    id: row.id,
    name: row.name,
    address: row.address,
    image: _image(row.imageUrl, row.imageAsset),
  );

  HomeSection _section(SectionWithProducts entry) => HomeSection(
    id: entry.section.id,
    title: entry.section.title,
    layout: SectionLayout.fromKey(entry.section.layout),
    products: entry.products.map(_productMapper.fromRow).toList(growable: false),
  );

  ImageRef _image(String url, String asset) => ImageRef(url: _urls.resolve(url), asset: asset);
}
