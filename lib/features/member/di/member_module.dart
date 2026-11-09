import 'package:get_it/get_it.dart';

import '../../../app/di/dependency_module.dart';
import '../data/member_local_data_source.dart';
import '../data/member_repository_impl.dart';
import '../domain/repositories/member_repository.dart';
import '../domain/usecases/watch_member_use_case.dart';

final class MemberModule implements DependencyModule {
  const MemberModule();

  @override
  void register(GetIt getIt) {
    getIt
      ..registerLazySingleton(() => MemberLocalDataSource(getIt()))
      ..registerLazySingleton<MemberRepository>(() => MemberRepositoryImpl(getIt(), getIt()))
      ..registerFactory(() => WatchMemberUseCase(getIt()));
  }
}
