import 'dart:math';

import 'package:app_core/app_core.dart';

import '../domain/entities/auth_entities.dart';
import '../domain/failures/auth_failure.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/validators/otp_validator.dart';
import 'session_store.dart';
import 'user_local_data_source.dart';

/// Auth with no server: waits like a network call, keeps users in the local
/// database and the session in secure storage. Swap in a real
/// [AuthRepository] and nothing else changes.
final class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({
    required this._users,
    required this._sessions,
    this.latency = const Duration(seconds: 1),
    Random? random,
  }) : _random = random ?? Random.secure();

  /// The only code the fake server accepts.
  static const String acceptedOtp = '123456';
  static const int _tokenBytes = 16;

  final UserLocalDataSource _users;
  final SessionStore _sessions;
  final Duration latency;
  final Random _random;

  @override
  Future<Result<OtpChallenge>> requestOtp({required String phone, required AuthFlow flow}) =>
      _call(() async {
        final registered = await _users.isRegistered(phone);
        if (flow == AuthFlow.login && !registered) {
          return const Result.failure(PhoneNotRegisteredFailure());
        }
        if (flow == AuthFlow.register && registered) {
          return const Result.failure(PhoneAlreadyRegisteredFailure());
        }
        return Result.success(OtpChallenge(phone: phone, resendAfter: OtpPolicy.resendCooldown));
      });

  @override
  Future<Result<AuthSession?>> verifyOtp({
    required String phone,
    required String code,
    required AuthFlow flow,
  }) => _call(() async {
    if (code != acceptedOtp) return const Result.failure(InvalidOtpFailure());
    if (flow == AuthFlow.register) return const Result.success(null);
    return Result.success(await _signIn(phone));
  });

  @override
  Future<Result<void>> saveName({required String phone, required String firstName, String? lastName}) =>
      _call(() async {
        await _users.saveName(phone, firstName, lastName);
        return const Result.success(null);
      });

  @override
  Future<Result<AuthSession>> completeRegistration({
    required String phone,
    required DateTime dateOfBirth,
  }) => _call(() async {
    await _users.complete(phone, dateOfBirth);
    return Result.success(await _signIn(phone));
  });

  @override
  Future<AuthSession?> currentSession() async {
    final session = await _sessions.read();
    if (session == null) return null;
    // A session for an account that no longer exists is not a session.
    return await _users.isRegistered(session.phone) ? session : null;
  }

  @override
  Stream<AuthSession?> watchSession() => _sessions.changes;

  @override
  Future<Result<void>> logOut() => _call(() async {
    await _sessions.clear();
    return const Result.success(null);
  }, delay: Duration.zero);

  Future<AuthSession> _signIn(String phone) async {
    final user = await _users.find(phone);
    final session = AuthSession(
      phone: phone,
      displayName: [user?.firstName, user?.lastName].whereType<String>().join(' '),
      token: _newToken(),
      createdAt: DateTime.now(),
    );
    await _sessions.save(session);
    return session;
  }

  String _newToken() =>
      List.generate(_tokenBytes, (_) => _random.nextInt(256).toRadixString(16).padLeft(2, '0')).join();

  /// Simulates the round trip and turns storage errors into typed failures.
  Future<Result<T>> _call<T>(Future<Result<T>> Function() body, {Duration? delay}) async {
    await Future<void>.delayed(delay ?? latency);
    try {
      return await body();
    } on Exception catch (e) {
      return Result.failure(AuthStorageFailure('$e'));
    }
  }
}
