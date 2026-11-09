import 'dart:async';

import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../../../core/images/app_image.dart';
import '../../../../core/motion/app_motion.dart';
import '../../../../core/presentation/section_state.dart';
import '../../../../core/widgets/section_message.dart';
import '../../../../core/widgets/skeleton.dart';
import '../../domain/entities/home_entities.dart';

/// The banner carousel: auto-plays, pauses while the user is swiping, and
/// jumps instead of sliding when Reduce Motion is on.
class BannerCarousel extends StatelessWidget {
  const BannerCarousel({required this.state, required this.onRetry, super.key});

  final SectionState<List<HomeBanner>> state;
  final VoidCallback onRetry;

  static const double height = 168;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: height,
    child: switch (state) {
      SectionLoaded(:final data) => _AutoPlayingPager(banners: data),
      SectionLoading() => const Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: SkeletonBox(radius: AppRadii.lg),
      ),
      SectionEmpty() => const SectionMessage.empty(height: height),
      SectionError() => SectionMessage.error(onRetry: onRetry, height: height),
    },
  );
}

class _AutoPlayingPager extends StatefulWidget {
  const _AutoPlayingPager({required this.banners});

  final List<HomeBanner> banners;

  @override
  State<_AutoPlayingPager> createState() => _AutoPlayingPagerState();
}

class _AutoPlayingPagerState extends State<_AutoPlayingPager> {
  static const double _viewport = 0.82;

  final PageController _pages = PageController(viewportFraction: _viewport);
  Timer? _timer;
  int _page = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scheduleNext();
  }

  /// Auto-play, except under Reduce Motion: content that moves on its own
  /// is exactly what that setting asks to stop. Swiping still works.
  void _scheduleNext() {
    _timer?.cancel();
    if (widget.banners.length < 2 || context.reduceMotion) return;
    _timer = Timer.periodic(AppDurations.carouselInterval, (_) => _advance());
  }

  void _advance() {
    if (!mounted || !_pages.hasClients) return;
    final next = (_page + 1) % widget.banners.length;
    unawaited(_pages.animateToPage(next, duration: AppDurations.carouselSlide, curve: AppCurves.standard));
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => NotificationListener<ScrollStartNotification>(
    // A manual swipe restarts the timer, so the carousel never jumps mid-drag.
    onNotification: (notification) {
      if (notification.dragDetails != null) _scheduleNext();
      return false;
    },
    child: PageView.builder(
      controller: _pages,
      padEnds: false,
      itemCount: widget.banners.length,
      onPageChanged: (page) => _page = page,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(left: index == 0 ? AppSpacing.lg : AppSpacing.sm),
        child: _BannerCard(banner: widget.banners[index]),
      ),
    ),
  );
}

class _BannerCard extends StatelessWidget {
  const _BannerCard({required this.banner});

  final HomeBanner banner;

  static const double _imageFraction = 0.5;

  Color _background(AppPalette palette) => switch (banner.theme) {
    BannerTheme.grape => palette.grape,
    BannerTheme.sky => palette.skyDeep,
    BannerTheme.tangerine => palette.tangerine,
  };

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: _background(palette), borderRadius: AppRadii.card),
      child: LayoutBuilder(
        builder: (context, constraints) => Column(
          children: [
            const SizedBox(height: AppSpacing.md),
            if (banner.badge != null) _Badge(text: banner.badge!),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
              child: Text(
                banner.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.text.titleLarge?.copyWith(color: palette.onAccent),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: constraints.maxWidth * 0.7,
              height: constraints.maxHeight * _imageFraction * 0.7,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadii.md)),
                child: AppImage(banner.image, fit: BoxFit.cover),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xxs),
    decoration: BoxDecoration(color: context.palette.tangerine, borderRadius: AppRadii.button),
    child: Text(text, style: context.text.bodySmall?.copyWith(color: context.palette.onAccent)),
  );
}
