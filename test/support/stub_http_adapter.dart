import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// Answers Dio requests from a path → JSON map, or fails like a dead network.
final class StubHttpAdapter implements HttpClientAdapter {
  StubHttpAdapter({this.responses = const {}, this.offline = false});

  final Map<String, Object?> responses;
  final bool offline;
  final List<String> requestedPaths = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requestedPaths.add(options.path);
    if (offline) {
      throw DioException.connectionError(requestOptions: options, reason: 'Airplane mode');
    }
    final body = responses[options.path];
    if (body == null) return ResponseBody.fromString('{}', 404, headers: _json);
    return ResponseBody.fromString(jsonEncode(body), 200, headers: _json);
  }

  static const Map<String, List<String>> _json = {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  };

  @override
  void close({bool force = false}) {}
}

/// Wraps [data] in the API's `{data, error, meta}` envelope.
Map<String, Object?> envelope(Object? data) => {
  'data': data,
  'error': null,
  'meta': {'version': 'v1', 'generatedAt': '2026-11-09T00:00:00Z'},
};
