import 'dart:async';
import 'dart:developer' as developer;

import 'package:app_core/app_core.dart';

import '../../core/connectivity/connectivity_cubit.dart';
import '../../features/home/domain/usecases/home_use_cases.dart';

/// Refreshes the public catalogue in the background: once at startup when
/// online, and again every time the device comes back online.
final class CatalogSyncCoordinator {
  CatalogSyncCoordinator({required this._connectivity, required this._refreshCatalog});

  final ConnectivityCubit _connectivity;
  final RefreshCatalogUseCase _refreshCatalog;
  StreamSubscription<ConnectivityStatus>? _subscription;
  Future<Result<void>>? _inFlight;

  void start() {
    _subscription ??= _connectivity.stream
        .where((status) => status.isOnline)
        .listen((_) => unawaited(syncNow()));
    if (_connectivity.state.isOnline) unawaited(syncNow());
  }

  /// Runs one refresh; a second call while one is running joins it.
  Future<Result<void>> syncNow() => _inFlight ??= _run();

  Future<Result<void>> _run() async {
    try {
      final result = await _refreshCatalog(const NoParams());
      final failure = result.failureOrNull;
      if (failure != null) {
        developer.log('Background refresh failed: ${failure.message}', name: 'sync');
      }
      return result;
    } finally {
      _inFlight = null;
    }
  }

  Future<void> dispose() async => _subscription?.cancel();
}
