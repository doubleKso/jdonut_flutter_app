import 'package:equatable/equatable.dart';

import '../../../../core/domain/image_ref.dart';

/// How a challenge card draws its progress: a donut colouring in by
/// quarters, or an arc filling over a cup.
enum ChallengeArt {
  donut,
  arc;

  static ChallengeArt fromKey(String key) =>
      values.firstWhere((art) => art.name == key, orElse: () => arc);
}

/// The two Rewards tabs: "Eat more earn more" and "Gift".
enum RewardsTab {
  earn,
  gift;

  static RewardsTab fromKey(String key) =>
      values.firstWhere((tab) => tab.name == key, orElse: () => earn);
}

final class Challenge extends Equatable {
  const Challenge({
    required this.id,
    required this.title,
    required this.art,
    required this.tab,
    required this.progress,
    required this.target,
    required this.rewardPoints,
    required this.image,
  });

  final String id;
  final String title;
  final ChallengeArt art;
  final RewardsTab tab;
  final int progress;
  final int target;
  final int rewardPoints;
  final ImageRef image;

  bool get isComplete => progress >= target;

  /// 0..1, for the artwork.
  double get fraction => target <= 0 ? 0 : (progress / target).clamp(0, 1).toDouble();

  @override
  List<Object?> get props => [id, title, art, tab, progress, target, rewardPoints, image];
}
