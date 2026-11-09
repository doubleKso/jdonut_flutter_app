import 'package:get_it/get_it.dart';

import '../../../app/di/dependency_module.dart';
import '../data/datasources/catalog_local_data_source.dart';
import '../data/datasources/catalog_remote_data_source.dart';
import '../data/repositories/home_repository_impl.dart';
import '../domain/repositories/home_repository.dart';
import '../domain/usecases/home_use_cases.dart';
import '../presentation/cubit/home_cubit.dart';

final class HomeModule implements DependencyModule {
  const HomeModule();

  @override
  void register(GetIt getIt) {
    getIt
      ..registerLazySingleton(() => CatalogLocalDataSource(getIt()))
      ..registerLazySingleton(() => CatalogRemoteDataSource(getIt()))
      ..registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(local: getIt(), remote: getIt(), productMapper: getIt(), urls: getIt()),
      )
      ..registerFactory(() => WatchBannersUseCase(getIt()))
      ..registerFactory(() => WatchSectionsUseCase(getIt()))
      ..registerFactory(() => WatchShopsUseCase(getIt()))
      ..registerFactory(() => RefreshCatalogUseCase(getIt()))
      ..registerFactory(
        () => HomeCubit(
          watchMember: getIt(),
          watchBanners: getIt(),
          watchSections: getIt(),
          watchShops: getIt(),
          refreshCatalog: getIt(),
        ),
      );
  }
}
