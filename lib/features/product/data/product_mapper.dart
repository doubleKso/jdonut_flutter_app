import '../../../core/data/image_url_resolver.dart';
import '../../../core/database/app_database.dart';
import '../../../core/domain/image_ref.dart';
import '../domain/entities/product.dart';

/// Database row → domain entity. Shared by Product detail and Home lists.
final class ProductMapper {
  const ProductMapper(this._urls);

  final ImageUrlResolver _urls;

  Product fromRow(ProductRow row) => Product(
    id: row.id,
    code: row.code,
    name: row.name,
    priceMmk: row.priceMmk,
    isNew: row.isNew,
    discountPercent: row.discountPercent,
    description: row.description,
    image: ImageRef(url: _urls.resolve(row.imageUrl), asset: row.imageAsset),
  );
}
