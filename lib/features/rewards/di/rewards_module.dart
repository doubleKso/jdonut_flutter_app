import 'package:get_it/get_it.dart';

import '../../../app/di/dependency_module.dart';
import '../data/rewards_repository_impl.dart';
import '../domain/repositories/rewards_repository.dart';
import '../domain/usecases/watch_challenges_use_case.dart';
import '../presentation/cubit/rewards_cubit.dart';

final class RewardsModule implements DependencyModule {
  const RewardsModule();

  @override
  void register(GetIt getIt) {
    getIt
      ..registerLazySingleton<RewardsRepository>(() => RewardsRepositoryImpl(getIt()))
      ..registerFactory(() => WatchChallengesUseCase(getIt()))
      ..registerFactory(() => RewardsCubit(watchMember: getIt(), watchChallenges: getIt()));
  }
}
