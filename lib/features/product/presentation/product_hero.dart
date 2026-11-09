/// The Hero tag of a product image. Includes where the tile was, because the
/// same product can appear in two Home sections at once.
String productHeroTag(String productId, {String origin = 'detail'}) => 'product-$origin-$productId';
