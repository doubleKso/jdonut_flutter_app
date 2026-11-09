/// Connection settings for the API client.
final class NetworkConfig {
  const NetworkConfig({
    required this.baseUrl,
    this.connectTimeout = const Duration(seconds: 5),
    this.receiveTimeout = const Duration(seconds: 10),
    this.maxRetries = 2,
    this.retryBaseDelay = const Duration(milliseconds: 400),
    this.enableLogging = true,
  });

  final String baseUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;

  /// Extra attempts for an idempotent request that failed on the network.
  final int maxRetries;

  /// First retry waits this long; each further retry waits one more step.
  final Duration retryBaseDelay;
  final bool enableLogging;
}
