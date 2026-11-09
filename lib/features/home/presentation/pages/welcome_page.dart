import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_paths.dart';
import '../../../../core/assets/app_assets.dart';
import '../../../../core/domain/image_ref.dart';
import '../../../../core/images/app_image.dart';
import '../../../../core/motion/app_motion.dart';
import '../../../../core/widgets/blush_background.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/staggered_entrance.dart';
import '../../../../l10n/l10n.dart';

/// One tile of the Welcome mosaic.
final class _Tile {
  const _Tile(this.color, this.image, this.from, this.heightFactor);

  final Color Function(AppPalette) color;
  final ImageRef image;

  /// Where the tile slides in from.
  final Offset from;

  /// Height relative to the tile's width.
  final double heightFactor;
}

final List<_Tile> _leftColumn = [
  _Tile((p) => p.tileSky, AppAssets.grapeDonut, const Offset(-60, -40), 1.15),
  _Tile((p) => p.tilePeach, AppAssets.strawberryDonut, const Offset(-60, 40), 1.25),
];
final List<_Tile> _rightColumn = [
  _Tile((p) => p.tileRose, AppAssets.stripedDonut, const Offset(60, -40), 0.95),
  _Tile((p) => p.tileSun, AppAssets.chocolateDonut, const Offset(60, 40), 1.15),
];

/// Screen 7: donut tiles slide in one after another, then the title fades up.
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  static const double _mosaicFraction = 0.55;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final tilesDone = AppDurations.entrance + AppDurations.staggerStep * 4;
    return Scaffold(
      body: BlushBackground(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: MediaQuery.sizeOf(context).height * _mosaicFraction, child: const _Mosaic()),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter * 2),
                  child: Column(
                    children: [
                      const SizedBox(height: AppSpacing.xxl),
                      StaggeredEntrance(
                        index: 0,
                        initialDelay: tilesDone,
                        child: Text(l10n.welcomeTitle, style: context.text.displaySmall, textAlign: TextAlign.center),
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                      StaggeredEntrance(
                        index: 1,
                        initialDelay: tilesDone,
                        child: PrimaryButton(label: l10n.letsExplore, onPressed: () => context.go(RoutePaths.home)),
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Mosaic extends StatelessWidget {
  const _Mosaic();

  @override
  Widget build(BuildContext context) => ClipRect(
    child: OverflowBox(
      alignment: Alignment.topCenter,
      maxHeight: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _column(context, _leftColumn, 0, topInset: 0)),
          const SizedBox(width: AppSpacing.lg),
          Expanded(child: _column(context, _rightColumn, 1, topInset: AppSpacing.huge)),
        ],
      ),
    ),
  );

  Widget _column(BuildContext context, List<_Tile> tiles, int startIndex, {required double topInset}) =>
      LayoutBuilder(
        builder: (context, constraints) => Column(
          children: [
            SizedBox(height: topInset),
            for (final (offset, tile) in tiles.indexed)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                child: StaggeredEntrance(
                  index: startIndex + offset * 2,
                  offset: tile.from,
                  child: _TileCard(tile: tile, height: constraints.maxWidth * tile.heightFactor),
                ),
              ),
          ],
        ),
      );
}

class _TileCard extends StatelessWidget {
  const _TileCard({required this.tile, required this.height});

  final _Tile tile;
  final double height;

  static const double _donutFraction = 0.72;

  @override
  Widget build(BuildContext context) => Container(
    height: height,
    decoration: BoxDecoration(color: tile.color(context.palette), borderRadius: AppRadii.card),
    alignment: Alignment.center,
    child: FractionallySizedBox(widthFactor: _donutFraction, child: AppImage(tile.image)),
  );
}
