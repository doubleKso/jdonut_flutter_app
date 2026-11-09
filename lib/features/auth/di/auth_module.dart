import 'package:get_it/get_it.dart';

import '../../../app/di/dependency_module.dart';
import '../../../core/config/app_config.dart';
import '../data/fake_auth_repository.dart';
import '../data/session_store.dart';
import '../data/user_local_data_source.dart';
import '../domain/entities/auth_entities.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/auth_use_cases.dart';
import '../presentation/cubit/otp_cubit.dart';
import '../presentation/cubit/session_cubit.dart';
import '../presentation/cubit/step_submit_cubit.dart';

final class AuthModule implements DependencyModule {
  const AuthModule();

  @override
  void register(GetIt getIt) {
    getIt
      ..registerLazySingleton(() => UserLocalDataSource(getIt()))
      ..registerLazySingleton(() => SessionStore(getIt()))
      ..registerLazySingleton<AuthRepository>(
        () => FakeAuthRepository(users: getIt(), sessions: getIt(), latency: getIt<AppConfig>().fakeAuthDelay),
      )
      ..registerFactory(() => RequestOtpUseCase(getIt()))
      ..registerFactory(() => VerifyOtpUseCase(getIt(), getIt()))
      ..registerFactory(() => SaveNameUseCase(getIt()))
      ..registerFactory(() => CompleteRegistrationUseCase(getIt(), getIt()))
      ..registerFactory(() => GetCurrentSessionUseCase(getIt()))
      ..registerFactory(() => WatchSessionUseCase(getIt()))
      ..registerFactory(() => LogOutUseCase(getIt()))
      ..registerLazySingleton(
        () => SessionCubit(getCurrentSession: getIt(), watchSession: getIt(), logOut: getIt()),
        dispose: (cubit) => cubit.close(),
      )
      ..registerFactory(() => PhoneStepCubit(getIt()))
      ..registerFactory(() => NameStepCubit(getIt()))
      ..registerFactory(() => DateOfBirthStepCubit(getIt()))
      ..registerFactoryParam<OtpCubit, String, AuthFlow>(
        (phone, flow) => OtpCubit(verifyOtp: getIt(), requestOtp: getIt(), phone: phone, flow: flow),
      );
  }
}
