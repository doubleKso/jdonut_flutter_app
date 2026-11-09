import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'connectivity_service.dart';

enum ConnectivityStatus {
  /// Not checked yet — show nothing rather than guess.
  unknown,
  online,
  offline;

  bool get isOnline => this == online;
  bool get isOffline => this == offline;
}

/// App-wide reachability. The offline banner and the background catalogue
/// refresh both listen to this one cubit.
final class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  ConnectivityCubit(this._service) : super(ConnectivityStatus.unknown);

  final ConnectivityService _service;
  StreamSubscription<bool>? _subscription;

  void start() {
    _subscription ??= _service.watchOnline().listen(
      (online) => emit(online ? ConnectivityStatus.online : ConnectivityStatus.offline),
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
