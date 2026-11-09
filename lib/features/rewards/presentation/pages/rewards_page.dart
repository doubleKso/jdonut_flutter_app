import 'dart:math' as math;

import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/motion/app_motion.dart';
import '../../../../core/presentation/section_state.dart';
import '../../../../core/widgets/offline_banner.dart';
import '../../../../core/widgets/pop_in.dart';
import '../../../../core/widgets/pressable_scale.dart';
import '../../../../core/widgets/section_message.dart';
import '../../../../core/widgets/skeleton.dart';
import '../../../../core/widgets/staggered_entrance.dart';
import '../../../../l10n/l10n.dart';
import '../../../member/domain/entities/member.dart';
import '../../domain/entities/challenge.dart';
import '../cubit/rewards_cubit.dart';
import '../widgets/challenge_card.dart';
import '../widgets/points_ring.dart';
import '../widgets/rewards_tabs.dart';
import '../widgets/tier_ladder.dart';

/// Screen 10.
class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  static const double navClearance = 96;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Scaffold(
      backgroundColor: palette.surface,
      body: BlocBuilder<RewardsCubit, RewardsState>(
        builder: (context, state) => CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SafeArea(
                bottom: false,
                child: Column(children: [const OfflineBanner(), _TitleRow(member: state.member)]),
              ),
            ),
            SliverToBoxAdapter(child: _LadderAndRing(member: state.member)),
            SliverToBoxAdapter(child: _TabsBand(selected: state.tab)),
            SliverToBoxAdapter(child: _ChallengeList(state: state)),
            SliverFillRemaining(hasScrollBody: false, child: ColoredBox(color: palette.mist)),
          ],
        ),
      ),
    );
  }
}

/// "J' Donuts Rewards" and the orange Rewards pill, whose badge pops in.
class _TitleRow extends StatelessWidget {
  const _TitleRow({required this.member});

  final SectionState<Member> member;

  static const double _badgeSize = 24;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final count = member is SectionLoaded<Member> ? (member as SectionLoaded<Member>).data.rewardsCount : 0;
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.gutter, top: AppSpacing.lg, bottom: AppSpacing.lg),
      child: Row(
        children: [
          Expanded(child: Text(context.l10n.rewardsTitle, style: context.text.displaySmall)),
          PressableScale(
            onTap: () {},
            semanticLabel: context.l10n.rewardsPill,
            child: Container(
              padding: const EdgeInsets.fromLTRB(AppSpacing.xl, AppSpacing.md, AppSpacing.lg, AppSpacing.md),
              decoration: BoxDecoration(
                color: palette.tangerine,
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(AppRadii.pill)),
              ),
              child: Row(
                children: [
                  Text(context.l10n.rewardsPill, style: context.text.titleMedium?.copyWith(color: palette.onAccent)),
                  const SizedBox(width: AppSpacing.sm),
                  PopIn(
                    delay: AppDurations.long,
                    child: Container(
                      width: _badgeSize,
                      height: _badgeSize,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: palette.surface, shape: BoxShape.circle),
                      child: Text('$count', style: context.text.labelMedium?.copyWith(color: palette.ink)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The tier ladder on the left; the points ring on the right, running off
/// the edge of the screen as in the design.
class _LadderAndRing extends StatelessWidget {
  const _LadderAndRing({required this.member});

  final SectionState<Member> member;

  static const double _ringDiameter = 0.74;
  static const double _ringCentreX = 0.73;
  static const double _ladderWidth = 0.46;
  static const double _areaHeight = 330;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.textScalerOf(context).scale(_areaHeight);
    return switch (member) {
      SectionLoaded(:final data) => _loaded(context, data, height),
      SectionLoading() => SizedBox(
        height: height,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
          child: SkeletonBox(radius: AppRadii.xl),
        ),
      ),
      SectionEmpty() || SectionError() => SectionMessage.error(
        onRetry: context.read<RewardsCubit>().start,
        height: height,
      ),
    };
  }

  /// The ladder sets the height (it grows with large text); the ring is
  /// centred on whatever height that gives, never less than its diameter.
  Widget _loaded(BuildContext context, Member data, double minHeight) {
    final width = MediaQuery.sizeOf(context).width;
    final diameter = width * _ringDiameter;
    return ClipRect(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: math.max(minHeight, diameter + AppSpacing.lg)),
        child: Stack(
          children: [
            Positioned(
              left: width * _ringCentreX - diameter / 2,
              top: 0,
              bottom: 0,
              width: diameter,
              child: Center(
                child: SizedBox.square(
                  dimension: diameter,
                  child: PointsRing(progress: data.tierProgress, totalPoints: data.totalPoints),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.gutter, AppSpacing.sm, 0, AppSpacing.lg),
              child: SizedBox(width: width * _ladderWidth, child: TierLadder(member: data)),
            ),
          ],
        ),
      ),
    );
  }
}

/// The two tab pills sitting on the line between white and grey.
class _TabsBand extends StatelessWidget {
  const _TabsBand({required this.selected});

  final RewardsTab selected;

  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.center,
    children: [
      Column(
        children: [
          const SizedBox(height: RewardsTabs.height / 2),
          Container(height: RewardsTabs.height / 2, color: context.palette.mist),
        ],
      ),
      RewardsTabs(selected: selected, onSelected: context.read<RewardsCubit>().selectTab),
    ],
  );
}

/// The selected tab's cards. Switching tabs cross-fades the list and the new
/// cards enter one after another.
class _ChallengeList extends StatelessWidget {
  const _ChallengeList({required this.state});

  final RewardsState state;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: context.palette.mist,
    child: AnimatedSwitcher(
      duration: context.motion(AppDurations.tabSwitch),
      switchInCurve: AppCurves.standard,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween(begin: const Offset(0, 0.04), end: Offset.zero).animate(animation),
          child: child,
        ),
      ),
      child: KeyedSubtree(key: ValueKey(state.tab), child: _cards(context)),
    ),
  );

  Widget _cards(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(AppSpacing.gutter, AppSpacing.xl, AppSpacing.gutter, RewardsPage.navClearance),
    child: switch (state.challenges) {
      SectionLoaded(:final data) => Column(
        children: [
          for (final (index, challenge) in data.indexed)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: StaggeredEntrance(index: index, child: ChallengeCard(challenge: challenge)),
            ),
        ],
      ),
      SectionLoading() => const Column(
        children: [SkeletonBox(height: 144, radius: AppRadii.lg), SizedBox(height: AppSpacing.lg), SkeletonBox(height: 144, radius: AppRadii.lg)],
      ),
      SectionEmpty() => Text(context.l10n.challengesEmpty, style: context.text.bodyLarge),
      SectionError() => SectionMessage.error(onRetry: context.read<RewardsCubit>().start),
    },
  );
}
