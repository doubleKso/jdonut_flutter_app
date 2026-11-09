import 'package:equatable/equatable.dart';

import '../../../../core/domain/image_ref.dart';

final class Product extends Equatable {
  const Product({
    required this.id,
    required this.code,
    required this.name,
    required this.priceMmk,
    required this.image,
    this.isNew = false,
    this.discountPercent,
    this.description = '',
  });

  final String id;

  /// Shop product code, e.g. JD022123.
  final String code;
  final String name;
  final int priceMmk;
  final ImageRef image;
  final bool isNew;
  final int? discountPercent;
  final String description;

  bool get hasDiscount => (discountPercent ?? 0) > 0;

  /// What [quantity] of this product costs.
  int totalFor(int quantity) => priceMmk * quantity;

  @override
  List<Object?> get props => [id, code, name, priceMmk, image, isNew, discountPercent, description];
}
