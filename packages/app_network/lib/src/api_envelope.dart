/// The `/v1` response shape: `{data, error, meta}`.
///
/// Exactly one of [data] and [error] is set.
final class ApiEnvelope<T> {
  const ApiEnvelope({this.data, this.error, this.meta = const ApiMeta()});

  /// Parses [json], turning `data` into [T] with [parseData].
  factory ApiEnvelope.fromJson(
    Map<String, dynamic> json,
    T Function(Object? data) parseData,
  ) {
    final error = json['error'];
    return ApiEnvelope<T>(
      data: error == null ? parseData(json['data']) : null,
      error: error is Map<String, dynamic> ? ApiError.fromJson(error) : null,
      meta: ApiMeta.fromJson(json['meta']),
    );
  }

  final T? data;
  final ApiError? error;
  final ApiMeta meta;
}

final class ApiError {
  const ApiError({required this.code, required this.message});

  factory ApiError.fromJson(Map<String, dynamic> json) => ApiError(
    code: json['code'] as String? ?? 'unknown',
    message: json['message'] as String? ?? '',
  );

  final String code;
  final String message;
}

final class ApiMeta {
  const ApiMeta({this.version = '', this.generatedAt});

  factory ApiMeta.fromJson(Object? json) {
    if (json is! Map<String, dynamic>) return const ApiMeta();
    return ApiMeta(
      version: json['version'] as String? ?? '',
      generatedAt: DateTime.tryParse(json['generatedAt'] as String? ?? ''),
    );
  }

  final String version;
  final DateTime? generatedAt;
}
