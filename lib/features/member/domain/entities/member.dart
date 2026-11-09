import 'package:equatable/equatable.dart';

import '../../../../core/domain/image_ref.dart';

/// Loyalty tiers, lowest first.
enum MemberTier {
  bronze,
  silver,
  gold,
  platinum;

  static MemberTier fromKey(String key) =>
      values.firstWhere((tier) => tier.name == key, orElse: () => bronze);
}

/// The single member record that Home and Rewards both read.
final class Member extends Equatable {
  const Member({
    required this.id,
    required this.name,
    required this.photo,
    required this.tier,
    required this.pointsToNextTier,
    required this.totalPoints,
    required this.tierProgress,
    required this.notificationCount,
    required this.rewardsCount,
    this.nextTier,
  });

  final String id;
  final String name;
  final ImageRef photo;
  final MemberTier tier;

  /// Null at the top tier.
  final MemberTier? nextTier;
  final int pointsToNextTier;
  final int totalPoints;

  /// 0..1 progress from [tier] towards [nextTier].
  final double tierProgress;
  final int notificationCount;
  final int rewardsCount;

  @override
  List<Object?> get props => [
    id,
    name,
    photo,
    tier,
    nextTier,
    pointsToNextTier,
    totalPoints,
    tierProgress,
    notificationCount,
    rewardsCount,
  ];
}
