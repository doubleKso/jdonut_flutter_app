import '../domain/image_ref.dart';

/// Decorative bundled images (onboarding and Welcome). Catalogue images come
/// from the database instead.
abstract final class AppAssets {
  static const ImageRef strawberryDonut = ImageRef(asset: 'assets/images/donut_strawberry_sprinkles.png');
  static const ImageRef grapeDonut = ImageRef(asset: 'assets/images/donut_grape_sprinkles.png');
  static const ImageRef chocolateDonut = ImageRef(asset: 'assets/images/donut_chocolate_drizzle.png');
  static const ImageRef stripedDonut = ImageRef(asset: 'assets/images/donut_strawberry_chocolate.png');
  static const ImageRef caramelDonut = ImageRef(asset: 'assets/images/donut_caramel.png');
  static const ImageRef vanillaDonut = ImageRef(asset: 'assets/images/donut_vanilla_sprinkles.png');
  static const ImageRef coconutDonut = ImageRef(asset: 'assets/images/donut_coconut.png');
  static const ImageRef matchaDonut = ImageRef(asset: 'assets/images/donut_matcha.png');
}
