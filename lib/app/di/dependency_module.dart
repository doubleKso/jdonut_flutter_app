import 'package:get_it/get_it.dart';

/// Registers one area's dependencies. Each feature owns one.
abstract interface class DependencyModule {
  void register(GetIt getIt);
}
