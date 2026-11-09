import 'package:equatable/equatable.dart';

import '../../../../core/domain/image_ref.dart';
import '../../../product/domain/entities/product.dart';

/// A banner's colour scheme, named by palette key — never a raw colour.
enum BannerTheme {
  grape,
  sky,
  tangerine;

  static BannerTheme fromKey(String key) =>
      values.firstWhere((theme) => theme.name == key, orElse: () => grape);
}

final class HomeBanner extends Equatable {
  const HomeBanner({
    required this.id,
    required this.title,
    required this.theme,
    required this.image,
    this.badge,
  });

  final String id;
  final String title;
  final String? badge;
  final BannerTheme theme;
  final ImageRef image;

  @override
  List<Object?> get props => [id, title, badge, theme, image];
}

/// How a section's product tiles are drawn.
enum SectionLayout {
  wide,
  tall,
  compact;

  static SectionLayout fromKey(String key) =>
      values.firstWhere((layout) => layout.name == key, orElse: () => tall);
}

final class HomeSection extends Equatable {
  const HomeSection({
    required this.id,
    required this.title,
    required this.layout,
    required this.products,
  });

  final String id;
  final String title;
  final SectionLayout layout;
  final List<Product> products;

  @override
  List<Object?> get props => [id, title, layout, products];
}

final class Shop extends Equatable {
  const Shop({required this.id, required this.name, required this.address, required this.image});

  final String id;
  final String name;
  final String address;
  final ImageRef image;

  @override
  List<Object?> get props => [id, name, address, image];
}
