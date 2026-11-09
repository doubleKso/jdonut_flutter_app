import 'package:dio/dio.dart';

/// Retries idempotent requests (GET, HEAD) that failed on the network —
/// timeouts and connection errors — with a growing delay. Server errors are
/// not retried: the server answered, so asking again will not help.
final class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    required this._dio,
    required this.maxRetries,
    required this.baseDelay,
  });

  static const String attemptKey = 'retry_attempt';
  static const Set<String> _idempotentMethods = {'GET', 'HEAD'};
  static const Set<DioExceptionType> _retryableTypes = {
    DioExceptionType.connectionTimeout,
    DioExceptionType.sendTimeout,
    DioExceptionType.receiveTimeout,
    DioExceptionType.connectionError,
  };

  final Dio _dio;
  final int maxRetries;
  final Duration baseDelay;

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final options = err.requestOptions;
    final attempt = (options.extra[attemptKey] as int?) ?? 0;
    if (!_shouldRetry(err, attempt)) return handler.next(err);

    await Future<void>.delayed(baseDelay * (attempt + 1));
    options.extra[attemptKey] = attempt + 1;
    try {
      handler.resolve(await _dio.fetch<dynamic>(options));
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }

  bool _shouldRetry(DioException err, int attempt) =>
      attempt < maxRetries &&
      _retryableTypes.contains(err.type) &&
      _idempotentMethods.contains(err.requestOptions.method.toUpperCase());
}
