import 'package:app_core/app_core.dart';

import '../entities/challenge.dart';
import '../repositories/rewards_repository.dart';

final class WatchChallengesUseCase implements StreamUseCase<List<Challenge>, RewardsTab> {
  const WatchChallengesUseCase(this._repository);

  final RewardsRepository _repository;

  @override
  Stream<List<Challenge>> call(RewardsTab tab) => _repository.watchChallenges(tab);
}
