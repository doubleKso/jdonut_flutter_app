import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/section_state.dart';
import '../../../../core/widgets/coming_soon_sheet.dart';
import '../../../../core/widgets/pressable_scale.dart';
import '../../../../core/widgets/section_message.dart';
import '../../../../core/widgets/skeleton.dart';
import '../../../../core/widgets/staggered_entrance.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/entities/home_entities.dart';
import 'product_tile.dart';

/// Seasonal specials, Popular and Order again — each entering in turn.
class ProductSections extends StatelessWidget {
  const ProductSections({required this.state, required this.onRetry, this.firstIndex = 0, super.key});

  final SectionState<List<HomeSection>> state;
  final VoidCallback onRetry;

  /// Stagger position of the first section on the page.
  final int firstIndex;

  @override
  Widget build(BuildContext context) => switch (state) {
    SectionLoaded(:final data) => Column(
      children: [
        for (final (index, section) in data.indexed)
          StaggeredEntrance(index: firstIndex + index, child: ProductSectionView(section: section)),
      ],
    ),
    SectionLoading() => const Column(children: [_SectionSkeleton(), _SectionSkeleton()]),
    SectionEmpty() => const Padding(padding: EdgeInsets.only(top: AppSpacing.xxl), child: SectionMessage.empty()),
    SectionError() => Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xxl),
      child: SectionMessage.error(onRetry: onRetry),
    ),
  };
}

/// One titled horizontal list, with its own empty state.
class ProductSectionView extends StatelessWidget {
  const ProductSectionView({required this.section, super.key});

  final HomeSection section;

  @override
  Widget build(BuildContext context) {
    final nameStyle = context.text.labelMedium!;
    final nameHeight = MediaQuery.textScalerOf(context).scale(nameStyle.fontSize!) *
        nameStyle.height! *
        TileMetrics.nameLines;
    final listHeight = TileMetrics.imageHeight(section.layout) + AppSpacing.sm + nameHeight + AppSpacing.xs;
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: section.title),
          const SizedBox(height: AppSpacing.md),
          if (section.products.isEmpty)
            const SectionMessage.empty()
          else
            SizedBox(
              height: listHeight,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                itemCount: section.products.length,
                separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.md),
                itemBuilder: (context, index) => ProductTile(
                  product: section.products[index],
                  layout: section.layout,
                  sectionId: section.id,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// "Seasonal specials" with the round chevron button on the right.
class SectionHeader extends StatelessWidget {
  const SectionHeader({required this.title, super.key});

  final String title;

  static const double _buttonSize = 28;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
    child: Row(
      children: [
        Expanded(child: Text(title, style: context.text.titleLarge)),
        PressableScale(
          semanticLabel: context.l10n.seeAll(title),
          onTap: () => showComingSoonSheet(context, context.l10n.placeholderBody(title)),
          child: Container(
            width: _buttonSize,
            height: _buttonSize,
            decoration: BoxDecoration(color: context.palette.surface, shape: BoxShape.circle),
            child: Icon(Icons.chevron_right_rounded, size: AppSpacing.xl, color: context.palette.ink),
          ),
        ),
      ],
    ),
  );
}

class _SectionSkeleton extends StatelessWidget {
  const _SectionSkeleton();

  static const int _tiles = 3;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.xxl, 0, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SkeletonBox(width: 160, height: 22),
        const SizedBox(height: AppSpacing.md),
        // Like the real row, the placeholders run off the screen edge
        // rather than overflowing on narrow phones.
        SizedBox(
          height: TileMetrics.tallImageHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _tiles,
            separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.md),
            itemBuilder: (_, _) => const SkeletonBox(width: TileMetrics.narrowWidth, height: TileMetrics.tallImageHeight),
          ),
        ),
      ],
    ),
  );
}
