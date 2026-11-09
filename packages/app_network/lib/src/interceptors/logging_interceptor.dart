import 'dart:developer' as developer;

import 'package:dio/dio.dart';

/// Where log lines go; defaults to `dart:developer` so nothing hits `print`.
typedef LogSink = void Function(String message);

/// Logs method, URL, status and duration of every request.
final class LoggingInterceptor extends Interceptor {
  LoggingInterceptor({LogSink? log}) : _log = log ?? _developerLog;

  static const String _startedAtKey = 'logging_started_at';
  final LogSink _log;

  static void _developerLog(String message) => developer.log(message, name: 'http');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra[_startedAtKey] = DateTime.now();
    _log('→ ${options.method} ${options.uri}');
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    _log('← ${response.statusCode} ${response.requestOptions.uri} '
        '(${_elapsed(response.requestOptions)} ms)');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _log('✕ ${err.type.name} ${err.requestOptions.uri} '
        '(${_elapsed(err.requestOptions)} ms): ${err.message}');
    handler.next(err);
  }

  int _elapsed(RequestOptions options) {
    final startedAt = options.extra[_startedAtKey] as DateTime?;
    if (startedAt == null) return 0;
    return DateTime.now().difference(startedAt).inMilliseconds;
  }
}
