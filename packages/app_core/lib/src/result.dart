import 'failures.dart';

/// The outcome of an operation: an [Ok] value or an [Err] carrying a typed
/// [Failure]. Repositories and use cases return this instead of throwing.
sealed class Result<T> {
  const Result();

  const factory Result.success(T value) = Ok<T>;
  const factory Result.failure(Failure failure) = Err<T>;

  bool get isSuccess => this is Ok<T>;
  bool get isFailure => this is Err<T>;

  T? get dataOrNull => switch (this) {
    Ok<T>(:final value) => value,
    Err<T>() => null,
  };

  Failure? get failureOrNull => switch (this) {
    Ok<T>() => null,
    Err<T>(:final failure) => failure,
  };

  R fold<R>(R Function(Failure failure) onFailure, R Function(T value) onSuccess) =>
      switch (this) {
        Ok<T>(:final value) => onSuccess(value),
        Err<T>(:final failure) => onFailure(failure),
      };

  Result<R> map<R>(R Function(T value) transform) => switch (this) {
    Ok<T>(:final value) => Ok<R>(transform(value)),
    Err<T>(:final failure) => Err<R>(failure),
  };
}

final class Ok<T> extends Result<T> {
  const Ok(this.value);

  final T value;
}

final class Err<T> extends Result<T> {
  const Err(this.failure);

  final Failure failure;
}
