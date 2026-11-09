import 'dart:async';

import 'package:app_core/app_core.dart';
import 'package:clock/clock.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/auth_entities.dart';
import '../../domain/failures/auth_failure.dart';
import '../../domain/usecases/auth_use_cases.dart';
import '../../domain/validators/otp_validator.dart';
import '../../domain/validators/phone_validator.dart';

enum OtpStatus { entering, verifying, verified, resending }

/// Why the last attempt did not go through.
enum OtpProblem { incorrect, locked, failed }

final class OtpState extends Equatable {
  const OtpState({
    required this.resendIn,
    this.code = '',
    this.status = OtpStatus.entering,
    this.wrongAttempts = 0,
    this.problem,
    this.shakeCount = 0,
    this.resentCount = 0,
    this.session,
  });

  final String code;
  final OtpStatus status;
  final int wrongAttempts;
  final OtpProblem? problem;

  /// Time until "Resend" becomes available.
  final Duration resendIn;

  /// Bumped on every wrong code — the boxes shake when it changes.
  final int shakeCount;

  /// Bumped after a successful resend.
  final int resentCount;

  /// Set when logging in succeeds.
  final AuthSession? session;

  bool get isLocked => wrongAttempts >= OtpPolicy.maxAttempts;
  bool get canResend => resendIn == Duration.zero && status != OtpStatus.resending;
  bool get canEdit => !isLocked && status == OtpStatus.entering;
  bool get canVerify => canEdit && isCompleteOtp(code);
  int get remainingAttempts => remainingOtpAttempts(wrongAttempts);

  OtpState copyWith({
    String? code,
    OtpStatus? status,
    int? wrongAttempts,
    OtpProblem? problem,
    bool clearProblem = false,
    Duration? resendIn,
    int? shakeCount,
    int? resentCount,
    AuthSession? session,
  }) => OtpState(
    code: code ?? this.code,
    status: status ?? this.status,
    wrongAttempts: wrongAttempts ?? this.wrongAttempts,
    problem: clearProblem ? null : problem ?? this.problem,
    resendIn: resendIn ?? this.resendIn,
    shakeCount: shakeCount ?? this.shakeCount,
    resentCount: resentCount ?? this.resentCount,
    session: session ?? this.session,
  );

  @override
  List<Object?> get props => [
    code,
    status,
    wrongAttempts,
    problem,
    resendIn,
    shakeCount,
    resentCount,
    session,
  ];
}

/// package:clock's clock — fake-able in tests, unlike `DateTime.now`.
Clock get _systemClock => clock;

/// The verify step: code entry, three-strike lock, and the resend countdown.
final class OtpCubit extends Cubit<OtpState> {
  OtpCubit({
    required this._verifyOtp,
    required this._requestOtp,
    required this.phone,
    required this.flow,
    DateTime Function()? clock,
  }) : _clock = clock ?? _systemClock.now,
       super(const OtpState(resendIn: OtpPolicy.resendCooldown)) {
    _restartCountdown();
  }

  final VerifyOtpUseCase _verifyOtp;
  final RequestOtpUseCase _requestOtp;
  final String phone;
  final AuthFlow flow;
  final DateTime Function() _clock;
  static const Duration _tick = Duration(seconds: 1);
  Timer? _timer;
  late DateTime _resendAt;

  void codeChanged(String raw) {
    if (!state.canEdit) return;
    emit(state.copyWith(code: sanitizeOtpInput(raw), clearProblem: true));
    if (state.canVerify) unawaited(verify());
  }

  Future<void> verify() async {
    if (!state.canVerify) return;
    emit(state.copyWith(status: OtpStatus.verifying));
    final result = await _verifyOtp(VerifyOtpParams(phone: phone, code: state.code, flow: flow));
    if (isClosed) return;
    result.fold(_onVerifyFailed, (session) => emit(state.copyWith(status: OtpStatus.verified, session: session)));
  }

  void _onVerifyFailed(Failure failure) {
    if (failure is! InvalidOtpFailure) {
      emit(state.copyWith(status: OtpStatus.entering, problem: OtpProblem.failed));
      return;
    }
    final wrong = state.wrongAttempts + 1;
    emit(
      state.copyWith(
        code: '',
        status: OtpStatus.entering,
        wrongAttempts: wrong,
        problem: wrong >= OtpPolicy.maxAttempts ? OtpProblem.locked : OtpProblem.incorrect,
        shakeCount: state.shakeCount + 1,
      ),
    );
  }

  /// Sends a new code, restarts the timer and unlocks entry.
  Future<void> resend() async {
    if (!state.canResend) return;
    emit(state.copyWith(status: OtpStatus.resending));
    final input = phone.replaceFirst(myanmarCountryCode, '');
    final result = await _requestOtp(RequestOtpParams(phoneInput: input, flow: flow));
    if (isClosed) return;
    if (result.isFailure) {
      emit(state.copyWith(status: OtpStatus.entering, problem: OtpProblem.failed));
      return;
    }
    _restartCountdown();
    emit(OtpState(resendIn: OtpPolicy.resendCooldown, resentCount: state.resentCount + 1));
  }

  void _restartCountdown() {
    _resendAt = _clock().add(OtpPolicy.resendCooldown);
    _timer?.cancel();
    _timer = Timer.periodic(_tick, (_) => _onTick());
  }

  void _onTick() {
    final left = _resendAt.difference(_clock());
    final resendIn = left.isNegative ? Duration.zero : Duration(seconds: left.inSeconds);
    if (resendIn == Duration.zero) _timer?.cancel();
    if (!isClosed) emit(state.copyWith(resendIn: resendIn));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
