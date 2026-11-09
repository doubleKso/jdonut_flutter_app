import 'package:app_network/app_network.dart';
import 'package:test/test.dart';

void main() {
  group('ApiEnvelope', () {
    test('parses data and meta when there is no error', () {
      final envelope = ApiEnvelope<List<int>>.fromJson(
        {
          'data': [1, 2],
          'error': null,
          'meta': {'version': 'v1', 'generatedAt': '2026-11-01T00:00:00Z'},
        },
        (data) => (data! as List).cast<int>(),
      );

      expect(envelope.data, [1, 2]);
      expect(envelope.error, isNull);
      expect(envelope.meta.version, 'v1');
      expect(envelope.meta.generatedAt, DateTime.utc(2026, 11));
    });

    test('exposes the error and skips data parsing when the server failed', () {
      var parsed = false;
      final envelope = ApiEnvelope<int>.fromJson(
        {
          'data': null,
          'error': {'code': 'maintenance', 'message': 'Down for upgrade'},
          'meta': {},
        },
        (_) {
          parsed = true;
          return 0;
        },
      );

      expect(parsed, isFalse);
      expect(envelope.error?.code, 'maintenance');
      expect(envelope.error?.message, 'Down for upgrade');
    });
  });
}
