import 'dart:io';

/// Build-time settings. Override with `--dart-define`, e.g.
/// `--dart-define=API_BASE_URL=http://192.168.1.20:8080`.
final class AppConfig {
  const AppConfig({
    required this.apiBaseUrl,
    this.fakeAuthDelay = const Duration(seconds: 1),
    this.reachabilityHost = 'example.com',
    this.enableNetworkImages = true,
  });

  factory AppConfig.fromEnvironment() {
    const defined = String.fromEnvironment('API_BASE_URL');
    return AppConfig(apiBaseUrl: defined.isNotEmpty ? defined : _defaultBaseUrl());
  }

  /// The mock server. Public data is refreshed from here; the app works
  /// fully without it.
  final String apiBaseUrl;

  /// How long the fake auth repository "talks to the server".
  final Duration fakeAuthDelay;

  /// Looked up to tell "connected to Wi-Fi" from "actually online".
  final String reachabilityHost;

  /// Off in widget tests, where there is no network or disk cache.
  final bool enableNetworkImages;

  /// The Android emulator reaches the host machine on 10.0.2.2; the iOS
  /// simulator shares the host's localhost.
  static String _defaultBaseUrl() =>
      Platform.isAndroid ? 'http://10.0.2.2:8080' : 'http://localhost:8080';
}
