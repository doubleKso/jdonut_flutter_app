import 'dart:async';

import 'package:app_storage/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:jdonuts/app/app.dart';
import 'package:jdonuts/app/bootstrap/startup.dart';
import 'package:jdonuts/app/di/core_module.dart';
import 'package:jdonuts/app/di/injection.dart';
import 'package:jdonuts/core/config/app_config.dart';
import 'package:jdonuts/core/connectivity/connectivity_service.dart';

import 'test_database.dart';

/// Connectivity the test controls.
final class FakeConnectivityService implements ConnectivityService {
  FakeConnectivityService({this.online = false});

  bool online;
  final StreamController<bool> _changes = StreamController<bool>.broadcast();

  void setOnline(bool value) {
    online = value;
    _changes.add(value);
  }

  @override
  Future<bool> isOnline() async => online;

  @override
  Stream<bool> watchOnline() async* {
    yield online;
    yield* _changes.stream;
  }
}

/// How long the fake auth repository "talks to the server" in tests.
const Duration testAuthDelay = Duration(milliseconds: 300);

/// A phone-sized screen (logical 412 × 915).
const Size phoneSize = Size(412, 915);

/// Lets Drift finish closing its stream queries once the tree is gone.
const Duration _settleAfterDispose = Duration(seconds: 1);

/// Runs [body] against the real app: in-memory storage, no network, a short
/// fake auth delay and Reduce Motion on (so animations settle at once).
/// The app is torn down inside the test, so nothing is left pending.
///
/// [size] fakes the screen; pass null to keep the real one (on a device).
void testApp(
  String description,
  Future<void> Function(WidgetTester tester, GetIt getIt) body, {
  Size? size = phoneSize,
  double textScale = 1,
}) {
  testWidgets(description, (tester) async {
    final getIt = await _start(tester, size: size, textScale: textScale);
    try {
      await body(tester, getIt);
    } finally {
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(_settleAfterDispose);
      // Closing the database waits on real async work, which fake time
      // would never advance — so it runs outside the fake-async zone.
      await tester.runAsync(getIt.reset);
      tester.platformDispatcher
        ..clearAccessibilityFeaturesTestValue()
        ..clearTextScaleFactorTestValue();
      tester.view.reset();
    }
  });
}

Future<GetIt> _start(WidgetTester tester, {required Size? size, required double textScale}) async {
  if (size != null) {
    tester.view
      ..physicalSize = size * 3
      ..devicePixelRatio = 3;
  }
  tester.platformDispatcher
    ..accessibilityFeaturesTestValue = const FakeAccessibilityFeatures(disableAnimations: true)
    ..textScaleFactorTestValue = textScale;
  final getIt = await configureDependencies(
    CoreModule(
      config: const AppConfig(apiBaseUrl: 'http://localhost:9', fakeAuthDelay: testAuthDelay, enableNetworkImages: false),
      database: newTestDatabase(),
      secureStorage: InMemorySecureStorageService(),
      connectivity: FakeConnectivityService(),
    ),
  );
  await runCriticalStartup(getIt);
  await tester.pumpWidget(JDonutsApp(getIt: getIt));
  await tester.pumpAndSettle();
  return getIt;
}

/// Small helpers for driving the screens.
extension AppDriver on WidgetTester {
  Future<void> enterField(Key key, String text) async {
    await enterText(find.descendant(of: find.byKey(key), matching: find.byType(TextField)), text);
    await pump();
  }

  Future<void> tapText(String text) async {
    await ensureVisible(find.text(text).first);
    // Lay out the scrolled position before working out where to tap.
    await pump();
    await tap(find.text(text).first);
    await pumpAndSettle();
  }

  /// Waits out the fake server round trip.
  Future<void> waitForFakeCall() async {
    await pump(testAuthDelay);
    await pumpAndSettle();
  }

  Future<void> unfocus() async {
    FocusManager.instance.primaryFocus?.unfocus();
    await pumpAndSettle();
  }
}
