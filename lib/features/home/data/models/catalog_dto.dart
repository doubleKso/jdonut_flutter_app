import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

/// The public catalogue as it arrives from the seed file or `/v1/*`.
final class CatalogDto {
  const CatalogDto({
    required this.products,
    required this.banners,
    required this.sections,
    required this.shops,
  });

  factory CatalogDto.fromJson(Map<String, dynamic> json) => CatalogDto(
    products: _list(json['products'], ProductDto.fromJson),
    banners: _list(json['banners'], BannerDto.fromJson),
    sections: _list(json['sections'], SectionDto.fromJson),
    shops: _list(json['shops'], ShopDto.fromJson),
  );

  final List<ProductDto> products;
  final List<BannerDto> banners;
  final List<SectionDto> sections;
  final List<ShopDto> shops;
}

/// Parses a JSON array of objects with [parse].
List<T> parseList<T>(Object? json, T Function(Map<String, dynamic>) parse) => _list(json, parse);

List<T> _list<T>(Object? json, T Function(Map<String, dynamic>) parse) {
  if (json is! List) return const [];
  return json.whereType<Map<String, dynamic>>().map(parse).toList(growable: false);
}

final class ProductDto {
  const ProductDto(this.json);

  factory ProductDto.fromJson(Map<String, dynamic> json) => ProductDto(json);

  final Map<String, dynamic> json;

  ProductsCompanion toCompanion() => ProductsCompanion.insert(
    id: json['id'] as String,
    code: json['code'] as String,
    name: json['name'] as String,
    priceMmk: (json['priceMmk'] as num).toInt(),
    isNew: Value(json['isNew'] as bool? ?? false),
    discountPercent: Value((json['discountPercent'] as num?)?.toInt()),
    imageUrl: Value(json['imageUrl'] as String? ?? ''),
    imageAsset: Value(json['imageAsset'] as String? ?? ''),
    description: Value(json['description'] as String? ?? ''),
  );
}

final class BannerDto {
  const BannerDto(this.json);

  factory BannerDto.fromJson(Map<String, dynamic> json) => BannerDto(json);

  final Map<String, dynamic> json;

  BannersCompanion toCompanion() => BannersCompanion.insert(
    id: json['id'] as String,
    title: json['title'] as String,
    badge: Value(json['badge'] as String?),
    themeKey: Value(json['themeKey'] as String? ?? 'grape'),
    imageUrl: Value(json['imageUrl'] as String? ?? ''),
    imageAsset: Value(json['imageAsset'] as String? ?? ''),
    sortOrder: Value((json['sortOrder'] as num?)?.toInt() ?? 0),
  );
}

final class SectionDto {
  const SectionDto(this.json);

  factory SectionDto.fromJson(Map<String, dynamic> json) => SectionDto(json);

  final Map<String, dynamic> json;

  String get id => json['id'] as String;

  List<String> get productIds =>
      (json['productIds'] as List<dynamic>? ?? const []).whereType<String>().toList();

  HomeSectionsCompanion toCompanion() => HomeSectionsCompanion.insert(
    id: id,
    title: json['title'] as String,
    layout: json['layout'] as String? ?? 'tall',
    sortOrder: Value((json['sortOrder'] as num?)?.toInt() ?? 0),
  );

  List<HomeSectionItemsCompanion> itemCompanions() => [
    for (final (index, productId) in productIds.indexed)
      HomeSectionItemsCompanion.insert(sectionId: id, productId: productId, sortOrder: Value(index)),
  ];
}

final class ShopDto {
  const ShopDto(this.json);

  factory ShopDto.fromJson(Map<String, dynamic> json) => ShopDto(json);

  final Map<String, dynamic> json;

  ShopsCompanion toCompanion() => ShopsCompanion.insert(
    id: json['id'] as String,
    name: json['name'] as String,
    address: json['address'] as String,
    imageUrl: Value(json['imageUrl'] as String? ?? ''),
    imageAsset: Value(json['imageAsset'] as String? ?? ''),
    sortOrder: Value((json['sortOrder'] as num?)?.toInt() ?? 0),
  );
}
