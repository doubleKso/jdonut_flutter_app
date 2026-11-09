import 'package:app_core/app_core.dart';
import 'package:equatable/equatable.dart';

/// The state of one independently-loading part of a screen.
sealed class SectionState<T> extends Equatable {
  const SectionState();

  @override
  List<Object?> get props => [];
}

final class SectionLoading<T> extends SectionState<T> {
  const SectionLoading();
}

final class SectionLoaded<T> extends SectionState<T> {
  const SectionLoaded(this.data);

  final T data;

  @override
  List<Object?> get props => [data];
}

final class SectionEmpty<T> extends SectionState<T> {
  const SectionEmpty();
}

final class SectionError<T> extends SectionState<T> {
  const SectionError(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

/// Turns a stream value into a section state: empty lists and nulls are
/// "empty", anything else is "loaded".
SectionState<T> sectionFrom<T>(T? value) {
  if (value == null) return SectionEmpty<T>();
  if (value is Iterable && value.isEmpty) return SectionEmpty<T>();
  return SectionLoaded<T>(value);
}
