import 'package:get_it/get_it.dart';

import '../../features/auth/di/auth_module.dart';
import '../../features/home/di/home_module.dart';
import '../../features/member/di/member_module.dart';
import '../../features/product/di/product_module.dart';
import '../../features/rewards/di/rewards_module.dart';
import '../bootstrap/seed_service.dart';
import '../router/app_router.dart';
import '../sync/catalog_sync_coordinator.dart';
import 'core_module.dart';
import 'dependency_module.dart';

final GetIt getIt = GetIt.instance;

/// Wires the app. Tests pass a [core] module with their overrides.
Future<GetIt> configureDependencies(CoreModule core) async {
  await getIt.reset();
  final modules = <DependencyModule>[
    core,
    const MemberModule(),
    const AuthModule(),
    const ProductModule(),
    const HomeModule(),
    const RewardsModule(),
    const _AppModule(),
  ];
  for (final module in modules) {
    module.register(getIt);
  }
  return getIt;
}

/// App-level services that span features.
final class _AppModule implements DependencyModule {
  const _AppModule();

  @override
  void register(GetIt getIt) {
    getIt
      ..registerLazySingleton(
        () => SeedService(db: getIt(), bundle: getIt(), catalogLocal: getIt(), memberLocal: getIt()),
      )
      ..registerLazySingleton(
        () => CatalogSyncCoordinator(connectivity: getIt(), refreshCatalog: getIt()),
        dispose: (sync) => sync.dispose(),
      )
      ..registerLazySingleton(() => AppRouter(session: getIt(), getIt: getIt));
  }
}
