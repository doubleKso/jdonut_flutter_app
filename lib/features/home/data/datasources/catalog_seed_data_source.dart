import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/catalog_dto.dart';

/// The catalogue bundled with the app, imported on first launch.
final class CatalogSeedDataSource {
  const CatalogSeedDataSource(this._bundle);

  static const String assetPath = 'assets/seed/catalog.json';

  final AssetBundle _bundle;

  /// Read once per install, so it is not kept in the bundle's cache.
  Future<CatalogDto> load() async {
    final raw = await _bundle.loadString(assetPath, cache: false);
    return CatalogDto.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }
}
