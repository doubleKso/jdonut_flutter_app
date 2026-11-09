import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts/app/router/auth_guard.dart';
import 'package:jdonuts/app/router/route_paths.dart';

void main() {
  group('signed out', () {
    String? redirect(String location) => authRedirect(signedIn: false, location: location);

    test('stays on onboarding, register and log-in screens', () {
      expect(redirect(RoutePaths.onboarding), isNull);
      expect(redirect(RoutePaths.registerName), isNull);
      expect(redirect(RoutePaths.loginOtp), isNull);
    });

    test('is sent to onboarding from Home, Rewards, Product detail and Welcome', () {
      for (final location in [RoutePaths.home, RoutePaths.rewards, RoutePaths.product('p_coconut'), RoutePaths.welcome]) {
        expect(redirect(location), RoutePaths.onboarding, reason: location);
      }
    });
  });

  group('signed in', () {
    String? redirect(String location) => authRedirect(signedIn: true, location: location);

    test('a just-finished registration goes on to Welcome', () {
      expect(redirect(RoutePaths.registerDateOfBirth), RoutePaths.welcome);
    });

    test('onboarding and the log-in screens go to Home', () {
      expect(redirect(RoutePaths.onboarding), RoutePaths.home);
      expect(redirect(RoutePaths.loginOtp), RoutePaths.home);
    });

    test('Home, Rewards, Product detail and Welcome are open', () {
      for (final location in [RoutePaths.home, RoutePaths.rewards, RoutePaths.product('p_coconut'), RoutePaths.welcome]) {
        expect(redirect(location), isNull, reason: location);
      }
    });
  });
}
