import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../../../core/formatting/mmk_format.dart';
import '../../../../core/images/app_image.dart';
import '../../../../core/presentation/section_state.dart';
import '../../../../core/widgets/pressable_scale.dart';
import '../../../../core/widgets/skeleton.dart';
import '../../../../l10n/l10n.dart';
import '../../../member/domain/entities/member.dart';

/// Photo, name, tier, points to the next tier, and the notification bell.
class MemberHeader extends StatelessWidget {
  const MemberHeader({required this.state, required this.onRetry, super.key});

  final SectionState<Member> state;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => switch (state) {
    SectionLoaded(:final data) => _MemberDetails(member: data),
    SectionLoading() => const _MemberSkeleton(),
    SectionEmpty() || SectionError() => Align(
      alignment: Alignment.centerLeft,
      child: TextButton(onPressed: onRetry, child: Text(context.l10n.retry)),
    ),
  };
}

class _MemberDetails extends StatelessWidget {
  const _MemberDetails({required this.member});

  final Member member;

  static const double _avatarSize = 52;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final palette = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _Avatar(member: member, size: _avatarSize),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(member.name, style: context.text.headlineSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text(
                    l10n.memberTierLabel(l10n.tierName(member.tier.name)),
                    style: context.text.bodySmall?.copyWith(color: palette.slate),
                  ),
                ],
              ),
            ),
            NotificationBell(count: member.notificationCount),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        _PointsPill(member: member),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.member, required this.size});

  final Member member;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    padding: const EdgeInsets.all(AppSpacing.xxs),
    decoration: BoxDecoration(color: context.palette.surface, shape: BoxShape.circle),
    child: ClipOval(
      child: AppImage(member.photo, fit: BoxFit.cover, semanticLabel: context.l10n.memberPhoto(member.name)),
    ),
  );
}

class _PointsPill extends StatelessWidget {
  const _PointsPill({required this.member});

  final Member member;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final next = member.nextTier;
    final text = next == null
        ? l10n.topTierReached
        : l10n.pointsToNextTier(formatCount(member.pointsToNextTier), l10n.tierName(next.name));
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
      decoration: BoxDecoration(color: context.palette.surface, borderRadius: AppRadii.button),
      child: Text(text, style: context.text.bodySmall),
    );
  }
}

/// The orange bell with its count.
class NotificationBell extends StatelessWidget {
  const NotificationBell({required this.count, super.key});

  final int count;

  static const double _badgeSize = 18;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return PressableScale(
      semanticLabel: context.l10n.notifications(count),
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        decoration: BoxDecoration(color: palette.tangerine, borderRadius: AppRadii.button),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.notifications_none_rounded, color: palette.onAccent, size: AppSpacing.xl),
            if (count > 0) ...[
              const SizedBox(width: AppSpacing.xs),
              Container(
                width: _badgeSize,
                height: _badgeSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: palette.surface, shape: BoxShape.circle),
                child: Text('$count', style: context.text.bodySmall?.copyWith(color: palette.tangerine)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MemberSkeleton extends StatelessWidget {
  const _MemberSkeleton();

  @override
  Widget build(BuildContext context) => const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          SkeletonBox(width: 52, height: 52, radius: AppRadii.pill),
          SizedBox(width: AppSpacing.md),
          SkeletonBox(width: 120, height: 36),
        ],
      ),
      SizedBox(height: AppSpacing.sm),
      SkeletonBox(width: 220, height: 24, radius: AppRadii.pill),
    ],
  );
}
