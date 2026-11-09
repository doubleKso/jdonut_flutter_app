import 'package:app_storage/app_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/core/database/app_database.dart';
import 'package:jdonuts/features/auth/data/fake_auth_repository.dart';
import 'package:jdonuts/features/auth/data/session_store.dart';
import 'package:jdonuts/features/auth/data/user_local_data_source.dart';
import 'package:jdonuts/features/auth/domain/entities/auth_entities.dart';
import 'package:jdonuts/features/auth/domain/failures/auth_failure.dart';

import '../../../support/test_database.dart';

void main() {
  const phone = '+959254135592';
  late AppDatabase db;
  late SessionStore sessions;
  late FakeAuthRepository repository;

  setUp(() {
    db = newTestDatabase();
    sessions = SessionStore(InMemorySecureStorageService());
    repository = FakeAuthRepository(users: UserLocalDataSource(db), sessions: sessions, latency: Duration.zero);
  });

  tearDown(() => db.close());

  Future<void> register() async {
    await repository.saveName(phone: phone, firstName: 'Ye Min', lastName: 'Phyoe Win');
    await repository.completeRegistration(phone: phone, dateOfBirth: DateTime(1980, 5));
  }

  test('only 123456 is accepted as the code', () async {
    final wrong = await repository.verifyOtp(phone: phone, code: '654321', flow: AuthFlow.register);
    final right = await repository.verifyOtp(phone: phone, code: FakeAuthRepository.acceptedOtp, flow: AuthFlow.register);

    expect(wrong.failureOrNull, isA<InvalidOtpFailure>());
    expect(right.isSuccess, isTrue);
  });

  test('logging in with a number that never registered is refused', () async {
    final result = await repository.requestOtp(phone: phone, flow: AuthFlow.login);

    expect(result.failureOrNull, isA<PhoneNotRegisteredFailure>());
  });

  test('registering a number that already has an account is refused', () async {
    await register();

    final result = await repository.requestOtp(phone: phone, flow: AuthFlow.register);

    expect(result.failureOrNull, isA<PhoneAlreadyRegisteredFailure>());
  });

  test('a half-finished registration is not an account yet', () async {
    await repository.saveName(phone: phone, firstName: 'Ye Min');

    final result = await repository.requestOtp(phone: phone, flow: AuthFlow.login);

    expect(result.failureOrNull, isA<PhoneNotRegisteredFailure>());
  });

  test('completing registration signs in and the session survives a restart', () async {
    await register();

    final restarted = FakeAuthRepository(users: UserLocalDataSource(db), sessions: sessions, latency: Duration.zero);
    final session = await restarted.currentSession();

    expect(session?.phone, phone);
    expect(session?.displayName, 'Ye Min Phyoe Win');
  });

  test('logging in after logging out restores a session with the stored name', () async {
    await register();
    await repository.logOut();
    expect(await repository.currentSession(), isNull);

    final result = await repository.verifyOtp(phone: phone, code: FakeAuthRepository.acceptedOtp, flow: AuthFlow.login);

    expect(result.dataOrNull?.displayName, 'Ye Min Phyoe Win');
    expect(await repository.currentSession(), isNotNull);
  });
}
