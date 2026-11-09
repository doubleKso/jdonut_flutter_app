import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/auth_entities.dart';

final class AuthFlowState extends Equatable {
  const AuthFlowState({required this.flow, this.phone});

  final AuthFlow flow;

  /// E.164 number a code was sent to; set by the phone step.
  final String? phone;

  @override
  List<Object?> get props => [flow, phone];
}

/// Lives for one pass through the register or log-in screens and carries
/// what later steps need from earlier ones. Field values themselves survive
/// the back arrow because earlier steps stay on the navigation stack.
final class AuthFlowCubit extends Cubit<AuthFlowState> {
  AuthFlowCubit(AuthFlow flow) : super(AuthFlowState(flow: flow));

  void phoneVerified(String phone) => emit(AuthFlowState(flow: state.flow, phone: phone));
}
