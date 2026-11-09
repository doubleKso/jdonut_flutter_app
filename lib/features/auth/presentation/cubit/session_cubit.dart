import 'dart:async';

import 'package:app_core/app_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/auth_entities.dart';
import '../../domain/usecases/auth_use_cases.dart';

/// The signed-in session, app-wide. The router's redirect guard and the
/// Settings tab read it.
final class SessionCubit extends Cubit<AuthSession?> {
  SessionCubit({
    required this._getCurrentSession,
    required this._watchSession,
    required this._logOut,
  }) : super(null);

  final GetCurrentSessionUseCase _getCurrentSession;
  final WatchSessionUseCase _watchSession;
  final LogOutUseCase _logOut;
  StreamSubscription<AuthSession?>? _subscription;

  bool get isSignedIn => state != null;

  /// Restores the session from secure storage before the first frame, so a
  /// relaunch while signed in opens straight on Home.
  Future<void> restore() async {
    _subscription ??= _watchSession(const NoParams()).listen(emit);
    final result = await _getCurrentSession(const NoParams());
    emit(result.dataOrNull);
  }

  Future<Result<void>> logOut() => _logOut(const NoParams());

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
