import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_paths.dart';
import '../../../../core/images/app_image.dart';
import '../../../../core/widgets/pressable_scale.dart';
import '../../../../l10n/l10n.dart';
import '../../../product/domain/entities/product.dart';
import '../../../product/presentation/product_hero.dart';
import '../../domain/entities/home_entities.dart';

/// Sizes of each tile layout.
abstract final class TileMetrics {
  static const double narrowWidth = 104;
  static const double wideWidth = 156;
  static const double wideImageHeight = 104;
  static const double tallImageHeight = 150;
  static const double compactImageHeight = 104;
  static const int nameLines = 2;

  static double width(SectionLayout layout) => layout == SectionLayout.wide ? wideWidth : narrowWidth;

  static double imageHeight(SectionLayout layout) => switch (layout) {
    SectionLayout.wide => wideImageHeight,
    SectionLayout.tall => tallImageHeight,
    SectionLayout.compact => compactImageHeight,
  };
}

/// A product in a Home list. Tapping it opens Product detail, and the image
/// flies there as a Hero.
class ProductTile extends StatelessWidget {
  const ProductTile({required this.product, required this.layout, required this.sectionId, super.key});

  final Product product;
  final SectionLayout layout;
  final String sectionId;

  @override
  Widget build(BuildContext context) {
    final heroTag = productHeroTag(product.id, origin: sectionId);
    return PressableScale(
      semanticLabel: product.name,
      onTap: () => context.push(RoutePaths.product(product.id), extra: heroTag),
      child: SizedBox(
        width: TileMetrics.width(layout),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ImageCard(product: product, layout: layout, heroTag: heroTag),
            const SizedBox(height: AppSpacing.sm),
            Text(
              product.name,
              maxLines: TileMetrics.nameLines,
              overflow: TextOverflow.ellipsis,
              style: context.text.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageCard extends StatelessWidget {
  const _ImageCard({required this.product, required this.layout, required this.heroTag});

  final Product product;
  final SectionLayout layout;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    final cover = layout == SectionLayout.wide;
    return Container(
      height: TileMetrics.imageHeight(layout),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: context.palette.surface, borderRadius: AppRadii.tile),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: EdgeInsets.all(cover ? 0 : AppSpacing.sm),
            child: Hero(tag: heroTag, child: AppImage(product.image, fit: cover ? BoxFit.cover : BoxFit.contain)),
          ),
          if (product.hasDiscount)
            Positioned(
              right: AppSpacing.sm,
              bottom: AppSpacing.sm,
              child: DiscountBadge(percent: product.discountPercent!),
            ),
        ],
      ),
    );
  }
}

/// "50% off", from the product's data.
class DiscountBadge extends StatelessWidget {
  const DiscountBadge({required this.percent, super.key});

  final int percent;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xxs),
    decoration: BoxDecoration(color: context.palette.tangerine, borderRadius: AppRadii.button),
    child: Text(
      context.l10n.discountOff(percent),
      style: context.text.bodySmall?.copyWith(color: context.palette.onAccent, fontWeight: FontWeight.w600),
    ),
  );
}
