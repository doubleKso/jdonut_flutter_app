import 'package:get_it/get_it.dart';

import '../../core/connectivity/connectivity_cubit.dart';
import '../../features/auth/presentation/cubit/session_cubit.dart';
import '../sync/catalog_sync_coordinator.dart';
import 'seed_service.dart';

/// Must finish before the first frame: the database holds the seed data,
/// and the session is restored so the router opens on the right screen.
Future<void> runCriticalStartup(GetIt getIt) async {
  await getIt<SeedService>().seedIfNeeded();
  await getIt<SessionCubit>().restore();
}

/// Runs after the first frame: reachability and the background refresh.
void startBackgroundWork(GetIt getIt) {
  getIt<ConnectivityCubit>().start();
  getIt<CatalogSyncCoordinator>().start();
}
