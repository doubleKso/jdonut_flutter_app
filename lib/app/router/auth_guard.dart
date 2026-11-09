import 'route_paths.dart';

/// Where to send the user instead of [location], or null to let them in.
///
/// - Signed out: only onboarding, register and log-in screens are open.
/// - Signed in: a finished registration goes on to Welcome; onboarding and
///   the log-in screens go to Home.
String? authRedirect({required bool signedIn, required String location}) {
  final inRegistration = location.startsWith(RoutePaths.registerPrefix);
  final inLogin = location.startsWith(RoutePaths.loginPrefix);
  final onOnboarding = location == RoutePaths.onboarding;

  if (!signedIn) return inRegistration || inLogin || onOnboarding ? null : RoutePaths.onboarding;
  if (inRegistration) return RoutePaths.welcome;
  if (inLogin || onOnboarding) return RoutePaths.home;
  return null;
}
