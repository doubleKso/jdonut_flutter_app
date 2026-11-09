import 'package:app_network/app_network.dart';
import 'package:app_storage/app_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';

import '../../core/config/app_config.dart';
import '../../core/connectivity/connectivity_cubit.dart';
import '../../core/connectivity/connectivity_service.dart';
import '../../core/data/image_url_resolver.dart';
import '../../core/database/app_database.dart';
import 'dependency_module.dart';

/// Shared infrastructure. Every override exists for tests: an in-memory
/// database, in-memory secure storage, a scripted connectivity service.
final class CoreModule implements DependencyModule {
  const CoreModule({
    required this.config,
    this.database,
    this.secureStorage,
    this.connectivity,
    this.bundle,
  });

  final AppConfig config;
  final AppDatabase? database;
  final SecureStorageService? secureStorage;
  final ConnectivityService? connectivity;
  final AssetBundle? bundle;

  static const String imageCacheKey = 'jdonuts_images';
  static const Duration imageStalePeriod = Duration(days: 30);
  static const int maxCachedImages = 400;

  @override
  void register(GetIt getIt) {
    getIt
      ..registerSingleton<AppConfig>(config)
      ..registerLazySingleton<AppDatabase>(() => database ?? AppDatabase(), dispose: (db) => db.close())
      ..registerLazySingleton<SecureStorageService>(() => secureStorage ?? FlutterSecureStorageService())
      ..registerLazySingleton<AssetBundle>(() => bundle ?? rootBundle)
      ..registerLazySingleton<Dio>(
        () => DioFactory.create(NetworkConfig(baseUrl: config.apiBaseUrl, enableLogging: kDebugMode)),
      )
      ..registerLazySingleton<ImageUrlResolver>(() => ImageUrlResolver(config.apiBaseUrl))
      ..registerLazySingleton<BaseCacheManager>(
        () => CacheManager(
          Config(imageCacheKey, stalePeriod: imageStalePeriod, maxNrOfCacheObjects: maxCachedImages),
        ),
      )
      ..registerLazySingleton<ConnectivityService>(
        () => connectivity ??
            DeviceConnectivityService(connectivity: Connectivity(), probe: dnsProbe(config.reachabilityHost)),
      )
      ..registerLazySingleton<ConnectivityCubit>(() => ConnectivityCubit(getIt()), dispose: (c) => c.close());
  }
}
