import '../entities/challenge.dart';

abstract interface class RewardsRepository {
  /// The challenges listed under [tab], in display order.
  Stream<List<Challenge>> watchChallenges(RewardsTab tab);
}
