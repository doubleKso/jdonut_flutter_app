import 'package:app_network/app_network.dart';
import 'package:dio/dio.dart';

import '../models/catalog_dto.dart';

/// Thrown when the server answers with an error envelope.
final class ApiErrorException implements Exception {
  const ApiErrorException(this.error);

  final ApiError error;

  @override
  String toString() => 'ApiErrorException(${error.code}: ${error.message})';
}

/// Fetches the public catalogue from the mock server's `/v1` API.
final class CatalogRemoteDataSource {
  const CatalogRemoteDataSource(this._dio);

  static const String productsPath = '/v1/products';
  static const String bannersPath = '/v1/banners';
  static const String sectionsPath = '/v1/sections';
  static const String shopsPath = '/v1/shops';

  final Dio _dio;

  /// All four resources, fetched in parallel. Throws [DioException] on the
  /// network and [ApiErrorException] when the server reports an error.
  Future<CatalogDto> fetchCatalog() async {
    final responses = await Future.wait([
      _fetchList(productsPath),
      _fetchList(bannersPath),
      _fetchList(sectionsPath),
      _fetchList(shopsPath),
    ]);
    return CatalogDto(
      products: parseList(responses[0], ProductDto.fromJson),
      banners: parseList(responses[1], BannerDto.fromJson),
      sections: parseList(responses[2], SectionDto.fromJson),
      shops: parseList(responses[3], ShopDto.fromJson),
    );
  }

  Future<List<dynamic>> _fetchList(String path) async {
    final response = await _dio.get<Map<String, dynamic>>(path);
    final envelope = ApiEnvelope<List<dynamic>>.fromJson(
      response.data ?? const {},
      (data) => data is List ? data : const [],
    );
    final error = envelope.error;
    if (error != null) throw ApiErrorException(error);
    return envelope.data ?? const [];
  }
}
