import 'result.dart';

/// An application action with input [Params] that returns a [Result].
abstract interface class UseCase<T, Params> {
  Future<Result<T>> call(Params params);
}

/// An action that exposes a live stream, e.g. a database watch.
abstract interface class StreamUseCase<T, Params> {
  Stream<T> call(Params params);
}

/// Marker params for use cases that take no input.
final class NoParams {
  const NoParams();
}
