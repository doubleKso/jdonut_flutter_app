import 'package:equatable/equatable.dart';

/// A typed, expected failure returned inside a [Result].
///
/// Abstract rather than sealed so each feature can add its own failures
/// (for example a sealed `AuthFailure` family) while sharing this base.
/// [message] is for logs; the UI maps the failure TYPE to localised text.
abstract class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

/// The device could not reach the server (offline, DNS, timeout).
final class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// The server answered with an error.
final class ServerFailure extends Failure {
  const ServerFailure(super.message, {this.statusCode});

  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

/// Reading or writing the local database failed.
final class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// A payload could not be parsed.
final class ParsingFailure extends Failure {
  const ParsingFailure(super.message);
}

/// The requested record does not exist.
final class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}

/// Anything not covered above. Logged, never swallowed.
final class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message);
}
