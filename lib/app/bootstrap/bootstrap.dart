import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../core/config/app_config.dart';
import '../app.dart';
import '../di/core_module.dart';
import '../di/injection.dart';
import 'startup.dart';

/// Keeps `main` to one line: error hooks, DI, critical startup, first
/// frame, then background work.
Future<void> bootstrap() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      _configureErrorHooks();
      final getIt = await configureDependencies(CoreModule(config: AppConfig.fromEnvironment()));
      await runCriticalStartup(getIt);
      runApp(JDonutsApp(getIt: getIt));
      startBackgroundWork(getIt);
    },
    (error, stack) => developer.log('Uncaught error', name: 'app', error: error, stackTrace: stack),
  );
}

void _configureErrorHooks() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    developer.log('Flutter error', name: 'app', error: details.exception, stackTrace: details.stack);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    developer.log('Platform error', name: 'app', error: error, stackTrace: stack);
    return true;
  };
}
