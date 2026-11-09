import 'package:dio/dio.dart';

import 'interceptors/logging_interceptor.dart';
import 'interceptors/retry_interceptor.dart';
import 'network_config.dart';

/// Builds the one configured [Dio] the app uses.
abstract final class DioFactory {
  static Dio create(NetworkConfig config, {LogSink? log}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        connectTimeout: config.connectTimeout,
        receiveTimeout: config.receiveTimeout,
        sendTimeout: config.connectTimeout,
        responseType: ResponseType.json,
      ),
    );
    dio.interceptors.add(
      RetryInterceptor(
        dio: dio,
        maxRetries: config.maxRetries,
        baseDelay: config.retryBaseDelay,
      ),
    );
    if (config.enableLogging) {
      dio.interceptors.add(LoggingInterceptor(log: log));
    }
    return dio;
  }
}
