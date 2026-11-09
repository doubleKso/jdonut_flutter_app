import 'dart:math' as math;

import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../../../core/images/app_image.dart';
import '../../../../core/presentation/section_state.dart';
import '../../../../core/widgets/pressable_scale.dart';
import '../../../../core/widgets/section_message.dart';
import '../../../../core/widgets/skeleton.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/entities/home_entities.dart';

/// "There are 4 J'Donut shops near you" — display only: Explore now and
/// Order online give press feedback but take no action.
class ShopsSection extends StatelessWidget {
  const ShopsSection({required this.state, required this.onRetry, super.key});

  final SectionState<List<Shop>> state;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.sky,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadii.xl)),
      ),
      child: CustomPaint(
        painter: _SceneryPainter(cloud: palette.surface, hill: palette.leaf),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
          child: switch (state) {
            SectionLoaded(:final data) => _ShopList(shops: data),
            SectionLoading() => const _ShopsSkeleton(),
            SectionEmpty() => const SectionMessage.empty(),
            SectionError() => SectionMessage.error(onRetry: onRetry),
          },
        ),
      ),
    );
  }
}

class _ShopList extends StatelessWidget {
  const _ShopList({required this.shops});

  final List<Shop> shops;

  static const double _cardHeight = 236;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final cardHeight = MediaQuery.textScalerOf(context).scale(_cardHeight);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Text(context.l10n.shopsTitle(shops.length), style: context.text.titleLarge?.copyWith(color: palette.onAccent)),
        ),
        const SizedBox(height: AppSpacing.md),
        Padding(padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg), child: _ExploreButton()),
        const SizedBox(height: AppSpacing.lg),
        SizedBox(
          height: cardHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            itemCount: shops.length,
            separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.md),
            itemBuilder: (context, index) => _ShopCard(shop: shops[index]),
          ),
        ),
      ],
    );
  }
}

class _ExploreButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => PressableScale(
    onTap: () {},
    semanticLabel: context.l10n.exploreNow,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
      decoration: BoxDecoration(color: context.palette.surface, borderRadius: AppRadii.button),
      child: Text(context.l10n.exploreNow, style: context.text.labelLarge?.copyWith(color: context.palette.skyDeep)),
    ),
  );
}

class _ShopCard extends StatelessWidget {
  const _ShopCard({required this.shop});

  final Shop shop;

  static const double _width = 190;
  static const double _imageHeight = 108;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Container(
      width: _width,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(color: palette.surface, borderRadius: AppRadii.card),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: _imageHeight,
            width: double.infinity,
            child: ClipRRect(borderRadius: AppRadii.tile, child: AppImage(shop.image, fit: BoxFit.cover)),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(shop.name, style: context.text.labelMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            shop.address,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.text.bodySmall?.copyWith(color: palette.slate),
          ),
          const Spacer(),
          PressableScale(
            onTap: () {},
            semanticLabel: context.l10n.orderOnline,
            child: Text(context.l10n.orderOnline, style: context.text.labelMedium?.copyWith(color: palette.berry)),
          ),
        ],
      ),
    );
  }
}

class _ShopsSkeleton extends StatelessWidget {
  const _ShopsSkeleton();

  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
    child: Row(
      children: [
        Expanded(child: SkeletonBox(height: 220, radius: AppRadii.lg)),
        SizedBox(width: AppSpacing.md),
        Expanded(child: SkeletonBox(height: 220, radius: AppRadii.lg)),
      ],
    ),
  );
}

/// Soft clouds at the top right and rolling hills along the bottom.
class _SceneryPainter extends CustomPainter {
  const _SceneryPainter({required this.cloud, required this.hill});

  final Color cloud;
  final Color hill;

  static const double _cloudAlpha = 0.85;
  static const double _hillAlpha = 0.55;

  @override
  void paint(Canvas canvas, Size size) {
    final cloudPaint = Paint()..color = cloud.withValues(alpha: _cloudAlpha);
    canvas
      ..drawCircle(Offset(size.width * 0.92, size.height * 0.06), size.width * 0.16, cloudPaint)
      ..drawCircle(Offset(size.width * 0.78, size.height * 0.1), size.width * 0.1, cloudPaint);
    final hills = Path()..moveTo(0, size.height);
    const bumps = 4;
    for (var i = 0; i <= bumps; i++) {
      final x = size.width * i / bumps;
      final y = size.height * (0.9 + 0.04 * math.sin(i * math.pi / 1.5));
      hills.quadraticBezierTo(x - size.width / (bumps * 2), y - size.height * 0.05, x, y);
    }
    hills
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(hills, Paint()..color = hill.withValues(alpha: _hillAlpha));
  }

  @override
  bool shouldRepaint(_SceneryPainter old) => old.cloud != cloud || old.hill != hill;
}
